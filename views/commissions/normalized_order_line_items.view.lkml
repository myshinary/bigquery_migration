view: normalized_order_line_items {
  sql_table_name: `happyco-internal-systems.hub__commissions.normalized_order_line_items`
    ;;
  #drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: amount_cents {
    type: number
    sql: ${TABLE}.amount_cents ;;
  }

  dimension: billing_currency {
    type: string
    sql: ${TABLE}.billing_currency ;;
  }

  dimension: canceled {
    type: yesno
    sql: ${TABLE}.canceled ;;
  }

  dimension: collected_balance_cents {
    type: number
    sql: ${TABLE}.collected_balance_cents ;;
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

  dimension: credited_amount_cents {
    type: number
    sql: ${TABLE}.credited_amount_cents ;;
  }

  dimension: credited_local_amount_cents {
    type: number
    sql: ${TABLE}.credited_local_amount_cents ;;
  }

  dimension_group: ended {
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
    sql: ${TABLE}.ended_on ;;
  }

  dimension: future_commission_amount_cents {
    type: number
    sql: ${TABLE}.future_commission_amount_cents ;;
  }

  dimension: invoiced_amount_cents {
    type: number
    sql: ${TABLE}.invoiced_amount_cents ;;
  }

  dimension: invoiced_local_amount_cents {
    type: number
    sql: ${TABLE}.invoiced_local_amount_cents ;;
  }

  dimension: local_amount_cents {
    type: number
    sql: ${TABLE}.local_amount_cents ;;
  }

  dimension: monthly_normalized_amount_cents {
    type: number
    sql: ${TABLE}.monthly_normalized_amount_cents ;;
  }

  dimension: monthly_normalized_amount_currency {
    type: string
    sql: ${TABLE}.monthly_normalized_amount_currency ;;
  }

  dimension: months {
    type: number
    sql: ${TABLE}.months ;;
  }

  dimension_group: ordered {
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
    sql: ${TABLE}.ordered_on ;;
  }

  dimension_group: original_ended {
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
    sql: ${TABLE}.original_ended_on ;;
  }

  dimension_group: original_started {
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
    sql: ${TABLE}.original_started_on ;;
  }

  dimension: paid_amount_cents {
    type: number
    sql: ${TABLE}.paid_amount_cents ;;
  }

  dimension: paid_local_amount_cents {
    type: number
    sql: ${TABLE}.paid_local_amount_cents ;;
  }

  dimension: product_group_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_group_id ;;
  }

  dimension: so_contract_id {
    type: number
    sql: ${TABLE}.so_contract_id ;;
  }

  dimension: so_customer_id {
    type: number
    sql: ${TABLE}.so_customer_id ;;
  }

  dimension: so_transaction_id {
    type: number
    sql: ${TABLE}.so_transaction_id ;;
  }

  dimension_group: started {
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
    sql: ${TABLE}.started_on ;;
  }

  dimension: uninvoiced_amount_cents {
    type: number
    sql: ${TABLE}.uninvoiced_amount_cents ;;
  }

  dimension: uninvoiced_local_amount_cents {
    type: number
    sql: ${TABLE}.uninvoiced_local_amount_cents ;;
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
