connection: "looker-demos"
include: "*.view.lkml"
include: "/views/*.view.lkml"
include: "/attributes/*.lkml"

datagroup: generated_model_default_datagroup {
  sql_trigger:  SELECT FLOOR(((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) - 60*60*6)/(60*60*24));;
  max_cache_age: "1 hour"
}

persist_with: generated_model_default_datagroup

explore: events_20201008 {

  join: events_20201008__items {
    view_label: "Events 20201008: Items"
    sql: LEFT JOIN UNNEST(${events_20201008.items}) as events_20201008__items ;;
    relationship: one_to_many
  }

  join: events_20201008__event_params {
    view_label: "Events 20201008: Event Params"
    sql: LEFT JOIN UNNEST(${events_20201008.event_params}) as events_20201008__event_params ;;
    relationship: one_to_many
  }

  join: events_20201008__user_properties {
    view_label: "Events 20201008: User Properties"
    sql: LEFT JOIN UNNEST(${events_20201008.user_properties}) as events_20201008__user_properties ;;
    relationship: one_to_many
  }
}

explore: sessions {

  join: event_data {
    sql: LEFT JOIN UNNEST(${sessions.event_data}) as event_data ;;
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

}
