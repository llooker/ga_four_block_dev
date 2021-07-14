view: user_previous_session {
    derived_table: {
      explore_source: sessions {
        column: sl_key {}
        column: user_pseudo_id {}
        column: session_data_session_end_time {}
        column: session_data_session_start_time {}
        derived_column: prev_session_end_time {
          sql: lag(session_data_session_end_time) over (partition by user_pseudo_id order by session_data_session_start_time) ;;
        }
      }
    }
    dimension: sl_key { hidden:yes }
    dimension: session_data_session_start_time { hidden:yes }
    dimension_group: prev_session_end_time {
      hidden: yes
      type: time
      timeframes: [hour,date,week,year,raw]
    }
    dimension_group: since_previous_session {
      view_label: "Audience"
      group_label: "User"
      type: duration
      intervals: [hour,day]
      sql_start: ${prev_session_end_time_raw} ;;
      sql_end: ${session_data_session_start_time} ;;
    }
    dimension: days_since_previous_session_tier {
      view_label: "Audience"
      group_label: "User"
      description: "Days since the previous session. 0 if user only has 1 session."
      type: tier
      style: integer
      tiers: [1,2,4,8,15,31,61,121,365]
      sql: ${days_since_previous_session};;
    }
  }
