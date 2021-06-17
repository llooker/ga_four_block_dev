view: sessions {
  derived_table: {
    datagroup_trigger: generated_model_default_datagroup
    increment_key: "session_date"
    increment_offset: 3
    sql: with
-- obtains a list of sessions, uniquely identified by the table date, ga_session_id event parameter, ga_session_number event parameter, and the user_pseudo_id.
session_list_with_event_history as (
  select timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) session_date
      ,  (select value.int_value from UNNEST(events.event_params) where key = "ga_session_id") ga_session_id
      ,  (select value.int_value from UNNEST(events.event_params) where key = "ga_session_number") ga_session_number
      ,  events.user_pseudo_id
      -- unique key for session:
      ,  timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+')))||(select value.int_value from UNNEST(events.event_params) where key = "ga_session_id")||(select value.int_value from UNNEST(events.event_params) where key = "ga_session_number")||events.user_pseudo_id sl_key
      -- this array of structs captures all events in a session as a single nested element
      ,  ARRAY_AGG(STRUCT(timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+')))
                          ||(select value.int_value from UNNEST(events.event_params) where key = "ga_session_id")
                          ||(select value.int_value from UNNEST(events.event_params) where key = "ga_session_number")
                          ||events.user_pseudo_id as sl_key
                        , event_date
                        , event_timestamp
                        , event_name
                        , event_params
                        , event_previous_timestamp
                        , event_value_in_usd
                        , event_bundle_sequence_id
                        , event_server_timestamp_offset
                        , user_id
                        , user_pseudo_id
                        , user_properties
                        , user_first_touch_timestamp
                        , user_ltv
                        , device
                        , geo
                        , app_info
                        , traffic_source
                        , stream_id
                        , platform
                        , event_dimensions
                        , ecommerce
                        , items)) event_data
        from `adh-demo-data-review.analytics_213025502.events_*` events
        where {% incrementcondition %} timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) {%  endincrementcondition %}
        -- where timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -3 DAY)))
        --   and  timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) <= ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -3 DAY), INTERVAL 4 DAY)))
        group by 1,2,3,4,5
  ),

-- Session-Level Facts, session start, end, duration
session_facts as (
  select sl.sl_key
      ,  COUNT(ed.event_timestamp) session_event_count
      ,  COALESCE(SUM((select value.int_value from UNNEST(ed.event_params) where key = "engaged_session_event")),0) engaged_events
      ,  case when (COALESCE(SUM((select value.int_value from UNNEST(ed.event_params) where key = "engaged_session_event")),0) = 0
               and COALESCE(SUM((select coalesce(cast(value.string_value as INT64),value.int_value) from UNNEST(ed.event_params) where key = "session_engaged"))) = 0)
              then false else true end as is_engaged_session
            , case when countif(event_name = 'first_visit') = 0 then false else true end as is_first_visit_session
            , MAX(TIMESTAMP_MICROS(ed.event_timestamp)) as session_end
            , MIN(TIMESTAMP_MICROS(ed.event_timestamp)) as session_start
            , (MAX(ed.event_timestamp) - MIN(ed.event_timestamp))/(60 * 1000 * 1000) AS session_length_minutes
  from session_list_with_event_history sl
    ,  unnest(event_data) ed
  group by 1
  ),

-- Retrieves the last non-direct medium, source, and campaign from the session's page_view and user_engagement events.
session_tags as (
  select sl.sl_key
      ,  first_value((select value.string_value from unnest(ed.event_params) where key = 'medium')) over (partition by sl.session_date, sl.ga_session_id, sl.user_pseudo_id order by ed.event_timestamp desc) medium
      ,  first_value((select value.string_value from unnest(ed.event_params) where key = 'source')) over (partition by sl.session_date, sl.ga_session_id, sl.user_pseudo_id order by ed.event_timestamp desc) source
      ,  first_value((select value.string_value from unnest(ed.event_params) where key = 'campaign')) over (partition by sl.session_date, sl.ga_session_id, sl.user_pseudo_id order by ed.event_timestamp desc) campaign
      ,  first_value((select value.string_value from unnest(ed.event_params) where key = 'page_referrer')) over (partition by sl.session_date, sl.ga_session_id, sl.user_pseudo_id order by ed.event_timestamp desc) page_referrer
  from session_list_with_event_history sl
    ,  unnest(event_data) ed
  where ed.event_name in ('page_view','user_engagement')
    and (select value.string_value from unnest(ed.event_params) where key = 'medium') is not null
  ),

-- Device Columns from 'Session Start' event.
device as (
  select sl.sl_key
      ,  ed.device.category device__category
      ,  ed.device.mobile_brand_name device__mobile_brand_name
      ,  ed.device.mobile_model_name device__mobile_model_name
      ,  ed.device.mobile_brand_name||' '||device.mobile_model_name device__mobile_device_info
      ,  ed.device.mobile_marketing_name device__mobile_marketing_name
      ,  ed.device.mobile_os_hardware_model device__mobile_os_hardware_model
      ,  ed.device.operating_system device__operating_system
      ,  ed.device.operating_system_version device__operating_system_version
      ,  ed.device.vendor_id device__vendor_id
      ,  ed.device.advertising_id device__advertising_id
      ,  ed.device.language device__language
      ,  ed.device.time_zone_offset_seconds device__time_zone_offset_seconds
      ,  ed.device.is_limited_ad_tracking device__is_limited_ad_tracking
      ,  case when ed.device.category = 'mobile' then true else false end as device__is_mobile
  from session_list_with_event_history sl
    ,  unnest(event_data) ed
  where ed.event_name = 'session_start'
  ),

-- GEO Columns from 'Session Start' event.
geo as (
  select sl.sl_key
      ,  ed.geo.continent geo__continent
      ,  ed.geo.country geo__country
      ,  ed.geo.city geo__city
      ,  ed.geo.metro geo__metro
      ,  ed.geo.sub_continent geo__sub_continent
      ,  ed.geo.region geo__region
  from session_list_with_event_history sl
    ,  unnest(event_data) ed
  where ed.event_name = 'session_start'
  )

-- Final Select Statement:
select sl.session_date session_date
    ,  sl.ga_session_id ga_session_id
    ,  sl.ga_session_number ga_session_number
    ,  sl.user_pseudo_id user_pseudo_id
    ,  sl.sl_key
    -- packing session-level data into structs by category
    ,  (SELECT AS STRUCT coalesce(sa.medium,'(none)') medium
                      ,  coalesce(sa.source,'(direct)') source
                      ,  coalesce(sa.campaign,'(direct)') campaign
                      ,  sa.page_referrer ) session_attribution
    ,  (SELECT AS STRUCT sf.session_event_count
                      ,  engaged_events
                      ,  is_engaged_session
                      ,  is_first_visit_session
                      ,  session_end
                      ,  session_start
                      ,  session_length_minutes) session_data
    ,  (SELECT AS STRUCT d.device__category
                      ,  d.device__mobile_brand_name
                      ,  d.device__mobile_model_name
                      ,  d.device__mobile_device_info
                      ,  d.device__mobile_marketing_name
                      ,  d.device__mobile_os_hardware_model
                      ,  d.device__operating_system
                      ,  d.device__operating_system_version
                      ,  d.device__vendor_id
                      ,  d.device__advertising_id
                      ,  d.device__language
                      ,  d.device__time_zone_offset_seconds
                      ,  d.device__is_limited_ad_tracking) device_data
    ,  (SELECT AS STRUCT g.geo__continent
                      ,  g.geo__country
                      ,  g.geo__city
                      ,  g.geo__metro
                      ,  g.geo__sub_continent
                      ,  g.geo__region) geo_data
    ,  sl.event_data event_data
from session_list_with_event_history sl
left join session_tags sa
  on  sl.sl_key = sa.sl_key
left join session_facts sf
  on  sl.sl_key = sf.sl_key
left join device d
  on  sl.sl_key = d.sl_key
left join geo g
  on  sl.sl_key = g.sl_key
limit 10

       ;;
  }

  dimension: sl_key {
    type: string
    sql: ${TABLE}.ga_session_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension_group: session {
    type: time
    sql: ${TABLE}.session_date ;;
  }

  dimension: ga_session_id {
    type: number
    sql: ${TABLE}.ga_session_id ;;
  }

  dimension: ga_session_number {
    type: number
    sql: ${TABLE}.ga_session_number ;;
  }

  dimension: user_pseudo_id {
    type: string
    sql: ${TABLE}.user_pseudo_id ;;
  }

  dimension: session_data {
    type: string
    sql: ${TABLE}.session_data ;;
  }

  dimension: device_data {
    type: string
    sql: ${TABLE}.device_data ;;
  }

  dimension: geo_data {
    type: string
    sql: ${TABLE}.geo_data ;;
  }

  dimension: event_data {
    ## This is the parent dimension for the event_data fields within the event_data view.
    hidden: yes
    type: string
    sql: ${TABLE}.event_data ;;
  }

}
