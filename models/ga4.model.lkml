connection: "looker-demos"

label: "Google Analytics 4"

include: "/views/*.view.lkml"
include: "/views/*/*.view.lkml"
include: "/attributes/*.lkml"

datagroup: generated_model_default_datagroup {
  sql_trigger:  SELECT FLOOR(((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) - 60*60*6)/(60*60*24));;
  max_cache_age: "1 hour"
}

persist_with: generated_model_default_datagroup

explore: sessions {
  label: "GA4 Sessions"
  description: "Explores Google Analytics sessions data."

  join: audience_cohorts {
    type: left_outer
    sql_on: ${sessions.audience_trait} = ${audience_cohorts.audience_trait} ;;
    relationship: many_to_one
  }

  join: events {
    view_label: "Events"
    sql: LEFT JOIN UNNEST(${sessions.event_data}) as events with offset as event_row ;;
    relationship: one_to_many
  }

  join: event_data_items {
    view_label: "Events"
    sql: LEFT JOIN UNNEST(${events.items}) as event_data_items  ;;
    relationship: one_to_many
    required_joins: [events]
  }

  join: user_previous_session {
    view_label: "GA4 Sessions"
    sql_on: ${sessions.sl_key} = ${user_previous_session.sl_key} ;;
    relationship: one_to_one
  }

}
