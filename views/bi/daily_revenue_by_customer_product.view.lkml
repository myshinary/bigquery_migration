view: daily_revenue_by_customer_product {
  sql_table_name: `bi.daily_revenue_by_customer_product`
    ;;

  dimension: amount_dimension {
    type: number
    sql: ${TABLE}.amount ;;
    hidden: yes
  }

  measure: amount {
    type: sum
    sql: ${amount_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    #drill_fields: [amount_drill*]
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      day_of_week,
      day_of_month,
      week,
      week_of_year,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}.parent_id ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
  }

  dimension: transaction_id {
    type: number
    sql: ${TABLE}.transaction_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
