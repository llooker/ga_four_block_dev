view: audience_cohorts {
  derived_table: {
    explore_source: sessions {
      column: audience_trait {}
      column: total_sessions {}
      derived_column: rank {
        sql: ROW_NUMBER() OVER() ;;
      }

      bind_all_filters: yes
      sorts: [sessions.total_sessions: desc]
    }
  }

  dimension: audience_trait {
    # Field used to JOIN back to ga_sessions via ga_sessions.audience_traits = audience_cohorts.audience_traits
    hidden: yes
  }

  dimension: rank {
    label: "Audience Trait: Rank by Traffic"
    view_label: "Audience"
    group_label: "Audience Cohorts"
    description: "Dynamic rank for Audience Trait based on web traffic (Sessions). Includes all filters in current query and reranks on each new query."
    type: number
  }
}
