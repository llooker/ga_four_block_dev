## Purpose: This view is for defining the 'event_data' 'Item' specific fields. This view unnested from event_data in the 'sessions' explore.

view: event_data_items {

## Dimensions
  dimension: affiliation {
    group_label: "Items"
    type: string
    sql: ${TABLE}.affiliation ;;
    full_suggestions: yes
  }

  dimension: coupon {
    group_label: "Items"
    type: string
    sql: ${TABLE}.coupon ;;
    full_suggestions: yes
  }

  dimension: creative_name {
    group_label: "Items"
    type: string
    sql: ${TABLE}.creative_name ;;
    full_suggestions: yes
  }

  dimension: creative_slot {
    group_label: "Items"
    type: string
    sql: ${TABLE}.creative_slot ;;
    full_suggestions: yes
  }

  dimension: item_brand {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_brand ;;
    full_suggestions: yes
  }

  dimension: item_category {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_category ;;
    full_suggestions: yes
  }

  dimension: item_category2 {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_category2 ;;
    full_suggestions: yes
  }

  dimension: item_category3 {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_category3 ;;
    full_suggestions: yes
  }

  dimension: item_category4 {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_category4 ;;
    full_suggestions: yes
  }

  dimension: item_category5 {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_category5 ;;
    full_suggestions: yes
  }

  dimension: item_id {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_id ;;
    full_suggestions: yes
  }

  dimension: item_list_id {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_list_id ;;
    full_suggestions: yes
  }

  dimension: item_list_index {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_list_index ;;
    full_suggestions: yes
  }

  dimension: item_list_name {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_list_name ;;
    full_suggestions: yes
  }

  dimension: item_name {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_name ;;
    full_suggestions: yes
  }

  dimension: item_refund {
    group_label: "Items"
    type: number
    sql: ${TABLE}.item_refund ;;
    full_suggestions: yes
  }

  dimension: item_refund_in_usd {
    group_label: "Items"
    type: number
    sql: ${TABLE}.item_refund_in_usd ;;
    full_suggestions: yes
  }

  dimension: item_revenue {
    group_label: "Items"
    type: number
    sql: ${TABLE}.item_revenue ;;
    full_suggestions: yes
  }

  dimension: item_revenue_in_usd {
    group_label: "Items"
    type: number
    sql: ${TABLE}.item_revenue_in_usd ;;
    full_suggestions: yes
  }

  dimension: item_variant {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_variant ;;
    full_suggestions: yes
  }

  dimension: location_id {
    group_label: "Items"
    type: string
    sql: ${TABLE}.location_id ;;
    full_suggestions: yes
  }

  dimension: price {
    group_label: "Items"
    type: number
    sql: ${TABLE}.price ;;
    full_suggestions: yes
  }

  dimension: price_in_usd {
    group_label: "Items"
    type: number
    sql: ${TABLE}.price_in_usd ;;
    full_suggestions: yes
  }

  dimension: promotion_id {
    group_label: "Items"
    type: string
    sql: ${TABLE}.promotion_id ;;
    full_suggestions: yes
  }

  dimension: promotion_name {
    group_label: "Items"
    type: string
    sql: ${TABLE}.promotion_name ;;
    full_suggestions: yes
  }

  dimension: quantity {
    group_label: "Items"
    type: number
    sql: ${TABLE}.quantity ;;
    full_suggestions: yes
  }
}
