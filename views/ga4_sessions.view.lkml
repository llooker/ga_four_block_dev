view: ga4_sessions {
  derived_table: {
    datagroup_trigger: generated_model_default_datagroup
    increment_key: "session_date"
    increment_offset: 3
    sql: with
      session_list_with_event_history as (
        select timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) session_date
            ,  (select value.int_value from UNNEST(events.event_params) where key = "ga_session_id") ga_session_id
            ,  (select value.int_value from UNNEST(events.event_params) where key = "ga_session_number") ga_session_number
            ,  events.user_pseudo_id
            ,  ARRAY_AGG(STRUCT(event_date
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
              where {% incrementcondition %} timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) {%  endincrementcondition %}              group by 1,2,3,4
        ),
      session_facts as (
        select timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) session_date
            ,  (select value.int_value from UNNEST(events.event_params) where key = "ga_session_id") ga_session_id
            ,  (select value.int_value from UNNEST(events.event_params) where key = "ga_session_number") ga_session_number
            ,  events.user_pseudo_id
            ,  COUNT(events.event_timestamp) session_event_count
            ,  COALESCE(SUM((select value.int_value from UNNEST(events.event_params) where key = "engaged_session_event")),0) engaged_events
            ,  case when (COALESCE(SUM((select value.int_value from UNNEST(events.event_params) where key = "engaged_session_event")),0) = 0
                     and COALESCE(SUM((select coalesce(cast(value.string_value as INT64),value.int_value) from UNNEST(events.event_params) where key = "session_engaged"))) = 0)
                    then false else true end as is_engaged_session
                  , case when countif(event_name = 'first_visit') = 0 then false else true end as is_first_visit_session
                  , MAX(TIMESTAMP_MICROS(events.event_timestamp)) as session_end
                  , MIN(TIMESTAMP_MICROS(events.event_timestamp)) as session_start
                  , (MAX(events.event_timestamp) - MIN(events.event_timestamp))/(60 * 1000 * 1000) AS session_length_minutes
              from `adh-demo-data-review.analytics_213025502.events_*` events
              where {% incrementcondition %} timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) {%  endincrementcondition %}
              group by 1,2,3,4
        ),

      -- Retrieves the last non-direct medium, source, and campaign from the session's page_view and user_engagement events.
      session_tags as (
        select sl.session_date
            ,  sl.ga_session_id
            ,  sl.ga_session_number
            ,  sl.user_pseudo_id
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
        select timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) session_date
            ,  (select value.int_value from UNNEST(events.event_params) where key = "ga_session_id") ga_session_id
            ,  (select value.int_value from UNNEST(events.event_params) where key = "ga_session_number") ga_session_number
            ,  events.user_pseudo_id
            ,  device.category device__category
            ,  device.mobile_brand_name device__mobile_brand_name
            ,  device.mobile_model_name device__mobile_model_name
            ,  device.mobile_brand_name||' '||device.mobile_model_name device__mobile_device_info
            ,  device.mobile_marketing_name device__mobile_marketing_name
            ,  device.mobile_os_hardware_model device__mobile_os_hardware_model
            ,  device.operating_system device__operating_system
            ,  device.operating_system_version device__operating_system_version
            ,  device.vendor_id device__vendor_id
            ,  device.advertising_id device__advertising_id
            ,  device.language device__language
            ,  device.time_zone_offset_seconds device__time_zone_offset_seconds
            ,  device.is_limited_ad_tracking device__is_limited_ad_tracking
            ,  case when device.category = 'mobile' then true else false end as device__is_mobile
        from `adh-demo-data-review.analytics_213025502.events_*` events
        where event_name = 'session_start'
          and {% incrementcondition %} timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) {%  endincrementcondition %}        ),

      -- GEO Columns from 'Session Start' event.
      geo as (
        select timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) session_date
            ,  (select value.int_value from UNNEST(events.event_params) where key = "ga_session_id") ga_session_id
            ,  (select value.int_value from UNNEST(events.event_params) where key = "ga_session_number") ga_session_number
            ,  events.user_pseudo_id
            ,  geo.continent geo__continent
            ,  geo.country geo__country
            ,  geo.city geo__city
            ,  geo.metro geo__metro
            ,  geo.sub_continent geo__sub_continent
            ,  geo.region geo__region
        from `adh-demo-data-review.analytics_213025502.events_*` events
        where event_name = 'session_start'
          and {% incrementcondition %} timestamp(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'[0-9]+'))) {%  endincrementcondition %}
        )

      -- Final Select Statement:
      select sl.session_date session_date
          ,  sl.ga_session_id ga_session_id
          ,  sl.ga_session_number ga_session_number
          ,  sl.user_pseudo_id user_pseudo_id
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
          ,  sl.event_data
      from session_list_with_event_history sl
      left join session_tags sa
        on  sl.session_date = sa.session_date
        and sl.ga_session_id = sa.ga_session_id
        and sl.ga_session_number = sa.ga_session_number
        and sl.user_pseudo_id = sa.user_pseudo_id
      left join session_facts sf
        on  sl.session_date = sf.session_date
        and sl.ga_session_id = sf.ga_session_id
        and sl.ga_session_number = sf.ga_session_number
        and sl.user_pseudo_id = sf.user_pseudo_id
      left join device d
        on  sl.session_date = d.session_date
        and sl.ga_session_id = d.ga_session_id
        and sl.ga_session_number = d.ga_session_number
        and sl.user_pseudo_id = d.user_pseudo_id
      left join geo g
        on  sl.session_date = g.session_date
        and sl.ga_session_id = g.ga_session_id
        and sl.ga_session_number = g.ga_session_number
        and sl.user_pseudo_id = g.user_pseudo_id

       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
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

  set: detail {
    fields: [
      session_time,
      ga_session_id,
      ga_session_number,
      user_pseudo_id,
      session_data,
      device_data,
      geo_data
    ]
  }
}
