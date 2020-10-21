view: customer_updates {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_updates`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: details {
    type: string
    sql: ${TABLE}.details ;;
  }

  dimension: overall_risk_bps {
    type: number
    sql: ${TABLE}.overall_risk_bps ;;
  }

  dimension_group: posted {
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
    sql: ${TABLE}.posted_at ;;
  }

  dimension: posted_by_id {
    type: number
    sql: ${TABLE}.posted_by_id ;;
  }

  dimension: posted_by_name {
    type: number
    sql: ${TABLE}.posted_by_name ;;
  }

  dimension: slack_thread_link {
    type: string
    sql: ${TABLE}.slack_thread_link ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
    hidden: yes
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
    sql: ${TABLE}.updated_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, posted_by_name]
  }
}
