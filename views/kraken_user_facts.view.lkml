view: kraken_user_facts {

derived_table: {
  sql:
  SELECT
  ga.sl_key,
  ga.user_id,
  true as is_single_user_session,
  u.count_bookings_paid,
  u.first_booking_paid_product,
  u.first_booking_paid_location,
  u.revenue_percentile,
  u.total_revenue
  FROM pirate_dbt_prod.ga_user_id ga
  LEFT JOIN pirate_dbt_prod.user_facts u on u.user_id = ga.user_id
  ;;
}

dimension: sl_key {
  hidden: yes
  primary_key: yes
  sql: ${TABLE}.sl_key ;;
}

dimension: session_user_id {
  type: number
  sql: ${TABLE}.user_id ;;
}

dimension: is_single_user_session {
  type: yesno
  sql: ${TABLE}.is_single_user_session  ;;
  description: "did the GA session have only one kraken user? (if no they will not have kraken data)"
}

dimension: count_bookings_paid {
  type: number
  sql: ${TABLE}.count_bookings_paid ;;
  description: "the total number of bookings paid the user has made"
}

dimension: first_booking_paid_product {
  type: string
  sql: ${TABLE}.first_booking_paid_product ;;
  description: "the product associated with the user's first booking paid"
}

dimension: first_booking_paid_location {
  type: string
  sql: ${TABLE}.first_booking_paid_location ;;
  description: "the location associated with the user's first booking paid"
}

dimension: revenue_percentile {
  type: number
  sql: ${TABLE}.revenue_percentile ;;
  description: "the percentile into which the user falls based on total booking revenue"
}

dimension: total_revenue {
  type: number
  sql: ${TABLE}.total_revenue ;;
  description: "the total revenue associated with the user"
}

}
