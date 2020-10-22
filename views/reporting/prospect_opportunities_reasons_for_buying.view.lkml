view: prospect_opportunities_reasons_for_buying {
  derived_table: {
    sql:
          SELECT id, reason_for_buying
          FROM ${prospect_opportunities.SQL_TABLE_NAME}, UNNEST(reasons_for_buying) as reason_for_buying
          WHERE reason_for_buying != ''
        ;;
  }

  view_label: "Opportunities"

  dimension: id {
    type: string
    sql: CAST(${TABLE}.id TO STRING)||${TABLE}.reason_for_buying ;;
    primary_key: yes
    hidden: yes
  }

  dimension: opportunity_id {
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: reason_for_buying {
    type: string
    sql: ${TABLE}.reason_for_buying ;;
  }

  measure: reasons_for_buying {
    type: string
    sql: STRING_AGG(DISTINCT ${reason_for_buying},', ') ;;
  }

}
