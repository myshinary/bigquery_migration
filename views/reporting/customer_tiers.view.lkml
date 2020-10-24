view: customer_tiers {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_tiers`
    ;;
  view_label: "Customer"
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: root_customer_id {
    type: number
    sql: ${TABLE}.root_customer_id ;;
    hidden: yes
  }

  dimension: tier {
    type: string
    sql: ${TABLE}.tier ;;
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
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id]
    hidden: yes
  }
}
