label: "Google Analytics 4"
connection: "looker-demos"
include: "/views/*.view.lkml"
include: "/attributes/*.lkml"

datagroup: generated_model_default_datagroup {
  sql_trigger:  SELECT FLOOR(((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) - 60*60*6)/(60*60*24));;
  max_cache_age: "1 hour"
}

persist_with: generated_model_default_datagroup

explore: sessions {
  label: "GA4 Sessions"

  join: audience_cohorts {
    type: left_outer
    sql_on: ${sessions.audience_trait} = ${audience_cohorts.audience_trait} ;;
    relationship: many_to_one
  }

  join: event_data {
    sql: LEFT JOIN UNNEST(${sessions.event_data}) as event_data with offset as event_row ;;
    relationship: one_to_many
  }

  join: event_data_items {
    view_label: "Event Data"
    sql: LEFT JOIN UNNEST(${event_data.items}) as event_data_items  ;;
    relationship: one_to_many
    required_joins: [event_data]
  }

  join: event_data_user_properties {
    view_label: "Event Data"
    sql: left join unnest(${event_data.user_properties}) as event_data_user_properties ;;
    relationship: one_to_many
  }

  join: event_path {
    view_label: "Event Data"
    sql_on: ${sessions.sl_key} = ${event_path.sl_key}
        and ${event_data.ed_key} = ${event_path.ed_key} ;;
        relationship: one_to_one
  }

  join: page_views {
    type: left_outer
    sql_on: ${sessions.sl_key} = ${page_views.sl_key}
        and ${page_views.ed_key} = ${event_data.ed_key} ;;
    relationship: one_to_one
  }

  join: page_entrance_exit {
    type: left_outer
    sql_on: ${sessions.sl_key} = ${page_entrance_exit.sl_key} ;;
    relationship: one_to_one
  }

}
