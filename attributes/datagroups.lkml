# datagroup: bqml_datagroup {
#   #retrain model every week
#   sql_trigger: SELECT EXTRACT(week from CURRENT_DATE()) ;;
# }
