view: properties_order_line_items {
  sql_table_name: `happyco-internal-systems.hub__orders.properties_order_line_items`
    ;;
  view_label: "Customer"
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: mrr_dimension {
    type: number
    sql: CASE WHEN ${is_recurring} IS TRUE THEN ${TABLE}.amount_cents/1200  ELSE NULL END;;
    hidden: yes
  }

  dimension: transactional_amount_dimension {
    type: number
    sql: CASE WHEN ${is_recurring} IS FALSE THEN ${TABLE}.amount_cents/100  ELSE NULL END;;
    hidden: yes
  }

  measure: transactional_amount {
    type: sum
    sql: ${transactional_amount_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "Revenue"
  }

  measure: mrr {
    type: sum
    sql: ${mrr_dimension} ;;
    label: "MRR"
    value_format: "$#,##0;($#,##0)"
    group_label: "Revenue"
  }

  dimension: unit_count {
    type: number
    sql: CASE WHEN ${property_provisioning_plans.unit_type} = 'bed' THEN ${apartments.number_of_units} ELSE ${orders.unit_quantity} END;;
    hidden: yes
  }

  dimension:price_per_unit_dimension {
    type: number
    sql: ${mrr_dimension}/${unit_count};;
    hidden: yes
    group_label: "Revenue"
  }

  measure: price_per_unit {
    label: "Product Price per Unit"
    type: average
    sql: ${price_per_unit_dimension} ;;
    value_format: "$0.00;($0.00)"
    group_label: "Revenue"
    description: "Price per Unit split by Product. General rule is to use this any time Product is added to the Look."
    hidden: no
  }

  dimension_group: canceled {
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
    sql: ${TABLE}.canceled_at ;;
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
    sql: CAST(${TABLE}.created_at AS TIMESTAMP) ;;
    hidden: yes
  }

  dimension: is_recurring {
    type: yesno
    sql: ${TABLE}.is_recurring ;;
    #hidden: yes
    group_label: "Revenue"
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.product_code ;;
    hidden: yes
  }

  dimension: product_type {
    type: string
    hidden: yes
    sql:${TABLE}.product_type;;
  }

  dimension: product {
    type: string
    sql:CASE WHEN ${product_type} = 'happy_inspector' THEN 'Inspector' WHEN ${product_type} = 'happy_tasks' THEN 'Tasks' WHEN ${product_type} = 'happy_insights' THEN 'Insights' WHEN ${product_type} = 'property_provisioning_fees' THEN 'Property Provisioning Fees' ELSE REPLACE(${product_type},'_',' ') END;;
  }

  dimension: properties_contract_terms_revision_id {
    type: number
    sql: ${TABLE}.properties_contract_terms_revision_id ;;
    hidden: yes
  }

  dimension: properties_order_id {
    type: number
    sql: ${TABLE}.properties_order_id ;;
    hidden: yes
  }

  dimension: properties_plan_id {
    type: number
    sql: ${TABLE}.properties_plan_id ;;
    hidden: yes
  }

  dimension: requested_by_id {
    type: number
    sql: ${TABLE}.requested_by_id ;;
    hidden: yes
  }

  dimension: requested_by_type {
    type: string
    sql: ${TABLE}.requested_by_type ;;
    hidden: yes
  }

  dimension: saasoptics_product_id {
    type: number
    sql: ${TABLE}.saasoptics_product_id ;;
    hidden: yes
  }

  dimension: so_transaction_id {
    type: number
    sql: ${TABLE}.so_transaction_id ;;
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
  #  drill_fields: [id]
  #}
}
