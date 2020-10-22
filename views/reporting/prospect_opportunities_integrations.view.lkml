view: prospect_opportunities_integrations {
  derived_table: {
    sql:
          SELECT id, integration
          FROM ${prospect_opportunities.SQL_TABLE_NAME}, UNNEST(integrations) as integration
          WHERE integration != ''
        ;;
  }

  view_label: "Opportunities"

  dimension: id {
    type: string
    sql: CAST(${TABLE}.id TO STRING)||${TABLE}.integration ;;
    primary_key: yes
    hidden: yes
  }

  dimension: opportunity_id {
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: integration {
    type: string
    sql: ${TABLE}.integration ;;
    group_label: "Tier Info"
  }

  measure: integrations {
    type: string
    sql: STRING_AGG(DISTINCT ${integration},', ') ;;
    group_label: "Tier Info"
  }

}
