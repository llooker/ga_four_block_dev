view: user_previous_session {
    derived_table: {
      explore_source: sessions {
        column: sl_key {}
        column: user_pseudo_id {}
        column: session_data_session_end_time {}
        column: session_data_session_start_time {}
        derived_column: prev_session_end_time {
          sql: lag(session_data_session_end_time) over (partition by sl_key order by session_data_session_start_time) ;;
        }
      }
    }
    dimension: sl_key { hidden:yes }
    dimension: session_data_session_start_time { hidden:yes }
    dimension_group: prev_session_end_time {
      type: time
      timeframes: [hour,date,week,year,raw]
      label: "Previous Session End"
    }
    dimension_group: since_previous_session {
      type: duration
      intervals: [hour,day]
      sql_start: ${prev_session_end_time_raw} ;;
      sql_end: ${session_data_session_start_time} ;;
    }
  }
