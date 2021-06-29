view: page_views {
  derived_table: {
    explore_source: sessions {
      column: sl_key { field: sessions.sl_key }
      column: ed_key { field: event_data.ed_key }
      column: event_timestamp { field: event_data.event_timestamp }
      column: event_param_page { field: event_data.event_param_page }
      column: event_param_page_location { field: event_data.event_param_page_location }
      column: event_param_page_referrer { field: event_data.event_param_page_referrer }
      column: event_param_page_title { field: event_data.event_param_page_title }
      derived_column: time_to_next_event {
        sql: (TIMESTAMP_DIFF(TIMESTAMP_MICROS(LEAD(event_timestamp) OVER (PARTITION BY sl_key ORDER BY event_timestamp asc))
                           ,TIMESTAMP_MICROS(event_timestamp),second)/86400.0)  ;;
      }
      derived_column: page_view_rank {
        sql: ROW_NUMBER() OVER(PARTITION BY sl_key ORDER BY event_timestamp asc) ;;
      }
      bind_all_filters: yes
      filters: [event_data.event_name: "page_view"]
    }
  }

## Dimensions

  dimension: pv_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${sl_key}||${ed_key} ;;
  }

  dimension: sl_key {
    hidden: yes
  }

  dimension: ed_key {
    hidden: yes
  }

  dimension: event_timestamp {
    hidden: yes
  }

  dimension: page_view_rank {
    type: number
  }

  dimension: event_param_page {
    label: "Event Data Page"
  }

  dimension: event_param_page_location {
    label: "Event Data Page Location"
  }

  dimension: event_param_page_referrer {
    label: "Event Data Page Referrer"
  }

  dimension: event_param_page_title {
    label: "Event Data Page Title"
  }

  dimension: time_to_next_event {
    label: "Time to Next Event"
    value_format_name: hour_format
  }

  dimension: is_landing_page {
    type: yesno
    label: "Is Landing Page?"
    sql: ${page_view_rank} = 1 ;;
  }

  dimension: landing_page_page {
    type: string
    sql: case when ${page_view_rank} = 1 then ${event_param_page} else null end ;;
    label: "Landing Page"
    description: "Page value for Page View Ranked 1 (First Page View in Session)"
  }

## Measures
  measure: average_time_to_next_event {
    view_label: "Metrics"
    group_label: "Event Data"
    label: "Average Time to Next Event"
    type: average
    sql: ${time_to_next_event} ;;
    value_format_name: hour_format
  }
}
