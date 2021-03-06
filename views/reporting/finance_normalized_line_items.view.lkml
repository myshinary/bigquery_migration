view: finance_normalized_line_items {
  sql_table_name: `happyco-internal-systems.hub__reporting.finance_normalized_line_items`
    ;;
    view_label: "HUB"
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: amount_cents {
    type: number
    sql: ${TABLE}.amount_cents ;;
    hidden: yes
  }

  measure: lifetime_value {
    type: sum
    sql: ${amount_cents}/100;;
    group_label: "Finances"
    value_format: "$#,##0;($#,##0)"
  }

  dimension: billing_currency {
    type: string
    sql: ${TABLE}.billing_currency ;;
    hidden: yes
  }

  dimension: collected_balance_cents {
    type: number
    sql: ${TABLE}.collected_balance_cents ;;
    hidden: yes
  }

  dimension: credited_amount_cents {
    type: number
    sql: ${TABLE}.credited_amount_cents ;;
    hidden: yes
  }

  dimension: credited_local_amount_cents {
    type: number
    sql: ${TABLE}.credited_local_amount_cents ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: hub_customer_id {
    type: number
    sql: ${TABLE}.hub_customer_id ;;
    hidden: yes
  }

  dimension: hub_customer_legal_name {
    type: string
    sql: ${TABLE}.hub_customer_legal_name ;;
    hidden: yes
  }

  dimension: hub_customer_name {
    type: string
    sql: ${TABLE}.hub_customer_name ;;
    hidden: yes
  }

  dimension: invoiced_amount_cents {
    type: number
    sql: ${TABLE}.invoiced_amount_cents ;;
    hidden: yes
  }

  dimension: invoiced_local_amount_cents {
    type: number
    sql: ${TABLE}.invoiced_local_amount_cents ;;
    hidden: yes
  }

  dimension: is_product_group_recurring {
    type: yesno
    sql: ${TABLE}.is_product_group_recurring ;;
    hidden: yes
  }

  dimension: is_so_item_active {
    type: yesno
    sql: ${TABLE}.is_so_item_active ;;
    hidden: yes
  }

  dimension: is_so_item_recurring {
    type: yesno
    sql: ${TABLE}.is_so_item_recurring ;;
    hidden: yes
  }

  dimension: is_so_transaction_canceled {
    type: yesno
    sql: ${TABLE}.is_so_transaction_canceled ;;
    hidden: yes
  }

  dimension: local_amount_cents {
    type: number
    sql: ${TABLE}.local_amount_cents ;;
    hidden: yes
  }

  dimension: monthly_normalized_amount_cents {
    type: number
    sql: ${TABLE}.monthly_normalized_amount_cents ;;
    hidden: yes
  }

  dimension: mrr_dimension {
    type: number
    sql: CASE WHEN ${is_so_item_recurring} THEN ${monthly_normalized_amount_cents}/100 ELSE NULL END;;
    hidden: yes
  }

  measure: mrr {
    type: sum
    sql: ${mrr_dimension} ;;
    label: "MRR"
    value_format: "$#,##0;($#,##0)"
    hidden:yes
  }

  dimension: current_mrr_dimension {
    type: number
    sql: CASE WHEN (current_date >= ${finance_normalized_line_items.original_started_date} AND current_date <=  ${finance_normalized_line_items.original_ended_date}) THEN ${mrr_dimension} ELSE NULL END ;;
    hidden: yes
  }

  measure: current_mrr {
    type: sum
    sql: ${current_mrr_dimension} ;;
    label: "Current MRR"
    group_label: "Finances"
    value_format: "$#,##0;($#,##0)"
    hidden: no
  }

  dimension: months {
    type: number
    sql: ${TABLE}.months ;;
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
  }

  measure: customer_started {
    type: min
    sql: ${original_started_date} ;;
    hidden: yes
  }

  measure: customer_since {
    type: string
    sql: FORMAT_DATE("%B %d, %Y", ${customer_started}) ;;
    hidden: no
  }

  measure: customer_age_in_months {
    type: number
    sql: DATE_DIFF(current_date,${customer_started},MONTH) ;;
  }

  dimension: paid_amount_cents {
    type: number
    sql: ${TABLE}.paid_amount_cents ;;
    hidden: yes
  }

  dimension: paid_local_amount_cents {
    type: number
    sql: ${TABLE}.paid_local_amount_cents ;;
    hidden: yes
  }

  dimension: product_group_id {
    type: number
    sql: ${TABLE}.product_group_id ;;
    hidden: yes
  }

  dimension: product_group_name {
    label: "Product"
    type: string
    sql: ${TABLE}.product_group_name ;;
    hidden: no
  }

  measure: product_list {
    label: "Recurring Products"
    type: string
    sql: STRING_AGG(DISTINCT (CASE WHEN ${is_product_group_recurring} THEN ${product_group_name} ELSE NULL END),', ') ;;
    group_label: "Finances"
  }

  dimension: root_so_customer_id {
    type: number
    sql: ${TABLE}.root_so_customer_id ;;
    hidden: yes
  }

  dimension: salesforce_id {
    type: string
    sql: ${TABLE}.salesforce_id ;;
    hidden: yes
  }

  dimension: so_contract_id {
    type: number
    sql: ${TABLE}.so_contract_id ;;
    hidden: yes
  }

  dimension: so_customer_id {
    type: number
    sql: ${TABLE}.so_customer_id ;;
    hidden: yes
  }

  dimension: so_item_code {
    type: string
    sql: ${TABLE}.so_item_code ;;
    hidden: yes
  }

  dimension: so_item_id {
    type: number
    sql: ${TABLE}.so_item_id ;;
    hidden: yes
  }

  dimension: so_item_name {
    type: string
    sql: ${TABLE}.so_item_name ;;
    hidden: yes
  }

  dimension: so_transaction_id {
    type: number
    sql: ${TABLE}.so_transaction_id ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: uninvoiced_amount_cents {
    type: number
    sql: ${TABLE}.uninvoiced_amount_cents ;;
    hidden: yes
  }

  dimension: uninvoiced_local_amount_cents {
    type: number
    sql: ${TABLE}.uninvoiced_local_amount_cents ;;
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
    sql: CAST(${TABLE}.updated_at AS TIMESTAMP) ;;
    hidden: yes
  }

  #measure: count {
  #  type: count
  #  drill_fields: [id, so_item_name, product_group_name, hub_customer_legal_name, hub_customer_name]
  #}
}
