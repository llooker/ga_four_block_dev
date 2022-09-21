view: user_segment_filters {
  extension: required
  filter: user_segment_timeframe {
    type: date
  }
  filter: user_segment_landing_page {
    type: string
    suggest_explore: sessions
    suggest_dimension: sessions.landing_page
  }
}

view: user_segment {
    derived_table: {
      #https://gafourblock.cloud.looker.com/explore/ga4/sessions?qid=TNJNii9UxKynCJltMZZ0iv&toggle=fil

      explore_source: sessions {
        column: user_pseudo_id {}
        column: total_sessions {}
        column: total_purchase_revenue { field: events.total_purchase_revenue }
        column: total_transactions { field: events.total_transactions }
        bind_filters: {
          from_field: user_segment.user_segment_timeframe
          to_field: sessions.session_date   #bind filters to filter the table when the view is created
        }
        bind_filters: {
          from_field: user_segment.user_segment_landing_page
          to_field: sessions.landing_page
        }

      }
    }

    extends: [user_segment_filters]

    dimension: user_pseudo_id {hidden:yes primary_key:yes}
    dimension: total_sessions {
      hidden: yes
      label: "Sessions Sessions"
      description: "Total Number of Sessions (Count)"
      #value_format: "[<1000]0;[<1000000]0.0,"K";0.0,,"M""
      type: number
      }
    dimension: total_purchase_revenue {
      hidden: yes
      label: "Events Purchase Revenue"
      value_format: "$#,##0.00"
      type: number
    }
    dimension: total_transactions {
      hidden: yes
      label: "Events Transactions"
      type: number
    }


  measure: segment_users {
    group_label: "In Selected Timeframe"
    type: count_distinct
    allow_approximate_optimization: yes
    sql: ${user_pseudo_id} ;;
  }

  measure: retention_rate {
    type: number
    sql: ${segment_users}/NULLIF(${sessions.total_users},0) ;;
    value_format_name: percent_1
  }

  measure: segment_sessions {
    group_label: "In Selected Timeframe"
    type: sum
    sql: ${total_sessions} ;;
    value_format_name: decimal_0
  }

  measure: segment_transaction_revenue {
    group_label: "In Selected Timeframe"
    type: sum
    sql: ${total_purchase_revenue} ;;
    value_format_name: usd_0
  }

  measure: segment_transaction_revenue_per_user {
    group_label: "In Selected Timeframe"
    type: number
    sql: ${segment_transaction_revenue}/NULLIF(${segment_users},0) ;;
    value_format_name: usd
  }

  measure: segment_transaction_count {
    group_label: "In Selected Timeframe"
    type: sum
    sql: ${total_transactions} ;;
    value_format_name: decimal_0
  }

  measure: segment_transaction_conversion_rate {
    group_label: "In Selected Timeframe"
    type: number
    sql: ${segment_transaction_count}/NULLIF(${segment_sessions},0) ;;
    value_format_name: percent_1
  }


}
