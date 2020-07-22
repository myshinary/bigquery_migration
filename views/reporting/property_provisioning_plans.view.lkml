view: property_provisioning_plans {
  sql_table_name: `happyco-internal-systems.hub__reporting.property_provisioning_plans`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: active_integrations {
    type: string
    sql: ${TABLE}.active_integrations ;;
    hidden: yes
  }

  dimension: billed_on {
    type: string
    sql: ${TABLE}.billed_on ;;
    hidden: yes
  }

  dimension: billed_to {
    type: string
    sql: ${TABLE}.billed_to ;;
    hidden: yes
  }

  dimension: billing_email {
    type: string
    sql: ${TABLE}.billing_email ;;
    hidden: yes
  }

  dimension: billing_frequency_in_months {
    type: number
    sql: ${TABLE}.billing_frequency_in_months ;;
    hidden: yes
  }

  dimension: billing_notes {
    type: string
    sql: ${TABLE}.billing_notes ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: billing_transaction_length_in_months {
    type: number
    sql: ${TABLE}.billing_transaction_length_in_months ;;
    hidden: yes
  }

  dimension: can_activate_properties {
    type: yesno
    sql: ${TABLE}.can_activate_properties ;;
    hidden: yes
  }

  dimension: can_deactivate_properties {
    type: yesno
    sql: ${TABLE}.can_deactivate_properties ;;
    hidden: yes
  }

  dimension: customer_contract_id {
    type: number
    sql: ${TABLE}.customer_contract_id ;;
    hidden: yes
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
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
    hidden: yes
  }

  dimension: manage_folder_dashboard_ids {
    type: string
    sql: ${TABLE}.manage_folder_dashboard_ids ;;
    hidden: yes
  }

  dimension: merge_recurring_products {
    type: yesno
    sql: ${TABLE}.merge_recurring_products ;;
    hidden: yes
  }

  dimension: merged_recurring_product_id {
    type: number
    sql: ${TABLE}.merged_recurring_product_id ;;
    hidden: yes
  }

  dimension: minimum_deactivation_notice_days {
    type: number
    sql: ${TABLE}.minimum_deactivation_notice_days ;;
    hidden: yes
  }

  dimension: plan_id {
    type: number
    sql: ${TABLE}.plan_id ;;
    hidden: yes
  }

  dimension: pms_integration_enabled {
    type: yesno
    sql: ${TABLE}.pms_integration_enabled ;;
    hidden: yes
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension: property_billing_code_required {
    type: yesno
    sql: ${TABLE}.property_billing_code_required ;;
    hidden: yes
  }

  dimension: provisioning_notes {
    type: string
    sql: ${TABLE}.provisioning_notes ;;
    hidden: yes
  }

  dimension: self_provisioning_enabled {
    type: yesno
    sql: ${TABLE}.self_provisioning_enabled ;;
    hidden: yes
  }

  dimension: setup_fees_billed_on {
    type: string
    sql: ${TABLE}.setup_fees_billed_on ;;
    hidden: yes
  }

  dimension: setup_fees_cents {
    type: number
    sql: ${TABLE}.setup_fees_cents ;;
    hidden: yes
  }

  dimension: setup_fees_product_id {
    type: number
    sql: ${TABLE}.setup_fees_product_id ;;
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

  dimension: unit_type {
    type: string
    sql: ${TABLE}.unit_type ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id]
    hidden: yes
  }
}
