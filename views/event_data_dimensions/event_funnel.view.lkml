view: event_funnel {
extension: required

## Filters
  filter: event_1_filter {
    view_label: "Event Funnel"
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 1 to be used with Count of Event 1"
  }
  filter: event_2_filter {
    view_label: "Event Funnel"
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 2 to be used with Count of Event 2"
  }
  filter: event_3_filter {
    view_label: "Event Funnel"
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 3 to be used with Count of Event 3"
  }
  filter: event_4_filter {
    view_label: "Event Funnel"
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 4 to be used with Count of Event 4"
  }
  filter: event_5_filter {
    view_label: "Event Funnel"
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 5 to be used with Count of Event 5"
  }
  filter: event_6_filter {
    view_label: "Event Funnel"
    group_label: "Funnel Events"
    suggest_explore: sessions
    suggest_dimension: events.event_name
    description: "Event 6 to be used with Count of Event 6"
  }

## Dimensions
  dimension: event_1 {
    type: string
    hidden: yes
    sql: (select event_name from UNNEST(${sessions.event_data}) where event_rank = 1) ;;
  }
  dimension: event_2 {
    type: string
    hidden: yes
    sql: (select event_name from UNNEST(${sessions.event_data}) where event_rank = 2) ;;
  }
  dimension: event_3 {
    type: string
    hidden: yes
    sql: (select event_name from UNNEST(${sessions.event_data}) where event_rank = 3) ;;
  }
  dimension: event_4 {
    type: string
    hidden: yes
    sql: (select event_name from UNNEST(${sessions.event_data}) where event_rank = 4) ;;
  }
  dimension: event_5 {
    type: string
    hidden: yes
    sql: (select event_name from UNNEST(${sessions.event_data}) where event_rank = 5) ;;
  }
  dimension: event_6 {
    type: string
    hidden: yes
    sql: (select event_name from UNNEST(${sessions.event_data}) where event_rank = 6) ;;
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
    view_label: "Event Funnel"
    type: sum
    sql: ${event_1_tag} ;;
    label: "{% if event_1_filter._in_query %}
    {{_filters['event_1_filter']}}
    {% else %}
    Count of Event 1
    {% endif %}"
    description: "Count of Event 1 to be used with Event 1 filter, if no filter is selected it shows all events"
  }

  measure: count_of_event_2 {
    view_label: "Event Funnel"
    type: sum
    sql: ${event_2_tag} ;;
    label: "{% if event_2_filter._in_query %}
    {{_filters['event_2_filter']}}
    {% else %}
    Count of Event 2
    {% endif %}"
    description: "Count of Event 2 to be used with Event 2 filter, if no filter is selected it shows all events"
  }

  measure: count_of_event_3 {
    view_label: "Event Funnel"
    type: sum
    sql: ${event_3_tag} ;;
    label: "{% if event_3_filter._in_query %}
    {{_filters['event_3_filter']}}
    {% else %}
    Count of Event 3
    {% endif %}"
    description: "Count of Event 3 to be used with Event 3 filter, if no filter is selected it shows all events"
  }

  measure: count_of_event_4 {
    view_label: "Event Funnel"
    type: sum
    sql: ${event_4_tag} ;;
    label: "{% if event_4_filter._in_query %}
    {{_filters['event_4_filter']}}
    {% else %}
    Count of Event 4
    {% endif %}"
    description: "Count of Event 4 to be used with Event 4 filter, if no filter is selected it shows all events"
  }

  measure: count_of_event_5 {
    view_label: "Event Funnel"
    type: sum
    sql: ${event_5_tag} ;;
    label: "{% if event_5_filter._in_query %}
    {{_filters['event_5_filter']}}
    {% else %}
    Count of Event 5
    {% endif %}"
    description: "Count of Event 5 to be used with Event 5 filter, if no filter is selected it shows all events"
  }

  measure: count_of_event_6 {
    view_label: "Event Funnel"
    type: sum
    sql: ${event_6_tag} ;;
    label: "{% if event_6_filter._in_query %}
    {{_filters['event_6_filter']}}
    {% else %}
    Count of Event 6
    {% endif %}"
    description: "Count of Event 6 to be used with Event 6 filter, if no filter is selected it shows all events"
  }
}
