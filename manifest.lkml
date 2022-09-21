
## Connection Constants:
constant: GA4_CONNECTION {
  value: "looker-demos"
  export: override_required
}

constant: GA4_SCHEMA {
  value: "adh-demo-data-review.analytics_213025502"
  export: override_optional
}

constant: GA4_TABLE_VARIABLE {
  value: "events_*"
  export: override_optional
}
