connection: "@{GA4_CONNECTION}"

label: "Google Analytics 4"

include: "/dashboards/*.dashboard"
include: "/explores/**/*.explore.lkml"

datagroup: ga4_default_datagroup {
  sql_trigger:  SELECT FLOOR(((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) - 60*60*6)/(60*60*24));;
  max_cache_age: "1 hour"
}

persist_with: ga4_default_datagroup
