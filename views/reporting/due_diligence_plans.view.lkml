view: due_diligence_plans {
  sql_table_name: `happyco-internal-systems.hub__reporting.due_diligence_plans`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: billing_contact {
    type: string
    sql: ${TABLE}.billing_contact ;;
  }

  dimension: billing_email {
    type: string
    sql: ${TABLE}.billing_email ;;
  }

  dimension: billing_profile_revision {
    type: number
    sql: ${TABLE}.billing_profile_revision ;;
  }

  dimension: billing_task_notes {
    type: string
    sql: ${TABLE}.billing_task_notes ;;
  }

  dimension: billing_unit_type {
    type: string
    sql: ${TABLE}.billing_unit_type ;;
  }

  dimension: cancellation_fee_cents {
    type: number
    sql: ${TABLE}.cancellation_fee_cents ;;
  }

  dimension: cancellation_fee_notice_biz_hours {
    type: number
    sql: ${TABLE}.cancellation_fee_notice_biz_hours ;;
  }

  dimension: contract_terms_revision {
    type: number
    sql: ${TABLE}.contract_terms_revision ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: dd_advanced_reports_enabled {
    type: yesno
    sql: ${TABLE}.dd_advanced_reports_enabled ;;
  }

  dimension: dd_advanced_reports_price_cents {
    type: number
    sql: ${TABLE}.dd_advanced_reports_price_cents ;;
  }

  dimension: dd_enabled {
    type: yesno
    sql: ${TABLE}.dd_enabled ;;
  }

  dimension: dd_lfa_only_enabled {
    type: yesno
    sql: ${TABLE}.dd_lfa_only_enabled ;;
  }

  dimension: dd_lfa_only_price_cents {
    type: number
    sql: ${TABLE}.dd_lfa_only_price_cents ;;
  }

  dimension: dd_price_cents {
    type: number
    sql: ${TABLE}.dd_price_cents ;;
  }

  dimension: dd_walk_only_enabled {
    type: yesno
    sql: ${TABLE}.dd_walk_only_enabled ;;
  }

  dimension: dd_walk_only_price_cents {
    type: number
    sql: ${TABLE}.dd_walk_only_price_cents ;;
  }

  dimension: designed_reports_enabled {
    type: yesno
    sql: ${TABLE}.designed_reports_enabled ;;
  }

  dimension: designed_reports_fixed_price_cents {
    type: number
    sql: ${TABLE}.designed_reports_fixed_price_cents ;;
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
    sql: ${TABLE}.effective_at ;;
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

  dimension: invoicable_on {
    type: string
    sql: ${TABLE}.invoicable_on ;;
  }

  dimension: is_plan_canceled {
    type: yesno
    sql: ${TABLE}.is_plan_canceled ;;
  }

  dimension: lfa_template_id {
    type: number
    sql: ${TABLE}.lfa_template_id ;;
  }

  dimension: live_inspection_price_cents {
    type: number
    sql: ${TABLE}.live_inspection_price_cents ;;
  }

  dimension: live_inspection_usage_rate_cents {
    type: number
    sql: ${TABLE}.live_inspection_usage_rate_cents ;;
  }

  dimension: live_inspections_included_in_base {
    type: number
    sql: ${TABLE}.live_inspections_included_in_base ;;
  }

  dimension: manage_folder_dashboard_ids {
    type: string
    sql: ${TABLE}.manage_folder_dashboard_ids ;;
  }

  dimension: max_total_dd_price_cents {
    type: number
    sql: ${TABLE}.max_total_dd_price_cents ;;
  }

  dimension: min_total_dd_price_cents {
    type: number
    sql: ${TABLE}.min_total_dd_price_cents ;;
  }

  dimension: oneoff {
    type: yesno
    sql: ${TABLE}.oneoff ;;
  }

  dimension: overage_billing_unit_type {
    type: string
    sql: ${TABLE}.overage_billing_unit_type ;;
  }

  dimension: overage_dd_price_cents {
    type: number
    sql: ${TABLE}.overage_dd_price_cents ;;
  }

  dimension: overage_reset_period_months {
    type: number
    sql: ${TABLE}.overage_reset_period_months ;;
  }

  dimension: payable_on {
    type: string
    sql: ${TABLE}.payable_on ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: plan_id {
    type: number
    sql: ${TABLE}.plan_id ;;
  }

  dimension: plan_revision {
    type: number
    sql: ${TABLE}.plan_revision ;;
  }

  dimension: plan_subtype {
    type: string
    sql: ${TABLE}.plan_subtype ;;
  }

  dimension: plan_type {
    type: string
    sql: ${TABLE}.plan_type ;;
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
  }

  dimension: resident_inspections_enabled {
    type: yesno
    sql: ${TABLE}.resident_inspections_enabled ;;
  }

  dimension: rush_fee_fixed_price_cents {
    type: number
    sql: ${TABLE}.rush_fee_fixed_price_cents ;;
  }

  dimension: rush_fee_notice_biz_hours {
    type: number
    sql: ${TABLE}.rush_fee_notice_biz_hours ;;
  }

  dimension: setup_profile_revision {
    type: number
    sql: ${TABLE}.setup_profile_revision ;;
  }

  dimension: setup_task_notes {
    type: string
    sql: ${TABLE}.setup_task_notes ;;
  }

  dimension: so_account_id {
    type: number
    sql: ${TABLE}.so_account_id ;;
  }

  dimension: so_contract_id {
    type: number
    sql: ${TABLE}.so_contract_id ;;
  }

  dimension: subscription_max_quantity {
    type: number
    sql: ${TABLE}.subscription_max_quantity ;;
  }

  dimension: video_inspections_enabled {
    type: yesno
    sql: ${TABLE}.video_inspections_enabled ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
