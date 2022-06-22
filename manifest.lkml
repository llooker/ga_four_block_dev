
## Connection Constants:
constant: GA4_CONNECTION {
  value: "4mile_bigquery_davidb"
  export: override_required
}

constant: GA4_SCHEMA {
  value: "bigquery-public-data.ga4_obfuscated_sample_ecommerce`"
  export: override_optional
}

constant: GA4_TABLE_VARIABLE {
  value: "events_*"
  export: override_optional
}
