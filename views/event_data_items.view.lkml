view: event_data_items {

## Dimensions
  dimension: affiliation {
    group_label: "Items"
    type: string
    sql: ${TABLE}.affiliation ;;
  }

  dimension: coupon {
    group_label: "Items"
    type: string
    sql: ${TABLE}.coupon ;;
  }

  dimension: creative_name {
    group_label: "Items"
    type: string
    sql: ${TABLE}.creative_name ;;
  }

  dimension: creative_slot {
    group_label: "Items"
    type: string
    sql: ${TABLE}.creative_slot ;;
  }

  dimension: item_brand {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_brand ;;
  }

  dimension: item_category {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_category ;;
  }

  dimension: item_category2 {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_category2 ;;
  }

  dimension: item_category3 {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_category3 ;;
  }

  dimension: item_category4 {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_category4 ;;
  }

  dimension: item_category5 {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_category5 ;;
  }

  dimension: item_id {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_id ;;
  }

  dimension: item_list_id {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_list_id ;;
  }

  dimension: item_list_index {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_list_index ;;
  }

  dimension: item_list_name {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_list_name ;;
  }

  dimension: item_name {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: item_refund {
    group_label: "Items"
    type: number
    sql: ${TABLE}.item_refund ;;
  }

  dimension: item_refund_in_usd {
    group_label: "Items"
    type: number
    sql: ${TABLE}.item_refund_in_usd ;;
  }

  dimension: item_revenue {
    group_label: "Items"
    type: number
    sql: ${TABLE}.item_revenue ;;
  }

  dimension: item_revenue_in_usd {
    group_label: "Items"
    type: number
    sql: ${TABLE}.item_revenue_in_usd ;;
  }

  dimension: item_variant {
    group_label: "Items"
    type: string
    sql: ${TABLE}.item_variant ;;
  }

  dimension: location_id {
    group_label: "Items"
    type: string
    sql: ${TABLE}.location_id ;;
  }

  dimension: price {
    group_label: "Items"
    type: number
    sql: ${TABLE}.price ;;
  }

  dimension: price_in_usd {
    group_label: "Items"
    type: number
    sql: ${TABLE}.price_in_usd ;;
  }

  dimension: promotion_id {
    group_label: "Items"
    type: string
    sql: ${TABLE}.promotion_id ;;
  }

  dimension: promotion_name {
    group_label: "Items"
    type: string
    sql: ${TABLE}.promotion_name ;;
  }

  dimension: quantity {
    group_label: "Items"
    type: number
    sql: ${TABLE}.quantity ;;
  }
}
