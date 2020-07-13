view: sales_order_line_items {
  sql_table_name: `happyco-internal-systems.hub__property_provisioning.sales_order_line_items`
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

  dimension: annual_rate_cents {
    type: number
    sql: ${TABLE}.annual_rate_cents ;;
  }

  dimension: billing_frequency_in_months {
    type: number
    sql: ${TABLE}.billing_frequency_in_months ;;
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

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.end_date ;;
  }

  dimension: monthly_rate_cents {
    type: number
    sql: ${TABLE}.monthly_rate_cents ;;
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.product_code ;;
  }

  dimension: product_environment_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_environment_id ;;
  }

  dimension: properties_order_item_ids {
    type: number
    value_format_name: id
    sql: ${TABLE}.properties_order_item_ids ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: saasoptics_id {
    type: number
    sql: ${TABLE}.saasoptics_id ;;
  }

  dimension: sales_order_id {
    type: number
    sql: ${TABLE}.sales_order_id ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_date ;;
  }

  dimension: transaction_rate_cents {
    type: number
    sql: ${TABLE}.transaction_rate_cents ;;
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

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  measure: count {
    type: count
    drill_fields: [id, product_environments.name, product_environments.id]
  }
}
