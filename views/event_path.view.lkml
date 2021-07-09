view: event_path {
  derived_table: {
    explore_source: sessions {
      column: sl_key { field: sessions.sl_key }
      column: ed_key { field: event_data.ed_key }
      column: event_timestamp { field: event_data.event_timestamp }
      column: full_event { field: event_data.full_event }
      derived_column: current_event_minus_1 {sql: LAG(full_event) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_minus_2 {sql: LAG(full_event,2) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_minus_3 {sql: LAG(full_event,3) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_minus_4 {sql: LAG(full_event,4) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_minus_5 {sql: LAG(full_event,5) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_minus_6 {sql: LAG(full_event,6) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_minus_7 {sql: LAG(full_event,7) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_minus_8 {sql: LAG(full_event,8) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_minus_9 {sql: LAG(full_event,9) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_minus_10 {sql: LAG(full_event,10) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_plus_1 {sql: LEAD(full_event) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_plus_2 {sql: LEAD(full_event,2) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_plus_3 {sql: LEAD(full_event,3) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_plus_4 {sql: LEAD(full_event,4) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_plus_5 {sql: LEAD(full_event,5) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_plus_6 {sql: LEAD(full_event,6) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_plus_7 {sql: LEAD(full_event,7) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_plus_8 {sql: LEAD(full_event,8) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_plus_9 {sql: LEAD(full_event,9) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      derived_column: current_event_plus_10 {sql: LEAD(full_event,10) OVER (PARTITION BY sl_key ORDER BY event_timestamp) ;;}
      bind_all_filters: yes
    }
  }

## Dimensions

  dimension: ep_key {
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

  dimension: full_event {
    hidden: yes
    label: "Full Event"
  }


  dimension: current_event_plus_1 {
    group_label: "Relative Event Path"
    description: "Event Path for event that came directly before current Event."
    type: string
  }

  dimension: current_event_plus_2 {
    group_label: "Relative Event Path"
    description: "Event Path for event that came 2 events before current Event."
    type: string
  }

  dimension: current_event_plus_3 {
    group_label: "Relative Event Path"
    description: "Event Path for event that came 3 events before current Event."
    type: string
  }

  dimension: current_event_plus_4 {
    group_label: "Relative Event Path"
    description: "Event Path for event that came 4 events before current Event."
    type: string
  }

  dimension: current_event_plus_5 {
    group_label: "Relative Event Path"
    description: "Event Path for event that came 5 events before current Event."
    type: string
  }

  dimension: current_event_plus_6 {
    group_label: "Relative Event Path"
    description: "Event Path for event that came 6 events before current Event."
    type: string
  }

  dimension: current_event_plus_7 {
    group_label: "Relative Event Path"
    description: "Event Path for event that came 7 events before current Event."
    type: string
  }

  dimension: current_event_plus_8 {
    group_label: "Relative Event Path"
    description: "Event Path for event that came 8 events before current Event."
    type: string
  }

  dimension: current_event_plus_9 {
    group_label: "Relative Event Path"
    description: "Event Path for event that came 9 events before current Event."
    type: string
  }

  dimension: current_event_plus_10 {
    group_label: "Relative Event Path"
    description: "Event Path for event that came 10 events before current Event."
    type: string
  }

  dimension: current_event_minus_1 {
    group_label: "Reverse Event Path"
    description: "Event Path for event that came directly after current Event."
    type: string
  }

  dimension: current_event_minus_2 {
    group_label: "Reverse Event Path"
    description: "Event Path for event that came 2 events after current Event."
    type: string
  }

  dimension: current_event_minus_3 {
    group_label: "Reverse Event Path"
    description: "Event Path for event that came 3 events after current Event."
    type: string
  }

  dimension: current_event_minus_4 {
    group_label: "Reverse Event Path"
    description: "Event Path for event that came 4 events after current Event."
    type: string
  }

  dimension: current_event_minus_5 {
    group_label: "Reverse Event Path"
    description: "Event Path for event that came 5 events after current Event."
    type: string
  }

  dimension: current_event_minus_6 {
    group_label: "Reverse Event Path"
    description: "Event Path for event that came 6 events after current Event."
    type: string
  }

  dimension: current_event_minus_7 {
    group_label: "Reverse Event Path"
    description: "Event Path for event that came 7 events after current Event."
    type: string
  }

  dimension: current_event_minus_8 {
    group_label: "Reverse Event Path"
    description: "Event Path for event that came 8 events after current Event."
    type: string
  }

  dimension: current_event_minus_9 {
    group_label: "Reverse Event Path"
    description: "Event Path for event that came 9 events after current Event."
    type: string
  }

  dimension: current_event_minus_10 {
    group_label: "Reverse Event Path"
    description: "Event Path for event that came 10 events after current Event."
    type: string
  }
}
