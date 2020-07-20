view: property_provisioning_plans {
  sql_table_name: `happyco-internal-systems.hub__reporting.property_provisioning_plans`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: active_integrations {
    type: string
    sql: ${TABLE}.active_integrations ;;
  }

  dimension: billed_on {
    type: string
    sql: ${TABLE}.billed_on ;;
  }

  dimension: billed_to {
    type: string
    sql: ${TABLE}.billed_to ;;
  }

  dimension: billing_email {
    type: string
    sql: ${TABLE}.billing_email ;;
  }

  dimension: billing_frequency_in_months {
    type: number
    sql: ${TABLE}.billing_frequency_in_months ;;
  }

  dimension: billing_notes {
    type: string
    sql: ${TABLE}.billing_notes ;;
  }

  dimension_group: billing_start {
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
    sql: ${TABLE}.billing_start_on ;;
  }

  dimension: billing_transaction_length_in_months {
    type: number
    sql: ${TABLE}.billing_transaction_length_in_months ;;
  }

  dimension: can_activate_properties {
    type: yesno
    sql: ${TABLE}.can_activate_properties ;;
  }

  dimension: can_deactivate_properties {
    type: yesno
    sql: ${TABLE}.can_deactivate_properties ;;
  }

  dimension: customer_contract_id {
    type: number
    sql: ${TABLE}.customer_contract_id ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: effective {
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
    sql: ${TABLE}.effective_on ;;
  }

  dimension_group: effective_until {
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
    sql: ${TABLE}.effective_until ;;
  }

  dimension_group: launch_period_ends {
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
    sql: ${TABLE}.launch_period_ends_on ;;
  }

  dimension_group: launch_period_starts {
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
    sql: ${TABLE}.launch_period_starts_on ;;
  }

  dimension: manage_folder_dashboard_ids {
    type: string
    sql: ${TABLE}.manage_folder_dashboard_ids ;;
  }

  dimension: merge_recurring_products {
    type: yesno
    sql: ${TABLE}.merge_recurring_products ;;
  }

  dimension: merged_recurring_product_id {
    type: number
    sql: ${TABLE}.merged_recurring_product_id ;;
  }

  dimension: minimum_deactivation_notice_days {
    type: number
    sql: ${TABLE}.minimum_deactivation_notice_days ;;
  }

  dimension: plan_id {
    type: number
    sql: ${TABLE}.plan_id ;;
  }

  dimension: pms_integration_enabled {
    type: yesno
    sql: ${TABLE}.pms_integration_enabled ;;
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
  }

  dimension: property_billing_code_required {
    type: yesno
    sql: ${TABLE}.property_billing_code_required ;;
  }

  dimension: provisioning_notes {
    type: string
    sql: ${TABLE}.provisioning_notes ;;
  }

  dimension: self_provisioning_enabled {
    type: yesno
    sql: ${TABLE}.self_provisioning_enabled ;;
  }

  dimension: setup_fees_billed_on {
    type: string
    sql: ${TABLE}.setup_fees_billed_on ;;
  }

  dimension: setup_fees_cents {
    type: number
    sql: ${TABLE}.setup_fees_cents ;;
  }

  dimension: setup_fees_product_id {
    type: number
    sql: ${TABLE}.setup_fees_product_id ;;
  }

  dimension: so_contract_id {
    type: number
    sql: ${TABLE}.so_contract_id ;;
  }

  dimension: so_customer_id {
    type: number
    sql: ${TABLE}.so_customer_id ;;
  }

  dimension: unit_type {
    type: string
    sql: ${TABLE}.unit_type ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
