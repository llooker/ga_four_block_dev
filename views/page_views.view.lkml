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
      column: count_page_views { field: event_data.total_page_views }
      derived_column: time_to_next_event {
        sql: (TIMESTAMP_DIFF(TIMESTAMP_MICROS(LEAD(event_timestamp) OVER (PARTITION BY sl_key ORDER BY event_timestamp asc))
                           ,TIMESTAMP_MICROS(event_timestamp),second)/86400.0)  ;;
      }
      derived_column: page_view_rank {
        sql: ROW_NUMBER() OVER(PARTITION BY sl_key ORDER BY event_timestamp asc) ;;
      }
      derived_column: page_view_reverse_rank {
        sql: ROW_NUMBER() OVER(PARTITION BY sl_key ORDER BY event_timestamp desc) ;;
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

  dimension: count_page_views {
    type: number
    hidden: yes
  }

  dimension: page_view_rank {
    type: number
  }

  dimension: page_view_reverse_rank {
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

  dimension: is_exit_page {
    type: yesno
    label: "Is Exit Page?"
    sql: ${page_view_reverse_rank} = 1 ;;
  }

  dimension: is_bounce {
    type: yesno
    label: "Is Bounce?"
    sql: ${count_page_views} = 1 ;;
  }

  # dimension: landing_page_page {
  #   type: string
  #   sql: case when ${page_view_rank} = 1 then ${event_param_page} else null end ;;
  #   label: "Landing Page"
  #   description: "Page value for Page View Ranked 1 (First Page View in Session)"
  # }

  dimension: exit_page_page {
    type: string
    sql: case when ${page_view_reverse_rank} = 1 then ${event_param_page} else null end ;;
    label: "Exit Page"
    description: "Page value for Page View Reverse Ranked 1 (Last Page View in Session)"
  }

## Measures

  measure: total_page_views {
    type: count_distinct
    label: "Total Page Views"
    sql: ${pv_key} ;;
  }

  measure: total_entrances {
    type: count_distinct
    filters: [is_landing_page: "yes"]
    sql: ${pv_key} ;;
  }

  measure: entrance_rate {
    type: number
    sql: ${total_entrances}/nullif(${total_page_views},0) ;;
    value_format_name: percent_2
  }

  measure: total_bounce {
    type: count_distinct
    sql: ${pv_key} ;;
    filters: [is_bounce: "yes"]
  }

  measure: bounce_rate {
    type: number
    sql: ${total_bounce}/nullif(${total_page_views},0) ;;
    value_format_name: percent_2
  }

  measure: total_exits {
    type: count_distinct
    filters: [is_exit_page: "yes"]
    sql: ${pv_key} ;;
  }

  measure: exit_rate {
    type: number
    sql: ${total_exits}/nullif(${total_page_views},0) ;;
    value_format_name: percent_2
  }

  measure: average_time_to_next_event {
    view_label: "Metrics"
    group_label: "Event Data"
    label: "Average Time on Page"
    type: average
    sql: ${time_to_next_event} ;;
    value_format_name: hour_format
  }
}
