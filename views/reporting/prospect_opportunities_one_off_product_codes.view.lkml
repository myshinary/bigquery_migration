view: prospect_opportunities_one_off_product_codes {
  derived_table: {
    sql:
          SELECT id, one_off_product_code
          FROM ${prospect_opportunities.SQL_TABLE_NAME}, UNNEST(one_off_product_codes) as one_off_product_code
          WHERE one_off_product_code != ''
        ;;
  }

  view_label: "Opportunities"

  dimension: id {
    type: string
    sql: CAST(${TABLE}.id TO STRING)||${TABLE}.one_off_product_code ;;
    primary_key: yes
    hidden: yes
  }

  dimension: opportunity_id {
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: one_off_product_code {
    label: "One-Off Product Code"
    type: string
    sql: ${TABLE}.one_off_product_code ;;
  }

  measure: one_off_product_codes {
    label: "One-Off Product Codes"
    type: string
    sql: STRING_AGG(DISTINCT ${one_off_product_code},', ') ;;
  }

}
