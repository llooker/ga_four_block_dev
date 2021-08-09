view: page_funnel {
  extension: required
  derived_table: {
    sql: SELECT page1.user_pseudo_id,
               page1.page_view_rank as page1_page_sequence_number, TIMESTAMP_MICROS(page1.event_timestamp) as page1_time, coalesce(regexp_extract(page1.page_location,r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') as page1_page, page1.sl_key as page1_session_id,
               page2.page_view_rank as page2_page_sequence_number, TIMESTAMP_MICROS(page2.event_timestamp) as page2_time, coalesce(regexp_extract(page2.page_location,r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') as page2_page, page2.sl_key as page2_session_id,
               page3.page_view_rank as page3_page_sequence_number, TIMESTAMP_MICROS(page3.event_timestamp) as page3_time, coalesce(regexp_extract(page3.page_location,r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') as page3_page, page3.sl_key as page3_session_id,
               page4.page_view_rank as page4_page_sequence_number, TIMESTAMP_MICROS(page4.event_timestamp) as page4_time, coalesce(regexp_extract(page4.page_location,r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') as page4_page, page4.sl_key as page4_session_id,
               page5.page_view_rank as page5_page_sequence_number, TIMESTAMP_MICROS(page5.event_timestamp) as page5_time, coalesce(regexp_extract(page5.page_location,r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') as page5_page, page5.sl_key as page5_session_id,
               page6.page_view_rank as page6_page_sequence_number, TIMESTAMP_MICROS(page6.event_timestamp) as page6_time, coalesce(regexp_extract(page6.page_location,r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') as page6_page, page6.sl_key as page6_session_id
      from ${sessions.SQL_TABLE_NAME} AS sessions
      left join UNNEST(sessions.event_data) as page1
      left join UNNEST(sessions.event_data) as page2
        on page1.sl_key = page2.sl_key and page1.page_view_rank + 1 = page2.page_view_rank
      left join UNNEST(sessions.event_data) as page3
        on page1.sl_key = page3.sl_key and page1.page_view_rank + 2 = page3.page_view_rank
      left join UNNEST(sessions.event_data) as page4
        on page1.sl_key = page4.sl_key and page1.page_view_rank + 3 = page4.page_view_rank
      left join UNNEST(sessions.event_data) as page5
        on page1.sl_key = page5.sl_key and page1.page_view_rank + 4 = page5.page_view_rank
      left join UNNEST(sessions.event_data) as page6
        on page1.sl_key = page6.sl_key and page1.page_view_rank + 5 = page6.page_view_rank
      where page1.page_view_rank = 1
        ;;
    persist_for: "24 hours"
  }

  ########## FILTERS ##########

  filter: page_1 {
    group_label: "Funnel Pages"
    suggest_explore: sessions
    suggest_dimension: hits.page_path_formatted
  }

  filter: page_2 {
    group_label: "Funnel Pages"
    suggest_explore: ga_sessions
    suggest_dimension: hits.page_path_formatted
  }

  filter: page_3 {
    group_label: "Funnel Pages"
    suggest_explore: ga_sessions
    suggest_dimension: hits.page_path_formatted
  }

  filter: page_4 {
    group_label: "Funnel Pages"
    suggest_explore: ga_sessions
    suggest_dimension: hits.page_path_formatted
  }

  filter: page_5 {
    group_label: "Funnel Pages"
    suggest_explore: ga_sessions
    suggest_dimension: hits.page_path_formatted
  }

  filter: page_6 {
    group_label: "Funnel Pages"
    suggest_explore: ga_sessions
    suggest_dimension: hits.page_path_formatted
  }

  ########## DIMENSIONS ##########

  dimension: full_vistor_id {
    type: string
    sql: ${TABLE}.full_vistor_id ;;
    hidden: yes
  }

  dimension: page1_hit_sequence_number {
    type: number
    sql: ${TABLE}.page1_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page1_hit_time {
    type: time
    sql: ${TABLE}.page1_hit_time ;;
    hidden: yes
  }

  dimension: page1_page {
    type: string
    sql: ${TABLE}.page1_page ;;
    hidden: yes
  }

  dimension: page1_hit_id {
    type: string
    sql: ${TABLE}.page1_hit_id ;;
    hidden: yes
  }

  dimension: page1_session_id {
    type: string
    sql: ${TABLE}.page1_session_id ;;
    hidden: yes
  }

  dimension: page2_hit_sequence_number {
    type: number
    sql: ${TABLE}.page2_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page2_time {
    type: time
    sql: ${TABLE}.page2_time ;;
    hidden: yes
  }

  dimension: page2_page {
    type: string
    sql: ${TABLE}.page2_page ;;
    hidden: yes
  }

  dimension: page2_hit_id {
    type: string
    sql: ${TABLE}.page2_hit_id ;;
    hidden: yes
  }

  dimension: page2_session_id {
    type: string
    sql: ${TABLE}.page2_session_id ;;
    hidden: yes
  }

  dimension: page3_hit_sequence_number {
    type: number
    sql: ${TABLE}.page3_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page3_time {
    type: time
    sql: ${TABLE}.page3_time ;;
    hidden: yes
  }

  dimension: page3_page {
    type: string
    sql: ${TABLE}.page3_page ;;
    hidden: yes
  }

  dimension: page3_hit_id {
    type: string
    sql: ${TABLE}.page3_hit_id ;;
    hidden: yes
  }

  dimension: page3_session_id {
    type: string
    sql: ${TABLE}.page3_session_id ;;
    hidden: yes
  }

  dimension: page4_hit_sequence_number {
    type: number
    sql: ${TABLE}.page4_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page4_time {
    type: time
    sql: ${TABLE}.page4_time ;;
    hidden: yes
  }

  dimension: page4_page {
    type: string
    sql: ${TABLE}.page4_page ;;
    hidden: yes
  }

  dimension: page4_hit_id {
    type: string
    sql: ${TABLE}.page4_hit_id ;;
    hidden: yes
  }

  dimension: page4_session_id {
    type: string
    sql: ${TABLE}.page4_session_id ;;
    hidden: yes
  }

  dimension: page5_hit_sequence_number {
    type: number
    sql: ${TABLE}.page5_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page5_time {
    type: time
    sql: ${TABLE}.page5_time ;;
    hidden: yes
  }

  dimension: page5_page {
    type: string
    sql: ${TABLE}.page5_page ;;
    hidden: yes
  }

  dimension: page5_hit_id {
    type: string
    sql: ${TABLE}.page5_hit_id ;;
    hidden: yes
  }

  dimension: page5_session_id {
    type: string
    sql: ${TABLE}.page5_session_id ;;
    hidden: yes
  }

  dimension: page6_hit_sequence_number {
    type: number
    sql: ${TABLE}.page6_hit_sequence_number ;;
    hidden: yes
  }

  dimension_group: page6_time {
    type: time
    sql: ${TABLE}.page6_time ;;
    hidden: yes
  }

  dimension: page6_page {
    type: string
    sql: ${TABLE}.page6_page ;;
    hidden: yes
  }

  dimension: page6_hit_id {
    type: string
    sql: ${TABLE}.page6_hit_id ;;
    hidden: yes
  }

  dimension: page6_session_id {
    type: string
    sql: ${TABLE}.page6_session_id ;;
    hidden: yes
  }



  dimension: page1_hit_time_tagged {
    sql: CASE WHEN {% condition page_1 %} ${page1_page} {% endcondition %} THEN ${page1_hit_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: page2_hit_time_tagged {
    sql: CASE WHEN {% condition page_2 %} ${page2_page} {% endcondition %} THEN ${page2_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: page3_hit_time_tagged {
    sql: CASE WHEN {% condition page_3 %} ${page3_page} {% endcondition %} THEN ${page3_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: page4_hit_time_tagged {
    sql: CASE WHEN {% condition page_4 %} ${page4_page} {% endcondition %} THEN ${page4_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: page5_hit_time_tagged {
    sql: CASE WHEN {% condition page_5 %} ${page5_page} {% endcondition %} THEN ${page5_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }

  dimension: page6_hit_time_tagged {
    sql: CASE WHEN {% condition page_6 %} ${page6_page} {% endcondition %} THEN ${page6_time_raw}
      ELSE NULL END ;;
    hidden: yes
  }


  dimension: page1_session_id_tagged {
    sql:  CASE WHEN {% condition page_1 %} ${page1_page} {% endcondition %}  THEN ${page1_session_id}
              ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: page2_session_id_tagged {
    sql:
          CASE WHEN {% condition page_2 %} ${page2_page} {% endcondition %}  AND ${page1_hit_time_tagged} < ${page2_hit_time_tagged} THEN ${page2_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: page3_session_id_tagged {
    sql:  CASE WHEN {% condition page_3 %} ${page3_page} {% endcondition %}  AND ${page1_hit_time_tagged} < ${page3_hit_time_tagged} AND ${page2_hit_time_tagged} < ${page3_hit_time_tagged} THEN ${page3_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: page4_session_id_tagged {
    sql:  CASE WHEN {% condition page_4 %} ${page4_page} {% endcondition %} AND ${page1_hit_time_tagged} < ${page4_hit_time_tagged} AND ${page2_hit_time_tagged} < ${page4_hit_time_tagged} AND ${page3_hit_time_tagged} < ${page4_hit_time_tagged} THEN ${page4_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: page5_session_id_tagged {
    sql:  CASE WHEN {% condition page_5 %} ${page5_page} {% endcondition %}  AND ${page1_hit_time_tagged} < ${page5_hit_time_tagged} AND ${page2_hit_time_tagged} < ${page5_hit_time_tagged} AND ${page3_hit_time_tagged} < ${page5_hit_time_tagged}  AND ${page4_hit_time_tagged} < ${page5_hit_time_tagged} THEN ${page5_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  dimension: page6_session_id_tagged {
    sql:  CASE WHEN {% condition page_6 %} ${page6_page} {% endcondition %} AND ${page1_hit_time_tagged} < ${page6_hit_time_tagged} AND ${page2_hit_time_tagged} < ${page6_hit_time_tagged} AND ${page3_hit_time_tagged} < ${page6_hit_time_tagged}  AND ${page4_hit_time_tagged} < ${page6_hit_time_tagged} AND ${page5_hit_time_tagged} < ${page6_hit_time_tagged} THEN ${page6_session_id}
            ELSE NULL END
            ;;
    hidden: yes
  }

  ########## MEASURES ##########

  measure: count_of_page_1 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page1_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_1._in_query %}
    {{_filters['page_funnel.page_1']}}
    {% else %}
    Count of Page 1
    {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_1']}}"
    }
  }

  measure: count_of_page_2 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page2_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_2._in_query %}
    {{_filters['page_funnel.page_2']}}
    {% else %}
    Count of Page 2
    {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_2']}}"
    }
  }

  measure: count_of_page_3 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page3_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_3._in_query %}
    {{_filters['page_funnel.page_3']}}
    {% else %}
    Count of Page 3
    {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_3']}}"
    }
  }

  measure: count_of_page_4 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page4_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_4._in_query %}
    {{_filters['page_funnel.page_4']}}
    {% else %}
    Count of Page 4
    {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_4']}}"
    }
  }

  measure: count_of_page_5 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page5_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_5._in_query %}
    {{_filters['page_funnel.page_5']}}
    {% else %}
    Count of Page 5
    {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_5']}}"
    }
  }

  measure: count_of_page_6 {
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${page6_session_id_tagged} ;;
    group_label: "Count of pages"
    label: "{% if page_6._in_query %}
    {{_filters['page_funnel.page_6']}}
    {% else %}
    Count of Page 6
    {% endif %}"
    link: {
      label: "Event Dashboard"
      url: "/dashboards/google_analytics_360::event_action_funnel?Page={{_filters['page_funnel.page_6']}}"
    }
  }

}
