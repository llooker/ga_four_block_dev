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

  ########## CUSTOM PARAMS

  dimension: custom_add_one_more_hour_action {
    group_label: "Event: Additional Parameters"
    label: "add_one_more_hour_action"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'add_one_more_hour_action') ;;
  }

dimension: custom_add_one_more_hour_amount {
    group_label: "Event: Additional Parameters"
    label: "add_one_more_hour_amount"
    type: string
    sql: (SELECT value.double_value FROM UNNEST(event_params) WHERE key = 'add_one_more_hour_amount') ;;
  }

dimension: custom_book_again_type {
    group_label: "Event: Additional Parameters"
    label: "book_again_type"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'book_again_type') ;;
  }

dimension: custom_coupon {
    group_label: "Event: Additional Parameters"
    label: "coupon"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'coupon') ;;
  }

dimension: custom_error_message_category {
    group_label: "Event: Additional Parameters"
    label: "error_message_category"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'error_message_category') ;;
  }

dimension: custom_error_message_label {
    group_label: "Event: Additional Parameters"
    label: "error_message_label"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'error_message_label') ;;
  }

dimension: custom_ignore_referrer {
    group_label: "Event: Additional Parameters"
    label: "ignore_referrer"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'ignore_referrer') ;;
  }

dimension: custom_item_list_id {
    group_label: "Event: Additional Parameters"
    label: "item_list_id"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'item_list_id') ;;
  }

dimension: custom_item_list_name {
    group_label: "Event: Additional Parameters"
    label: "item_list_name"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'item_list_name') ;;
  }

dimension: custom_om_campaign_name {
    group_label: "Event: Additional Parameters"
    label: "om_campaign_name"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'om_campaign_name') ;;
  }

dimension: custom_payment_type {
    group_label: "Event: Additional Parameters"
    label: "payment_type"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'payment_type') ;;
  }

dimension: custom_promotion_amount {
    group_label: "Event: Additional Parameters"
    label: "promotion_amount"
    type: string
    sql: (SELECT value.double_value FROM UNNEST(event_params) WHERE key = 'promotion_amount') ;;
  }

dimension: custom_promotion_name {
    group_label: "Event: Additional Parameters"
    label: "promotion_name"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'promotion_name') ;;
  }

dimension: custom_promotion_type {
    group_label: "Event: Additional Parameters"
    label: "promotion_type"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'promotion_type') ;;
  }

dimension: custom_purchased_day {
    group_label: "Event: Additional Parameters"
    label: "purchased_day"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'purchased_day') ;;
  }

dimension: custom_purchased_duration {
    group_label: "Event: Additional Parameters"
    label: "purchased_duration"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'purchased_duration') ;;
  }

dimension: custom_purchased_product {
    group_label: "Event: Additional Parameters"
    label: "purchased_product"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'purchased_product') ;;
  }

dimension: custom_purchased_site {
    group_label: "Event: Additional Parameters"
    label: "purchased_site"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'purchased_site') ;;
  }

dimension: custom_purchased_subtype {
    group_label: "Event: Additional Parameters"
    label: "purchased_subtype"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'purchased_subtype') ;;
  }

dimension: custom_raf_share_location_method {
    group_label: "Event: Additional Parameters"
    label: "raf_share_location_method"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'raf_share_location_method') ;;
  }

dimension: custom_referral_show_or_hide {
    group_label: "Event: Additional Parameters"
    label: "referral_show_or_hide"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'referral_show_or_hide') ;;
  }

dimension: custom_search_count_for_sessions {
    group_label: "Event: Additional Parameters"
    label: "search_count_for_sessions"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'search_count_for_sessions') ;;
  }

dimension: custom_search_results_count {
    group_label: "Event: Additional Parameters"
    label: "search_results_count"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'search_results_count') ;;
  }

dimension: custom_search_results_returned {
    group_label: "Event: Additional Parameters"
    label: "search_results_returned"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'search_results_returned') ;;
  }

dimension: custom_search_term {
    group_label: "Event: Additional Parameters"
    label: "search_term"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'search_term') ;;
  }

dimension: custom_searched_for_day {
    group_label: "Event: Additional Parameters"
    label: "searched_for_day"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'searched_for_day') ;;
  }

dimension: custom_searched_for_day_of_week {
    group_label: "Event: Additional Parameters"
    label: "searched_for_day_of_week"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'searched_for_day_of_week') ;;
  }

dimension: custom_searched_for_duration {
    group_label: "Event: Additional Parameters"
    label: "searched_for_duration"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'searched_for_duration') ;;
  }

dimension: custom_searched_for_site {
    group_label: "Event: Additional Parameters"
    label: "searched_for_site"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'searched_for_site') ;;
  }

dimension: custom_searched_for_subtype {
    group_label: "Event: Additional Parameters"
    label: "searched_for_subtype"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'searched_for_subtype') ;;
  }

dimension: custom_searched_for_time {
    group_label: "Event: Additional Parameters"
    label: "searched_for_time"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'searched_for_time') ;;
  }

dimension: custom_searched_for_type {
    group_label: "Event: Additional Parameters"
    label: "searched_for_type"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'searched_for_type') ;;
  }

dimension: custom_selected_room_availability {
    group_label: "Event: Additional Parameters"
    label: "selected_room_availability"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'selected_room_availability') ;;
  }

dimension: custom_transaction_id {
    group_label: "Event: Additional Parameters"
    label: "transaction_id"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'transaction_id') ;;
  }

dimension: custom_value {
    group_label: "Event: Additional Parameters"
    label: "value"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'value') ;;
  }

dimension: custom_verification_screen {
    group_label: "Event: Additional Parameters"
    label: "verification_screen"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'verification_screen') ;;
  }
##
  dimension: custom_alternative_slot_time_count {
    group_label: "Event: Additional Parameters"
    label: "alternative_slot_time_count"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'alternative_slot_time_count') ;;
  }

  dimension: custom_alternative_slot_time_variance {
    group_label: "Event: Additional Parameters"
    label: "alternative_slot_time_variance"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'alternative_slot_time_variance') ;;
  }

  dimension: custom_next_available_slots_count {
    group_label: "Event: Additional Parameters"
    label: "next_available_slots_count"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'next_available_slots_count') ;;
  }

  dimension: custom_previous_available_slots_count {
    group_label: "Event: Additional Parameters"
    label: "previous_available_slots_count"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'previous_available_slots_count') ;;
  }

  dimension: custom_same_available_slots_count {
    group_label: "Event: Additional Parameters"
    label: "same_available_slots_count"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'same_available_slots_count') ;;
  }

  dimension: custom_day_viewed {
    group_label: "Event: Additional Parameters"
    label: "day_viewed"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'day_viewed') ;;
  }

  dimension: custom_braze_banner_campaign {
    group_label: "Event: Additional Parameters"
    label: "braze_banner_campaign"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'braze_banner_campaign') ;;
  }

  dimension: ab_test_bucket {
    group_label: "Event: Additional Parameters"
    label: "ab_test_bucket"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(user_properties) WHERE key = 'ab_test_bucket') ;;
  }

  dimension: experiment_1_bucket {
    group_label: "Event: Additional Parameters"
    label: "experiment_1_bucket"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(user_properties) WHERE key = 'experiment_1_bucket') ;;
  }

  dimension: user_id_external {
    group_label: "Event: Additional Parameters"
    label: "user_id_external"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(user_properties) WHERE key = 'user_id_external') ;;
  }

  dimension: experiment_2_bucket {
    group_label: "Event: Additional Parameters"
    label: "experiment_2_bucket"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(user_properties) WHERE key = 'experiment_2_bucket') ;;
  }

  dimension: experiment_3_bucket {
    group_label: "Event: Additional Parameters"
    label: "experiment_3_bucket"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(user_properties) WHERE key = 'experiment_3_bucket') ;;
  }

  dimension: custom_available_points {
    group_label: "Event: Additional Parameters"
    label: "available_points"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'available_points') ;;
  }

  dimension: custom_redeemable_items_count {
    group_label: "Event: Additional Parameters"
    label: "redeemable_items_count"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'redeemable_items_count') ;;
  }

  dimension: custom_reward_type {
    group_label: "Event: Additional Parameters"
    label: "reward_type"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'reward_type') ;;
  }

  dimension: custom_points_worth {
    group_label: "Event: Additional Parameters"
    label: "points_worth"
    type: number
    sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'points_worth') ;;
  }

  dimension: user {
    group_label: "Event: IOS Additional Parameters"
    label: "user_id"
    type: number
    sql: CAST((SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'user') as INT64) ;;
  }

  dimension: booking {
    group_label: "Event: IOS Additional Parameters"
    label: "booking_id"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'booking') ;;
  }

  dimension: record_mode {
    group_label: "Event: IOS Additional Parameters"
    label: "record_mode"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'record_mode') ;;
  }

  dimension: screen_orientation {
    group_label: "Event: IOS Additional Parameters"
    label: "screen_orientation"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'screen_orientation') ;;
  }

  dimension: camera_mode {
    group_label: "Event: IOS Additional Parameters"
    label: "camera_mode"
    type: string
    sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'camera_mode') ;;
  }

  dimension: recording_length {
    group_label: "Event: IOS Additional Parameters"
    label: "recording_length"
    type: number
    sql: (SELECT value.double_value FROM UNNEST(event_params) WHERE key = 'recording_length') ;;
  }

}
