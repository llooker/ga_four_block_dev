## PURPOSE: This view is for a convenient location to define dimensions and measures sourced from the event_data element in sessions.
## Event_Data represents the source event level rows from the GA Export Dataset.
## The following views are defined in this file:
##   - event_data
##   - event_data_event_params
##   - event_data_user_properties
##   - event_data_items

include: "event_data_event_params.view"
include: "goals.view"

view: event_data {
  extends: [event_data_event_params, goals]

## Dimensions

  dimension: ed_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${sl_key}||${event_rank} ;;
  }

  dimension: sl_key {
    type: string
    hidden: yes
    sql: ${TABLE}.sl_key ;;
  }

  dimension: event_rank {
    type: number
    sql: event_row ;;
  }

  dimension: event_date {
    type: string
    sql: ${TABLE}.event_date ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: full_event {
    ## Customize with your specific event parameters that encompass the specific points of interest in your event.
    type: string
    sql: ${event_name}||': '||coalesce(${event_data.event_param_page},"") ;;
  }

  dimension: event_params {
    hidden: yes
    sql: ${TABLE}.event_params ;;
    ## This is the parent dimension for the event_params fields within the event_data_event_params view.
  }

  dimension: event_timestamp {
    type: number
    sql: ${TABLE}.event_timestamp ;;
  }

  dimension: event_bundle_sequence_id {
    type: number
    sql: ${TABLE}.event_bundle_sequence_id ;;
  }

  dimension: event_dimensions__hostname {
    type: string
    sql: ${TABLE}.event_dimensions.hostname ;;
    group_label: "Event Dimensions"
    group_item_label: "Hostname"
  }

  dimension: event_previous_timestamp {
    type: number
    sql: ${TABLE}.event_previous_timestamp ;;
  }

  dimension: event_server_timestamp_offset {
    type: number
    sql: ${TABLE}.event_server_timestamp_offset ;;
  }

  dimension: event_value_in_usd {
    type: number
    sql: ${TABLE}.event_value_in_usd ;;
  }

  dimension: items {
    hidden: yes
    sql: ${TABLE}.items ;;
    ## This is the parent dimension for the items fields within the event_data_items view.
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: stream_id {
    type: string
    sql: ${TABLE}.stream_id ;;
  }

  ## App Info Fields
  dimension: app_info__firebase_app_id {
    type: string
    sql: ${TABLE}.app_info.firebase_app_id ;;
    group_label: "App Info"
    group_item_label: "Firebase App ID"
  }

  dimension: app_info__id {
    type: string
    sql: ${TABLE}.app_info.id ;;
    group_label: "App Info"
    group_item_label: "ID"
  }

  dimension: app_info__install_source {
    type: string
    sql: ${TABLE}.app_info.install_source ;;
    group_label: "App Info"
    group_item_label: "Install Source"
  }

  dimension: app_info__install_store {
    type: string
    sql: ${TABLE}.app_info.install_store ;;
    group_label: "App Info"
    group_item_label: "Install Store"
  }

  dimension: app_info__version {
    type: string
    sql: ${TABLE}.app_info.version ;;
    group_label: "App Info"
    group_item_label: "Version"
  }


  ## Device Fields
  dimension: device__advertising_id {
    type: string
    sql: ${TABLE}.device.advertising_id ;;
    group_label: "Device"
    group_item_label: "Advertising ID"
  }

  dimension: device__browser {
    type: string
    sql: ${TABLE}.device.browser ;;
    group_label: "Device"
    group_item_label: "Browser"
  }

  dimension: device__browser_version {
    type: string
    sql: ${TABLE}.device.browser_version ;;
    group_label: "Device"
    group_item_label: "Browser Version"
  }

  dimension: device__category {
    type: string
    sql: ${TABLE}.device.category ;;
    group_label: "Device"
    group_item_label: "Category"
  }

  dimension: device__is_limited_ad_tracking {
    type: string
    sql: ${TABLE}.device.is_limited_ad_tracking ;;
    group_label: "Device"
    group_item_label: "Is Limited Ad Tracking"
  }

  dimension: device__language {
    type: string
    sql: ${TABLE}.device.language ;;
    group_label: "Device"
    group_item_label: "Language"
  }

  dimension: device__mobile_brand_name {
    type: string
    sql: ${TABLE}.device.mobile_brand_name ;;
    group_label: "Device"
    group_item_label: "Mobile Brand Name"
  }

  dimension: device__mobile_marketing_name {
    type: string
    sql: ${TABLE}.device.mobile_marketing_name ;;
    group_label: "Device"
    group_item_label: "Mobile Marketing Name"
  }

  dimension: device__mobile_model_name {
    type: string
    sql: ${TABLE}.device.mobile_model_name ;;
    group_label: "Device"
    group_item_label: "Mobile Model Name"
  }

  dimension: device__mobile_os_hardware_model {
    type: string
    sql: ${TABLE}.device.mobile_os_hardware_model ;;
    group_label: "Device"
    group_item_label: "Mobile OS Hardware Model"
  }

  dimension: device__operating_system {
    type: string
    sql: ${TABLE}.device.operating_system ;;
    group_label: "Device"
    group_item_label: "Operating System"
  }

  dimension: device__operating_system_version {
    type: string
    sql: ${TABLE}.device.operating_system_version ;;
    group_label: "Device"
    group_item_label: "Operating System Version"
  }

  dimension: device__time_zone_offset_seconds {
    type: number
    sql: ${TABLE}.device.time_zone_offset_seconds ;;
    group_label: "Device"
    group_item_label: "Time Zone Offset Seconds"
  }

  dimension: device__vendor_id {
    type: string
    sql: ${TABLE}.device.vendor_id ;;
    group_label: "Device"
    group_item_label: "Vendor ID"
  }

  dimension: device__web_info__browser {
    type: string
    sql: ${TABLE}.device.web_info.browser ;;
    group_label: "Device Web Info"
    group_item_label: "Browser"
  }

  dimension: device__web_info__browser_version {
    type: string
    sql: ${TABLE}.device.web_info.browser_version ;;
    group_label: "Device Web Info"
    group_item_label: "Browser Version"
  }

  dimension: device__web_info__hostname {
    type: string
    sql: ${TABLE}.device.web_info.hostname ;;
    group_label: "Device Web Info"
    group_item_label: "Hostname"
  }


  ## ECommerce Fields
  dimension: ecommerce__purchase_revenue {
    type: number
    sql: ${TABLE}.ecommerce.purchase_revenue ;;
    group_label: "Ecommerce"
    group_item_label: "Purchase Revenue"
    value_format_name: usd
  }

  dimension: ecommerce__purchase_revenue_in_usd {
    type: number
    sql: ${TABLE}.ecommerce.purchase_revenue_in_usd ;;
    group_label: "Ecommerce"
    group_item_label: "Purchase Revenue In USD"
    value_format_name: usd
  }

  dimension: ecommerce__refund_value {
    type: number
    sql: ${TABLE}.ecommerce.refund_value ;;
    group_label: "Ecommerce"
    group_item_label: "Refund Value"
    value_format_name: usd
  }

  dimension: ecommerce__refund_value_in_usd {
    type: number
    sql: ${TABLE}.ecommerce.refund_value_in_usd ;;
    group_label: "Ecommerce"
    group_item_label: "Refund Value In USD"
    value_format_name: usd
  }

  dimension: ecommerce__shipping_value {
    type: number
    sql: ${TABLE}.ecommerce.shipping_value ;;
    group_label: "Ecommerce"
    group_item_label: "Shipping Value"
    value_format_name: usd
  }

  dimension: ecommerce__shipping_value_in_usd {
    type: number
    sql: ${TABLE}.ecommerce.shipping_value_in_usd ;;
    group_label: "Ecommerce"
    group_item_label: "Shipping Value In USD"
    value_format_name: usd
  }

  dimension: ecommerce__tax_value {
    type: number
    sql: ${TABLE}.ecommerce.tax_value ;;
    group_label: "Ecommerce"
    group_item_label: "Tax Value"
    value_format_name: usd
  }

  dimension: ecommerce__tax_value_in_usd {
    type: number
    sql: ${TABLE}.ecommerce.tax_value_in_usd ;;
    group_label: "Ecommerce"
    group_item_label: "Tax Value In USD"
    value_format_name: usd
  }

  dimension: ecommerce__total_item_quantity {
    type: number
    sql: ${TABLE}.ecommerce.total_item_quantity ;;
    group_label: "Ecommerce"
    group_item_label: "Total Item Quantity"
    value_format_name: decimal_0
  }

  dimension: ecommerce__transaction_id {
    type: string
    sql: ${TABLE}.ecommerce.transaction_id ;;
    group_label: "Ecommerce"
    group_item_label: "Transaction ID"
  }

  dimension: ecommerce__unique_items {
    type: number
    sql: ${TABLE}.ecommerce.unique_items ;;
    group_label: "Ecommerce"
    group_item_label: "Unique Items"
    value_format_name: decimal_0
  }


  ## Geo Fields
  dimension: geo__city {
    type: string
    sql: ${TABLE}.geo.city ;;
    group_label: "Geo"
    group_item_label: "City"
  }

  dimension: geo__continent {
    type: string
    sql: ${TABLE}.geo.continent ;;
    group_label: "Geo"
    group_item_label: "Continent"
  }

  dimension: geo__country {
    type: string
    sql: ${TABLE}.geo.country ;;
    group_label: "Geo"
    group_item_label: "Country"
    map_layer_name: countries
  }

  dimension: geo__metro {
    type: string
    sql: ${TABLE}.geo.metro ;;
    group_label: "Geo"
    group_item_label: "Metro"
  }

  dimension: geo__region {
    type: string
    sql: ${TABLE}.geo.region ;;
    group_label: "Geo"
    group_item_label: "Region"
    map_layer_name: us_states
  }

  dimension: geo__sub_continent {
    type: string
    sql: ${TABLE}.geo.sub_continent ;;
    group_label: "Geo"
    group_item_label: "Sub Continent"
  }


  ## Traffic Source Fields
  dimension: traffic_source__medium {
    type: string
    sql: ${TABLE}.traffic_source.medium ;;
    group_label: "Traffic Source"
    group_item_label: "Medium"
  }

  dimension: traffic_source__name {
    type: string
    sql: ${TABLE}.traffic_source.name ;;
    group_label: "Traffic Source"
    group_item_label: "Name"
  }

  dimension: traffic_source__source {
    type: string
    sql: ${TABLE}.traffic_source.source ;;
    group_label: "Traffic Source"
    group_item_label: "Source"
  }

  ## User Fields
  dimension: user_first_touch_timestamp {
    type: number
    sql: ${TABLE}.user_first_touch_timestamp ;;
  }

  dimension: user_ltv__currency {
    type: string
    sql: ${TABLE}.user_ltv.currency ;;
    group_label: "User Ltv"
    group_item_label: "Currency"
  }

  dimension: user_ltv__revenue {
    type: number
    sql: ${TABLE}.user_ltv.revenue ;;
    group_label: "User Ltv"
    group_item_label: "Revenue"
  }

  dimension: user_properties {
    hidden: yes
    sql: ${TABLE}.user_properties ;;
  }

  dimension: user_pseudo_id {
    type: string
    sql: ${TABLE}.user_pseudo_id ;;
  }

  # dimension: user_id

## Measures

  measure: total_events {
    type: count
    view_label: "Metrics"
    group_label: "Event Data"
    label: "Total Events"
  }

  measure: total_unique_events {
    view_label: "Metrics"
    group_label: "Event Data"
    label: "Total Unique Events"
    type: count_distinct
    sql: ${sl_key} ;;
    description: "Total Unique Events (Unique by Full Event Definition)"
  }


  measure: total_page_views {
    view_label: "Metrics"
    group_label: "Event Data"
    label: "Total Page Views"
    type: count
    filters: [event_name: "page_view"]
    value_format_name: formatted_number
  }

  measure: total_unique_page_views {
    view_label: "Metrics"
    group_label: "Event Data"
    label: "Total Unique Page Views"
    type: count_distinct
    sql: CONCAT(${event_param_ga_session_id}, ${event_param_page}, ${event_param_page_title}) ;;
    value_format_name: formatted_number
  }

  measure: total_unique_page_views_percentage {
    view_label: "Metrics"
    group_label: "Event Data"
    label: "Total Unique Page Views Percentage"
    type: number
    sql: ${total_unique_page_views}/nullif(${total_page_views},0) ;;
    value_format_name: percent_2
    required_fields: [total_unique_page_views]
  }

  ## ECommerce

    measure: total_transactions {
      type: count_distinct
      sql: ${ecommerce__transaction_id} ;;
      filters: [ecommerce__transaction_id: "-(not set)"]
    }

    measure: transaction_conversion_rate {
      type: number
      sql: 1.0 * (${total_transactions}/NULLIF(${sessions.total_sessions},0)) ;;
      value_format_name: percent_2
    }

    measure: total_purchase_revenue {
      type: sum_distinct
      sql: ${ecommerce__purchase_revenue} ;;
      sql_distinct_key: ${ecommerce__transaction_id} ;;
      value_format_name: usd
    }

    measure: total_purchase_revenue_usd {
      type: sum
      sql: ${ecommerce__purchase_revenue_in_usd} ;;
      # sql_distinct_key: ${ecommerce__transaction_id} ;;
      value_format_name: usd
    }

    measure: total_refund_value {
      type: sum_distinct
      sql: ${ecommerce__refund_value} ;;
      sql_distinct_key: ${ecommerce__transaction_id} ;;
      value_format_name: usd
    }

    measure: total_refund_value_usd {
      type: sum_distinct
      sql: ${ecommerce__refund_value_in_usd} ;;
      sql_distinct_key: ${ecommerce__transaction_id} ;;
      value_format_name: usd
    }

    measure: total_shipping_value {
      type: sum_distinct
      sql: ${ecommerce__shipping_value} ;;
      sql_distinct_key: ${ecommerce__transaction_id} ;;
      value_format_name: usd
    }

    measure: total_shipping_value_usd {
      type: sum_distinct
      sql: ${ecommerce__shipping_value_in_usd} ;;
      sql_distinct_key: ${ecommerce__transaction_id} ;;
      value_format_name: usd
    }

    measure: total_tax_value {
      type: sum_distinct
      sql: ${ecommerce__tax_value} ;;
      sql_distinct_key: ${ecommerce__transaction_id} ;;
      value_format_name: usd
    }

    measure: total_tax_value_usd {
      type: sum_distinct
      sql: ${ecommerce__tax_value_in_usd} ;;
      sql_distinct_key: ${ecommerce__transaction_id} ;;
      value_format_name: usd
    }

    measure: total_item_quantity {
      type: sum_distinct
      sql: ${ecommerce__total_item_quantity} ;;
      sql_distinct_key: ${ecommerce__transaction_id} ;;
      value_format_name: decimal_0
    }

    measure: total_unique_items {
      type: sum_distinct
      sql: ${ecommerce__unique_items} ;;
      sql_distinct_key: ${ecommerce__transaction_id} ;;
      value_format_name: decimal_0
    }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      event_name,
      traffic_source__name,
      device__mobile_model_name,
      device__mobile_brand_name,
      device__web_info__hostname,
      event_dimensions__hostname,
      device__mobile_marketing_name
    ]
  }
}
