view: so_transaction_paid {
  sql_table_name: `happyco-internal-systems.bi.so_transaction_paid`
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

  dimension: credited_amount_cents {
    type: number
    sql: ${TABLE}.credited_amount_cents ;;
  }

  dimension: months {
    type: number
    sql: ${TABLE}.months ;;
  }

  dimension: paid {
    type: yesno
    sql: ${TABLE}.paid ;;
  }

  dimension: paid_amount_cents {
    type: number
    sql: ${TABLE}.paid_amount_cents ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
  }

  dimension: product_group_id {
    type: number
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

  measure: count {
    type: count
    drill_fields: [id]
  }
}
