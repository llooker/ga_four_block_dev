# Purpose: To house the fields used to generate Custom Goals. This file is extended into the `event_data` view.

###
# Adding New Goal Types:
# To create a new goal type, a new filter will be created. This filter will be used to compare values of an existing dimension.
# Each filter should correspond to an existing dimension (to be used in place of ${new_dimension_to_be_filtered} in Step 2 below).
#
# 1. Add a Filter -
#      filter: new_filter_name {
#        label: "New Filter Label"
#        view_label: "Goals"
#        group_label: "Goal Selection"
#        description: "New Goal Description"
#
# 2. Add your new filter to the sql parameter of the dynamic_goal, goal_in_query, and has_completed_goal dimensions -
#        dimension: dynamic_goal {
#          sql: IF( ${has_completed_goal}, CONCAT(
#                      IF({{ event_name_goal_selection._in_query }}, CONCAT(${event_name}, " "), "")
#                    , IF({{ page_goal_selection._in_query }}, CONCAT("on ", ${event_param_page}), "")
# ---->              , IF({{ new_filter_name._in_query }}, CONCAT(${new_dimension_to_be_filtered}), "")
#                    ), null );; }
#
#        dimension: goal_in_query {
#          sql: {{ event_name_goal_selection._in_query }}
#            OR {{ page_goal_selection._in_query }}
# ---->      OR {{ new_filter_name._in_query }} ;; }
#
#        dimension: has_completed_goal {
#          sql:if(
#                  ${goal_in_query}
#                  , {% condition event_name_goal_selection %} ${event_name} {% endcondition %}
#                      AND {% condition page_goal_selection %} ${event_param_page} {% endcondition %}
# ---->                AND {% condition new_filter_name %} ${new_dimension_to_be_filtered} {% endcondition %}
#                  , false
#                );; }
#
# 3. Add the newly created Filter to the Custom Goals Conversion dashboard and apply to all tiles.
###

view: goals {
  extension: required

## Filters

  filter: event_name_goal_selection {
    label: "Event Name"
    view_label: "Goals"
    group_label: "Goal Selection"
    description: "Enter Event Name to be used with Total Conversion measures."
    suggest_explore: sessions
    suggest_dimension: events.event_name
    suggest_persist_for: "0 seconds"
    type: string
  }

  filter: page_goal_selection {
    label: "Page"
    view_label: "Goals"
    group_label: "Goal Selection"
    description: "Enter Page Path to be used with Conversion measures (format should be: '/<page>'). Should not include Hostname."
    suggest_explore: sessions
    suggest_dimension: events.event_param_page
    type: string
  }

## Dimensions

  dimension: dynamic_goal {
    view_label: "Goals"
    group_label: "Goals"
    description: "Goal label based on Goal selection filters."
    type: string
    sql: IF( ${has_completed_goal}, CONCAT(
              IF({{ event_name_goal_selection._in_query }}, CONCAT(${event_name}, " "), "")
            , IF({{ page_goal_selection._in_query }}, CONCAT("on ", ${event_param_page}), "")
            ), null );;
  }

  dimension: goal_in_query {
    description: "Check to verify user has entered a value for at least one goal filter."
    hidden: yes
    type: yesno
    sql: {{ event_name_goal_selection._in_query }}
          OR {{ page_goal_selection._in_query }};;
  }

  dimension: has_completed_goal {
    view_label: "Goals"
    group_label: "Goals"
    description: "A session that resulted in a conversion (i.e. resulted in reaching successful point on website defined in 'Goal Selection' field)."
    type: yesno
    sql:if(
          ${goal_in_query}
          , {% condition event_name_goal_selection %} ${event_name} {% endcondition %}
              AND {% condition page_goal_selection %} ${event_param_page} {% endcondition %}
          , false
        );;
  }

## Measures
  measure: conversion_count {
    view_label: "Goals"
    group_label: "Goal Conversions"
    label: "Total Conversions"
    description: "Total number of hits (Page or Event) that are identified as converisons based on 'Goal Selection' filters."
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${ed_key} ;;
    filters: [has_completed_goal: "yes"]
    value_format_name: formatted_number
    drill_fields: []
  }

  measure: sessions_with_conversions {
    view_label: "Goals"
    group_label: "Goal Conversions"
    label: "Sessions with Conversion"
    description: "Sessions that result in a conversion based on 'Goal Selection' filters."
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${sessions.sl_key} ;;
    filters: [has_completed_goal: "yes"]
    value_format_name: formatted_number
    drill_fields: [client_id, visit_number, sessions_with_conversions]
  }

  measure: session_conversion_rate {
    view_label: "Goals"
    group_label: "Goal Conversions"
    label: "Session Conversion Rate"
    description: "Percentage of sessions resulting in a conversion based on 'Goal Selection' filters."
    type: number
    sql: (1.0*${sessions_with_conversions})/NULLIF(${sessions.total_sessions}, 0) ;;
    value_format_name: percent_1
    drill_fields: []
  }
}
