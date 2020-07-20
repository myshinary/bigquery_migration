view: customer_overall_risk_history {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_overall_risk_history`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_update_id {
    type: number
    sql: ${TABLE}.customer_update_id ;;
  }

  dimension: overall_risk {
    type: number
    sql: ${TABLE}.overall_risk ;;
  }

  dimension: revision {
    type: number
    sql: ${TABLE}.revision ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.updated_at AS TIMESTAMP) ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}.version ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
