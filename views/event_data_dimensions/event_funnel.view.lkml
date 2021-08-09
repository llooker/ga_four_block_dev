view: event_funnel {
  derived_table: {
    sql: select sessions.sl_key
             ,  (select event_name from UNNEST(event_data) where event_rank = 1) event_1
             ,  (select event_name from UNNEST(event_data) where event_rank = 2) event_2
             ,  (select event_name from UNNEST(event_data) where event_rank = 3) event_3
             ,  (select event_name from UNNEST(event_data) where event_rank = 4) event_4
             ,  (select event_name from UNNEST(event_data) where event_rank = 5) event_5
             ,  (select event_name from UNNEST(event_data) where event_rank = 6) event_6
         from ${sessions.SQL_TABLE_NAME} AS sessions
              ;;
    persist_for: "24 hours"
  }

## Filters
  filter: event_1_filter {
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 1 to be used with Count of Event 1"
  }
  filter: event_2_filter {
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 2 to be used with Count of Event 2"
  }
  filter: event_3_filter {
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 3 to be used with Count of Event 3"
  }
  filter: event_4_filter {
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 4 to be used with Count of Event 4"
  }
  filter: event_5_filter {
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 5 to be used with Count of Event 5"
  }
  filter: event_6_filter {
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 6 to be used with Count of Event 6"
  }

## Dimensions
  dimension: sl_key {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.sl_key ;;
  }
  dimension: event_1 {
    type: string
    hidden: yes
    sql: ${TABLE}.event_1 ;;
  }
  dimension: event_2 {
    type: string
    hidden: yes
    sql: ${TABLE}.event_2 ;;
  }
  dimension: event_3 {
    type: string
    hidden: yes
    sql: ${TABLE}.event_3 ;;
  }
  dimension: event_4 {
    type: string
    hidden: yes
    sql: ${TABLE}.event_4 ;;
  }
  dimension: event_5 {
    type: string
    hidden: yes
    sql: ${TABLE}.event_5 ;;
  }
  dimension: event_6 {
    type: string
    hidden: yes
    sql: ${TABLE}.event_6 ;;
  }

  dimension: event_1_tag {
    type: number
    hidden: yes
    sql: case when {% condition event_1_filter %} ${event_1} {% endcondition %} and ${event_1} is not null then 1 else 0 end ;;
  }
  dimension: event_2_tag {
    type: number
    hidden: yes
    sql: case when {% condition event_1_filter %} ${event_1} {% endcondition %}
               and {% condition event_2_filter %} ${event_2} {% endcondition %}
               and ${event_2} is not null then 1 else 0 end ;;
  }
  dimension: event_3_tag {
    type: number
    hidden: yes
    sql: case when {% condition event_1_filter %} ${event_1} {% endcondition %}
               and {% condition event_2_filter %} ${event_2} {% endcondition %}
               and {% condition event_3_filter %} ${event_3} {% endcondition %}
               and ${event_2} is not null
               and ${event_3} is not null then 1 else 0 end ;;
  }
  dimension: event_4_tag {
    type: number
    hidden: yes
    sql: case when {% condition event_1_filter %} ${event_1} {% endcondition %}
               and {% condition event_2_filter %} ${event_2} {% endcondition %}
               and {% condition event_3_filter %} ${event_3} {% endcondition %}
               and {% condition event_4_filter %} ${event_4} {% endcondition %}
               and ${event_2} is not null
               and ${event_3} is not null
               and ${event_4} is not null then 1 else 0 end ;;
  }
  dimension: event_5_tag {
    type: number
    hidden: yes
    sql: case when {% condition event_1_filter %} ${event_1} {% endcondition %}
               and {% condition event_2_filter %} ${event_2} {% endcondition %}
               and {% condition event_3_filter %} ${event_3} {% endcondition %}
               and {% condition event_4_filter %} ${event_4} {% endcondition %}
               and {% condition event_5_filter %} ${event_5} {% endcondition %}
               and ${event_2} is not null
               and ${event_3} is not null
               and ${event_4} is not null
               and ${event_5} is not null then 1 else 0 end ;;
  }
  dimension: event_6_tag {
    type: number
    hidden: yes
    sql: case when {% condition event_1_filter %} ${event_1} {% endcondition %}
               and {% condition event_2_filter %} ${event_2} {% endcondition %}
               and {% condition event_3_filter %} ${event_3} {% endcondition %}
               and {% condition event_4_filter %} ${event_4} {% endcondition %}
               and {% condition event_5_filter %} ${event_5} {% endcondition %}
               and {% condition event_6_filter %} ${event_6} {% endcondition %}
               and ${event_2} is not null
               and ${event_3} is not null
               and ${event_4} is not null
               and ${event_5} is not null
               and ${event_6} is not null then 1 else 0 end ;;
  }


## Measures
  measure: count_of_event_1 {
    type: sum
    sql: ${event_1_tag} ;;
    label: "{% if event_1_filter._in_query %}
    {{_filters['event_funnel.event_1_filter']}}
    {% else %}
    Count of Event 1
    {% endif %}"
    description: "Count of Event 1 to be used with Event 1 filter, if no filter is selected it shows all events"
  }

  measure: count_of_event_2 {
    type: sum
    sql: ${event_2_tag} ;;
    label: "{% if event_2_filter._in_query %}
    {{_filters['event_funnel.event_2_filter']}}
    {% else %}
    Count of Event 2
    {% endif %}"
    description: "Count of Event 2 to be used with Event 2 filter, if no filter is selected it shows all events"
  }

  measure: count_of_event_3 {
    type: sum
    sql: ${event_3_tag} ;;
    label: "{% if event_3_filter._in_query %}
    {{_filters['event_funnel.event_3_filter']}}
    {% else %}
    Count of Event 3
    {% endif %}"
    description: "Count of Event 3 to be used with Event 3 filter, if no filter is selected it shows all events"
  }

  measure: count_of_event_4 {
    type: sum
    sql: ${event_4_tag} ;;
    label: "{% if event_4_filter._in_query %}
    {{_filters['event_funnel.event_4_filter']}}
    {% else %}
    Count of Event 4
    {% endif %}"
    description: "Count of Event 4 to be used with Event 4 filter, if no filter is selected it shows all events"
  }

  measure: count_of_event_5 {
    type: sum
    sql: ${event_5_tag} ;;
    label: "{% if event_5_filter._in_query %}
    {{_filters['event_funnel.event_5_filter']}}
    {% else %}
    Count of Event 5
    {% endif %}"
    description: "Count of Event 5 to be used with Event 5 filter, if no filter is selected it shows all events"
  }

  measure: count_of_event_6 {
    type: sum
    sql: ${event_6_tag} ;;
    label: "{% if event_6_filter._in_query %}
    {{_filters['event_funnel.event_6_filter']}}
    {% else %}
    Count of Event 6
    {% endif %}"
    description: "Count of Event 6 to be used with Event 6 filter, if no filter is selected it shows all events"
  }
}
