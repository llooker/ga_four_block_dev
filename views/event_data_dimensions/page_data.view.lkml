## Purpose: This view is for defining the 'page_view' specific fields. This view is extended into 'event_data'.


view: page_data {
  extension: required

  dimension: page_view_rank {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "Page View Rank"
    description: "Rank of 'Page View' Event, 1 = First Event"
    type: number
    sql: ${TABLE}.page_view_rank ;;
  }

  dimension: page_view_reverse_rank {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "Page View Reverse Rank"
    description: "Reverse Rank of 'Page View' Event, 1 = Last Event"
    type: number
    sql: ${TABLE}.page_view_reverse_rank ;;
  }

  dimension: time_to_next_page {
    view_label: "Behavior"
    group_label: "Time on Page"
    label: "Time on Page"
    description: "Time user spent on page. If it was the last page they visited before exiting, then time from when they entered and their last event on the page"
    type: number
    sql: ${TABLE}.time_to_next_page ;;
    value_format_name: hour_format
  }

  dimension: is_landing_page {
    view_label: "Behavior"
    group_label: "Page Filters"
    description: "Use to filter for first pageview of a session. Use with Page dimensions."
    type: yesno
    sql: ${page_view_rank} = 1 ;;
  }

  dimension: is_exit_page {
    view_label: "Behavior"
    group_label: "Page Filters"
    description: "If this hit was the last pageview or screenview hit of a session, this is set to true."
    type: yesno
    sql: ${page_view_reverse_rank} = 1 ;;
  }

  dimension: is_bounce {
    view_label: "Behavior"
    group_label: "Page Filters"
    label: "Is Bounce?"
    description: "If this hit was the last pageview or screenview hit of a session, this is set to true."
    type: yesno
    sql: ${sessions.session_data_page_view_count} = 1 ;;
  }

  dimension: landing_page {
    view_label: "Behavior"
    group_label: "Pages"
    description: "Landing/Entrance Page (first 'Page View' event) of a Session."
    sql: case when ${page_view_rank} = 1 then ${event_param_page} else null end ;;
    type: string
  }

  dimension: exit_page {
    view_label: "Behavior"
    group_label: "Pages"
    description: "Exit Page (last 'Page View' event) of a Session."
    sql: sql: case when ${page_view_rank} = 1 then ${event_param_page} else null end ;;
    type: string
  }

  ## Page Path Dimensions
  dimension: page_path_1 {
    view_label: "Page Flow"
    group_label: "Page Path"
    description: "1st Page in Session."
    type: string
    sql: case when ${page_view_rank} = 1 then ${event_param_page} else null end ;;
  }
  dimension: page_path_2 {
    view_label: "Page Flow"
    group_label: "Page Path"
    description: "2nd Page in Session."
    type: string
    sql: case when ${page_view_rank} = 2 then ${event_param_page} else null end ;;
  }
  dimension: page_path_3 {
    view_label: "Page Flow"
    group_label: "Page Path"
    description: "3rd Page in Session."
    type: string
    sql: case when ${page_view_rank} = 3 then ${event_param_page} else null end ;;
  }
  dimension: page_path_4 {
    view_label: "Page Flow"
    group_label: "Page Path"
    description: "4th Page in Session."
    type: string
    sql: case when ${page_view_rank} = 4 then ${event_param_page} else null end ;;
  }
  dimension: page_path_5 {
    view_label: "Page Flow"
    group_label: "Page Path"
    description: "5th Page in Session."
    type: string
    sql: case when ${page_view_rank} = 5 then ${event_param_page} else null end ;;
  }
  dimension: page_path_6 {
    view_label: "Page Flow"
    group_label: "Page Path"
    description: "6th Page in Session."
    type: string
    sql: case when ${page_view_rank} = 6 then ${event_param_page} else null end ;;
  }
  dimension: page_path_7 {
    view_label: "Page Flow"
    group_label: "Page Path"
    description: "4th Page in Session."
    type: string
    sql: case when ${page_view_rank} = 7 then ${event_param_page} else null end ;;
  }
  dimension: page_path_8 {
    view_label: "Page Flow"
    group_label: "Page Path"
    description: "5th Page in Session."
    type: string
    sql: case when ${page_view_rank} = 8 then ${event_param_page} else null end ;;
  }
  dimension: page_path_9 {
    view_label: "Page Flow"
    group_label: "Page Path"
    description: "6th Page in Session."
    type: string
    sql: case when ${page_view_rank} = 9 then ${event_param_page} else null end ;;
  }

  ## Relative Page Path Dimensions
  dimension: current_page_plus_1 {
    view_label: "Page Flow"
    group_label: "Relative Page Path"
    description: "Page Path for page that came directly before current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank + 1)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_plus_2 {
    view_label: "Page Flow"
    group_label: "Relative Page Path"
    description: "Page Path for page that came 2 pages before current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank + 2)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_plus_3 {
    view_label: "Page Flow"
    group_label: "Relative Page Path"
    description: "Page Path for page that came 3 pages before current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank + 3)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_plus_4 {
    view_label: "Page Flow"
    group_label: "Relative Page Path"
    description: "Page Path for page that came 4 pages before current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank + 4)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_plus_5 {
    view_label: "Page Flow"
    group_label: "Relative Page Path"
    description: "Page Path for page that came 5 pages before current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank + 5)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_plus_6 {
    view_label: "Page Flow"
    group_label: "Relative Page Path"
    description: "Page Path for page that came 6 pages before current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank + 6)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_plus_7 {
    view_label: "Page Flow"
    group_label: "Relative Page Path"
    description: "Page Path for page that came 7 pages before current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank + 7)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_plus_8 {
    view_label: "Page Flow"
    group_label: "Relative Page Path"
    description: "Page Path for page that came 8 pages before current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank + 8)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_plus_9 {
    view_label: "Page Flow"
    group_label: "Relative Page Path"
    description: "Page Path for page that came 9 pages before current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank + 9)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }

  ## Reverse Page Path Dimensions

  dimension: current_page_minus_1 {
    view_label: "Page Flow"
    group_label: "Reverse Page Path"
    description: "Page Path for page that came directly after current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank - 1)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_minus_2 {
    view_label: "Page Flow"
    group_label: "Reverse Page Path"
    description: "Page Path for page that came 2 pages after current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank - 2)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_minus_3 {
    view_label: "Page Flow"
    group_label: "Reverse Page Path"
    description: "Page Path for page that came 3 pages after current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank - 3)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_minus_4 {
    view_label: "Page Flow"
    group_label: "Reverse Page Path"
    description: "Page Path for page that came 4 pages after current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank - 4)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_minus_5 {
    view_label: "Page Flow"
    group_label: "Reverse Page Path"
    description: "Page Path for page that came 5 pages after current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank - 5)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_minus_6 {
    view_label: "Page Flow"
    group_label: "Reverse Page Path"
    description: "Page Path for page that came 6 pages after current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank - 6)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_minus_7 {
    view_label: "Page Flow"
    group_label: "Reverse Page Path"
    description: "Page Path for page that came 7 pages after current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank - 7)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_minus_8 {
    view_label: "Page Flow"
    group_label: "Reverse Page Path"
    description: "Page Path for page that came 8 pages after current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank - 8)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }
  dimension: current_page_minus_9 {
    view_label: "Page Flow"
    group_label: "Reverse Page Path"
    description: "Page Path for page that came 9 pages after current page."
    sql: (select (select value.string_value FROM UNNEST(event_history.event_params) WHERE key = "page")
          from UNNEST(${sessions.event_data}) as event_history
          where event_history.page_view_rank = (${TABLE}.page_view_rank - 9)
          and event_history.event_name = "page_view" limit 1) ;;
    type: string
  }


## Measures

  measure: total_entrances {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Entrances"
    description: "The number of entrances to the property measured as the first pageview in a session, typically used with Landing Page."
    type: count_distinct
    filters: [is_landing_page: "yes"]
    sql: ${ed_key} ;;
    value_format_name: formatted_number
  }

  measure: entrance_rate {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Entrance Rate"
    description:"The percentage of 'Page View' events in which this page was the entrance."
    type: number
    sql: ${total_entrances}/nullif(${total_page_views},0) ;;
    value_format_name: percent_2
  }

  measure: total_bounce {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Bounces"
    type: count_distinct
    sql: ${ed_key} ;;
    filters: [is_bounce: "yes"]
    value_format_name: formatted_number
  }

  measure: bounce_rate {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Bounce Rate"
    type: number
    sql: ${total_bounce}/nullif(${total_page_views},0) ;;
    value_format_name: percent_2
  }

  measure: total_exits {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Exits"
    description: "The number of exits from the property."
    type: count_distinct
    filters: [is_exit_page: "yes"]
    sql: ${ed_key} ;;
    value_format_name: formatted_number
  }

  measure: exit_rate {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Exit Rate"
    description: "Exit is (number of exits) / (number of pageviews) for the page or set of pages. It indicates how often users exit from that page or set of pages when they view the page(s)."
    type: number
    sql: ${total_exits}/nullif(${total_page_views},0) ;;
    value_format_name: percent_2
  }

  measure: average_time_to_next_event {
    # view_label: "Metrics"
    # group_label: "Event Data"
    view_label: "Behavior"
    group_label: "Pages"
    label: "Average Time on Page"
    description: "Avg time a user spent on a specific page."
    type: average
    sql: ${time_to_next_event} ;;
    value_format_name: hour_format
  }
}
