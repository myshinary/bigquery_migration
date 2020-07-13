view: sales_levels {
  sql_table_name: `happyco-internal-systems.hub__commissions.sales_levels`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: amount_cents {
    type: number
    sql: ${TABLE}.amount_cents ;;
  }

  dimension: collected_cents {
    type: number
    sql: ${TABLE}.collected_cents ;;
  }

  dimension: commission_due_cents {
    type: number
    sql: ${TABLE}.commission_due_cents ;;
  }

  dimension: commission_earnt_cents {
    type: number
    sql: ${TABLE}.commission_earnt_cents ;;
  }

  dimension: commission_eligible_cents {
    type: number
    sql: ${TABLE}.commission_eligible_cents ;;
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
    sql: CAST(${TABLE}.created_at AS TIMESTAMP) ;;
  }

  dimension: credited_cents {
    type: number
    sql: ${TABLE}.credited_cents ;;
  }

  dimension: high_mark_cents {
    type: number
    sql: ${TABLE}.high_mark_cents ;;
  }

  dimension_group: month {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.month ;;
  }

  dimension: product_group_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_group_id ;;
  }

  dimension: projection {
    type: yesno
    sql: ${TABLE}.projection ;;
  }

  dimension: so_customer_id {
    type: number
    sql: ${TABLE}.so_customer_id ;;
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

  measure: count {
    type: count
    drill_fields: [id, product_groups.name, product_groups.id]
  }
}
