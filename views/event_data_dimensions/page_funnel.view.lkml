view: page_funnel {
extension: required

## Filters
  filter: page_1_filter {
    view_label: "Page Funnel"
    group_label: "Funnel Pages"
    suggest_explore: sessions
    suggest_dimension: events.event_param_page
    description: "Page 1 Filter, to be used with Count of Page 1"
  }

  filter: page_2_filter {
    view_label: "Page Funnel"
    group_label: "Funnel Pages"
    suggest_explore: sessions
    suggest_dimension: events.event_param_page
    description: "Page 2 Filter, to be used with Count of Page 2"
  }

  filter: page_3_filter {
    view_label: "Page Funnel"
    group_label: "Funnel Pages"
    suggest_explore: sessions
    suggest_dimension: events.event_param_page
    description: "Page 3 Filter, to be used with Count of Page 3"
  }

  filter: page_4_filter {
    view_label: "Page Funnel"
    group_label: "Funnel Pages"
    suggest_explore: sessions
    suggest_dimension: events.event_param_page
    description: "Page 4 Filter, to be used with Count of Page 4"
  }

  filter: page_5_filter {
    view_label: "Page Funnel"
    group_label: "Funnel Pages"
    suggest_explore: sessions
    suggest_dimension: events.event_param_page
    description: "Page 5 Filter, to be used with Count of Page 5"
  }

  filter: page_6_filter {
    view_label: "Page Funnel"
    group_label: "Funnel Pages"
    suggest_explore: sessions
    suggest_dimension: events.event_param_page
    description: "Page 6 Filter, to be used with Count of Page 6"
  }

## Dimensions
  dimension: sl_key {
    type: string
    sql: ${TABLE}.sl_key ;;
    hidden: yes
    primary_key: yes
  }
  dimension: page_1 {
    type: string
    hidden: yes
    sql: (select coalesce(regexp_extract((select value.string_value from UNNEST(event_params) where key = "page_location"),r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') from UNNEST(${sessions.event_data}) where page_view_rank = 1) ;;
  }
  dimension: page_2 {
    type: string
    hidden: yes
    sql: (select coalesce(regexp_extract((select value.string_value from UNNEST(event_params) where key = "page_location"),r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') from UNNEST(${sessions.event_data}) where page_view_rank = 2) ;;
  }
  dimension: page_3 {
    type: string
    hidden: yes
    sql: (select coalesce(regexp_extract((select value.string_value from UNNEST(event_params) where key = "page_location"),r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') from UNNEST(${sessions.event_data}) where page_view_rank = 3) ;;
  }
  dimension: page_4 {
    type: string
    hidden: yes
    sql: (select coalesce(regexp_extract((select value.string_value from UNNEST(event_params) where key = "page_location"),r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') from UNNEST(${sessions.event_data}) where page_view_rank = 4) ;;
  }
  dimension: page_5 {
    type: string
    hidden: yes
    sql: (select coalesce(regexp_extract((select value.string_value from UNNEST(event_params) where key = "page_location"),r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') from UNNEST(${sessions.event_data}) where page_view_rank = 5) ;;
  }
  dimension: page_6 {
    type: string
    hidden: yes
    sql: (select coalesce(regexp_extract((select value.string_value from UNNEST(event_params) where key = "page_location"),r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') from UNNEST(${sessions.event_data}) where page_view_rank = 6) ;;
  }

  dimension: page_1_tag {
    type: number
    hidden: yes
    sql: case when {% condition page_1_filter %} ${page_1} {% endcondition %} and ${page_1} is not null then 1 else 0 end ;;
  }
  dimension: page_2_tag {
    type: number
    hidden: yes
    sql: case when {% condition page_1_filter %} ${page_1} {% endcondition %}
               and {% condition page_2_filter %} ${page_2} {% endcondition %}
               and ${page_2} is not null then 1 else 0 end ;;
  }
  dimension: page_3_tag {
    type: number
    hidden: yes
    sql: case when {% condition page_1_filter %} ${page_1} {% endcondition %}
               and {% condition page_2_filter %} ${page_2} {% endcondition %}
               and {% condition page_3_filter %} ${page_3} {% endcondition %}
               and ${page_2} is not null
               and ${page_3} is not null then 1 else 0 end ;;
  }
  dimension: page_4_tag {
    type: number
    hidden: yes
    sql: case when {% condition page_1_filter %} ${page_1} {% endcondition %}
               and {% condition page_2_filter %} ${page_2} {% endcondition %}
               and {% condition page_3_filter %} ${page_3} {% endcondition %}
               and {% condition page_4_filter %} ${page_4} {% endcondition %}
               and ${page_2} is not null
               and ${page_3} is not null
               and ${page_4} is not null then 1 else 0 end ;;
  }
  dimension: page_5_tag {
    type: number
    hidden: yes
    sql: case when {% condition page_1_filter %} ${page_1} {% endcondition %}
               and {% condition page_2_filter %} ${page_2} {% endcondition %}
               and {% condition page_3_filter %} ${page_3} {% endcondition %}
               and {% condition page_4_filter %} ${page_4} {% endcondition %}
               and {% condition page_5_filter %} ${page_5} {% endcondition %}
               and ${page_2} is not null
               and ${page_3} is not null
               and ${page_4} is not null
               and ${page_5} is not null then 1 else 0 end ;;
  }
  dimension: page_6_tag {
    type: number
    hidden: yes
    sql: case when {% condition page_1_filter %} ${page_1} {% endcondition %}
               and {% condition page_2_filter %} ${page_2} {% endcondition %}
               and {% condition page_3_filter %} ${page_3} {% endcondition %}
               and {% condition page_4_filter %} ${page_4} {% endcondition %}
               and {% condition page_5_filter %} ${page_5} {% endcondition %}
               and {% condition page_6_filter %} ${page_6} {% endcondition %}
               and ${page_2} is not null
               and ${page_3} is not null
               and ${page_4} is not null
               and ${page_5} is not null
               and ${page_6} is not null then 1 else 0 end ;;
  }

## Measures

  measure: count_of_page_1 {
    view_label: "Page Funnel"
    type: sum
    sql: ${page_1_tag} ;;
    label: "{% if page_1_filter._in_query %}
    {{_filters['page_1_filter']}}
    {% else %}
    Count of Page 1
    {% endif %}"
    description: "Count of Page 1 to be used with Page 1 filter, if no filter is selected it shows all Pages"
  }

  measure: count_of_page_2 {
    view_label: "Page Funnel"
    type: sum
    sql: ${page_2_tag} ;;
    label: "{% if page_2_filter._in_query %}
    {{_filters['page_2_filter']}}
    {% else %}
    Count of Page 2
    {% endif %}"
    description: "Count of Page 2 to be used with Page 2 filter, if no filter is selected it shows all Pages"
  }

  measure: count_of_page_3 {
    view_label: "Page Funnel"
    type: sum
    sql: ${page_3_tag} ;;
    label: "{% if page_3_filter._in_query %}
    {{_filters['page_3_filter']}}
    {% else %}
    Count of Page 3
    {% endif %}"
    description: "Count of Page 3 to be used with Page 3 filter, if no filter is selected it shows all Pages"
  }

  measure: count_of_page_4 {
    view_label: "Page Funnel"
    type: sum
    sql: ${page_4_tag} ;;
    label: "{% if page_4_filter._in_query %}
    {{_filters['page_4_filter']}}
    {% else %}
    Count of Page 4
    {% endif %}"
    description: "Count of Page 4 to be used with Page 4 filter, if no filter is selected it shows all Pages"
  }

  measure: count_of_page_5 {
    view_label: "Page Funnel"
    type: sum
    sql: ${page_5_tag} ;;
    label: "{% if page_5_filter._in_query %}
    {{_filters['page_5_filter']}}
    {% else %}
    Count of Page 5
    {% endif %}"
    description: "Count of Page 5 to be used with Page 5 filter, if no filter is selected it shows all Pages"
  }

  measure: count_of_page_6 {
    view_label: "Page Funnel"
    type: sum
    sql: ${page_6_tag} ;;
    label: "{% if page_6_filter._in_query %}
    {{_filters['page_6_filter']}}
    {% else %}
    Count of Page 6
    {% endif %}"
    description: "Count of Page 6 to be used with Page 6 filter, if no filter is selected it shows all Pages"
  }

}
