view: event_data_event_params {
  extension: required

  ## Event Parameters
  ## Because there are multiple "key"/"value" rows per event, these are unnested at the dimension level.
  ## This view is included in event_data.view, and not directly joined on the model.

  dimension: event_param_all_data {
    group_label: "Event: Parameters"
    label: "All Data"
    type: number
    sql: (SELECT value.double_value FROM UNNEST(event_params) WHERE key = "all_data") ;;
  }

  dimension: event_param_campaign {
    group_label: "Event: Parameters"
    label: "Campaign"
    description: "The campaign value. Usually set by the utm_campaign URL parameter."
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "campaign") ;;
    full_suggestions: yes
  }

  dimension: event_param_clean_event {
    group_label: "Event: Parameters"
    label: "Clean Event"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "clean_event") ;;
    full_suggestions: yes
  }

  dimension: event_param_debug_mode {
    group_label: "Event: Parameters"
    label: "Debug Mode"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = "debug_mode") ;;
  }

  dimension: event_param_engaged_session_event {
    group_label: "Event: Parameters"
    label: "Session Event"
    type: number
    sql: (SELECT coalesce(cast(value.string_value as INT64),value.int_value) FROM UNNEST(event_params) WHERE key = "engaged_session_event") ;;
  }

  dimension: event_param_engagement_time_msec {
    group_label: "Event: Parameters"
    label: "Engagement Time MSEC"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = "engagement_time_msec") ;;
  }

  dimension: event_param_entrances {
    group_label: "Event: Parameters"
    label: "Entrances"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = "entrances") ;;
  }

  dimension: event_param_ga_session_id {
    group_label: "Event: Parameters"
    label: "GA Session ID"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = "ga_session_id") ;;
    full_suggestions: yes
  }

  dimension: event_param_ga_session_number {
    group_label: "Event: Parameters"
    label: "GA Session Number"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = "ga_session_number") ;;
  }

  dimension: event_param_medium {
    group_label: "Event: Parameters"
    label: "Medium"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "medium") ;;
    full_suggestions: yes
  }

  dimension: event_param_host {
    group_label: "Event: Parameters"
    label: "Host"
    description: "Host of Page View URL"
    full_suggestions: yes
    type: string
    sql: NET.HOST((SELECT value.string_value FROM UNNEST(event_params) WHERE key = "page_location")) ;;
  }

  dimension: event_param_page {
    group_label: "Event: Parameters"
    label: "Page"
    description: "The path of the page."
    full_suggestions: yes
    type: string
    sql: coalesce(regexp_extract((SELECT value.string_value FROM UNNEST(event_params) WHERE key = "page_location"),r"(?:.*?[\.][^\/]*)([\/][^\?#]+)"),'/') ;;
  }

  # The "Page" event parameter may not be enabled, in which situation the above regex query will extract the path from the page location value.
  # If the "Page" event parameter is enabled, you may use this below dimension instead if desired:
  # dimension: event_param_page_path {
  #   group_label: "Event: Parameters"
  #   label: "Page"
  #   description: "The Page Path value"
  #   full_suggestions: yes
  #   type: string
  #   sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "page") ;;
  # }

  dimension: event_param_page_location {
    group_label: "Event: Parameters"
    label: "Page Location"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "page_location") ;;
    full_suggestions: yes
  }

  dimension: event_param_page_referrer {
    group_label: "Event: Parameters"
    label: "Page Referrer"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "page_referrer") ;;
    full_suggestions: yes
  }

  dimension: event_param_page_title {
    group_label: "Event: Parameters"
    label: "Page Title"
    description: "The page's title. Multiple pages might have the same page title."
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "page_title") ;;
    full_suggestions: yes
  }

  dimension: event_param_percent_scrolled {
    group_label: "Event: Parameters"
    label: "Percent Scrolled"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = "percent_scrolled") ;;
  }

  dimension: event_param_session_engaged {
    group_label: "Event: Parameters"
    label: "Session Engaged"
    type: number
    sql: (SELECT coalesce(cast(value.string_value as INT64),value.int_value) FROM UNNEST(event_params) WHERE key = "session_engaged") ;;
  }

  dimension: event_param_source {
    group_label: "Event: Parameters"
    label: "Source"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "source") ;;
    full_suggestions: yes
  }

  dimension: event_param_synthetic_bundle {
    group_label: "Event: Parameters"
    label: "Synthetic Bundle"
    type: number
    sql: (SELECT coalesce(cast(value.string_value as INT64),value.int_value) FROM UNNEST(event_params) WHERE key = "synthetic_bundle") ;;
  }

  dimension: event_param_term {
    # group_label: "Event: Parameters"
    # label: "Term"
    view_label: "Acquisition"
    group_label: "Advertising"
    label: "Keyword"
    description: "The Event keyword of the traffic source, usually set when the trafficSource.medium is 'organic' or 'cpc'. Can be set by the utm_term URL parameter."
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "term") ;;
    full_suggestions: yes
  }

}
