view: property_provisioning_orders {
  view_label: "HUB"
  sql_table_name: `happyco-internal-systems.hub__reporting.property_provisioning_orders`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension_group: activation {
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
    sql: ${TABLE}.activation_date ;;
    hidden: yes
  }

  dimension: active_recurring_product_names {
    type: string
    sql: ${TABLE}.active_recurring_product_names ;;
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

  dimension_group: deactivation {
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
    sql: ${TABLE}.deactivation_date ;;
    hidden: yes
  }

  dimension: folder_id {
    type: number
    sql: ${TABLE}.folder_id ;;
    hidden: yes
  }

  dimension: is_deprovisioned {
    type: yesno
    sql: ${TABLE}.is_deprovisioned ;;
    hidden: yes
  }

  dimension: is_provisioned {
    type: yesno
    sql: ${TABLE}.is_provisioned ;;
    hidden: yes
  }

  dimension_group: likely_first_invoice {
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
    sql: ${TABLE}.likely_first_invoice_date ;;
    hidden: yes
  }

  dimension: mrr_dimension {
    type: string
    sql: ${TABLE}.mrr_cents/100 ;;
    hidden: yes
  }

  dimension: one_off_amount_cents {
    type: number
    sql: ${TABLE}.one_off_amount_cents ;;
    hidden: yes
  }

  dimension: plan_id {
    type: number
    sql: ${TABLE}.plan_id ;;
    hidden: yes
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension: property_address {
    type: string
    sql: ${TABLE}.property_address ;;
    hidden: yes
  }

  dimension: property_name {
    type: string
    sql: ${TABLE}.property_name ;;
    hidden: yes
  }

  dimension: real_property_id {
    type: number
    sql: ${TABLE}.real_property_id ;;
    hidden: yes
  }

  dimension: unit_quantity {
    type: number
    sql: ${TABLE}.unit_quantity ;;
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
    hidden: yes
  }

  measure: cmrr {
    label: "CMRR"
    type: sum
    sql:  ${mrr_dimension};;
    group_label: "Finances"
    value_format: "$#,##0;($#,##0)"
    drill_fields: [customer.name,property_name,activation_date,likely_first_invoice_date,cmrr]
  }

  measure: un_billed_cmrr {
    label: "Un-Billed CMRR"
    type: sum
    sql:  CASE WHEN ${likely_first_invoice_date} >= current_date AND ${is_provisioned} IS FALSE AND ${is_deprovisioned} IS FALSE THEN ${mrr_dimension} ELSE 0 END;;
    group_label: "Finances"
    value_format: "$#,##0;($#,##0)"
    drill_fields: [customer.name,property_name,activation_date,likely_first_invoice_date,cmrr]
  }

  measure: un_billed_launched_cmrr {
    label: "Un-Billed CMRR for Activated Properties"
    type: sum
    sql:  CASE WHEN ${likely_first_invoice_date} >= current_date AND ${is_provisioned} IS TRUE AND ${is_deprovisioned} IS FALSE THEN ${mrr_dimension} ELSE 0 END;;
    group_label: "Finances"
    value_format: "$#,##0;($#,##0)"
    drill_fields: [customer.name,property_name,activation_date,likely_first_invoice_date,cmrr]
  }

  #measure: count {
  #  type: count
  #  drill_fields: [id, property_name]
  #}
}
