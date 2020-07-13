view: transactions {
  sql_table_name: `happyco-internal-systems.hub__saas_optics.transactions`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: always_use_amount_as_normalized_amount {
    type: yesno
    sql: ${TABLE}.always_use_amount_as_normalized_amount ;;
  }

  dimension: amount_cents {
    type: number
    sql: ${TABLE}.amount_cents ;;
  }

  dimension: arr_amount_cents {
    type: number
    sql: ${TABLE}.arr_amount_cents ;;
  }

  dimension: billing_method_id {
    type: number
    sql: ${TABLE}.billing_method_id ;;
  }

  dimension: canceled {
    type: yesno
    sql: ${TABLE}.canceled ;;
  }

  dimension: contract_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.contract_id ;;
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

  dimension: different_invoice_item_permitted {
    type: yesno
    sql: ${TABLE}.different_invoice_item_permitted ;;
  }

  dimension: duration {
    type: string
    sql: ${TABLE}.duration ;;
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

  dimension: foreign_exchange_rate_cents {
    type: number
    sql: ${TABLE}.foreign_exchange_rate_cents ;;
  }

  dimension: item_id {
    type: number
    sql: ${TABLE}.item_id ;;
  }

  dimension: json {
    type: string
    sql: ${TABLE}.json ;;
  }

  dimension: local_amount_cents {
    type: number
    sql: ${TABLE}.local_amount_cents ;;
  }

  dimension: local_arr_amount_cents {
    type: number
    sql: ${TABLE}.local_arr_amount_cents ;;
  }

  dimension: local_currency {
    type: string
    sql: ${TABLE}.local_currency ;;
  }

  dimension: local_normalized_amount_cents {
    type: number
    sql: ${TABLE}.local_normalized_amount_cents ;;
  }

  dimension: normalized_amount_cents {
    type: number
    sql: ${TABLE}.normalized_amount_cents ;;
  }

  dimension: number {
    type: string
    sql: ${TABLE}.number ;;
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

  dimension: override {
    type: yesno
    sql: ${TABLE}.override ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: revision {
    type: number
    sql: ${TABLE}.revision ;;
  }

  dimension: sfdc_opportunity_id {
    type: string
    sql: ${TABLE}.sfdc_opportunity_id ;;
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

  dimension_group: synced {
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
    sql: CAST(${TABLE}.synced_at AS TIMESTAMP) ;;
  }

  dimension: term_number {
    type: number
    sql: ${TABLE}.term_number ;;
  }

  dimension: unbalanced_revenue_exception {
    type: yesno
    sql: ${TABLE}.unbalanced_revenue_exception ;;
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
    drill_fields: [id, contracts.id, invoice_items.count]
  }
}
