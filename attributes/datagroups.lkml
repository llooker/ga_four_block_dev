datagroup: bqml_datagroup {
  max_cache_age: "6 hour"
  #retrain model every month
  sql_trigger: SELECT EXTRACT(month from CURRENT_DATE()) ;;
}
