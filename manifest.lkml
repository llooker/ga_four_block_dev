
## Connection Constants:
constant: GA4_CONNECTION {
  value: "data_warehouse_bq"
  export: override_required
}

constant: GA4_SCHEMA {
  value: "hardy-force-319814.analytics_250111504"
  export: override_optional
}

constant: GA4_TABLE_VARIABLE {
  value: "events_*"
  export: override_optional
}
