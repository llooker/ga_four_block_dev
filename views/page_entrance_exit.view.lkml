view: page_entrance_exit {
  derived_table: {
    explore_source: sessions {
      column: sl_key { field: sessions.sl_key }
      column: event_timestamp { field: event_data.event_timestamp }
      column: event_param_page { field: event_data.event_param_page }
      column: count_page_views { field: event_data.total_page_views }
      derived_column: landing_page {
        sql: first_value(event_param_page) over (partition by sl_key order by event_timestamp asc) ;;
      }
      derived_column: exit_page {
        sql: first_value(event_param_page) over (partition by sl_key order by event_timestamp desc) ;;
      }
      bind_all_filters: yes
      filters: [event_data.event_name: "page_view"]
    }
  }

## Dimensions

  dimension: sl_key {
    hidden: yes
  }

  dimension: event_timestamp {
    hidden: yes
  }

  dimension: count_page_views {
    type: number
    hidden: yes
  }

  dimension: landing_page {
    type: string
  }

  dimension: exit_page {
    type: string
  }


}
