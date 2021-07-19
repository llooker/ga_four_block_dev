
## Connection Constants:
constant: GA4_CONNECTION {
  value: "your_connection"
  export: override_required
}

constant: GA4_SCHEMA {
  value: "project.dataset"
  export: override_optional
}

constant: GA4_TABLE_VARIABLE {
  value: "events_*"
  export: override_optional
}
