view: prospect_opportunities_recurring_product_codes {
  derived_table: {
    sql:
            SELECT id, recurring_product_code
            FROM ${prospect_opportunities.SQL_TABLE_NAME}, UNNEST(recurring_product_codes) as recurring_product_code
            WHERE recurring_product_code != ''
          ;;
  }

  view_label: "Opportunities"

  dimension: id {
    type: string
    sql: CAST(${TABLE}.id TO STRING)||${TABLE}.recurring_product_code ;;
    primary_key: yes
    hidden: yes
  }

  dimension: opportunity_id {
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: recurring_product_code {
    type: string
    sql: ${TABLE}.recurring_product_code ;;
  }

  measure: recurring_product_codes {
    type: string
    sql: STRING_AGG(DISTINCT ${recurring_product_code},', ') ;;
  }

}
