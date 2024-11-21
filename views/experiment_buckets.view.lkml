view: experiment_buckets {

  sql_table_name: pirate_dbt_prod.experiment_buckets ;;

  dimension: sl_key {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.sl_key ;;
  }

  dimension: experiment_1_bucket {
    type: number
    view_label: "Sessions"
    group_label: "Experiment Buckets"
    sql: ${TABLE}.experiment_1_bucket ;;
  }

  dimension: experiment_2_bucket {
    type: number
    view_label: "Sessions"
    group_label: "Experiment Buckets"
    sql: ${TABLE}.experiment_2_bucket ;;
  }

  dimension: experiment_3_bucket {
    type: number
    view_label: "Sessions"
    group_label: "Experiment Buckets"
    sql: ${TABLE}.experiment_3_bucket ;;
  }

}
