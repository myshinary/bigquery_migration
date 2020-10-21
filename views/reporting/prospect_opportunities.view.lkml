view: prospect_opportunities {
  sql_table_name: `happyco-internal-systems.hub__reporting.prospect_opportunities`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: billable_from_provisioning {
    type: yesno
    sql: ${TABLE}.billable_from_provisioning ;;
  }

  dimension: cmrr_cents {
    type: number
    sql: ${TABLE}.cmrr_cents ;;
  }

  dimension: contract_dates {
    type: string
    sql: ${TABLE}.contract_dates ;;
  }

  dimension_group: contract_issue {
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
    sql: ${TABLE}.contract_issue_date ;;
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
  }

  dimension: has_custom_launch_product {
    type: yesno
    sql: ${TABLE}.has_custom_launch_product ;;
  }

  dimension: hub_customer_id {
    type: number
    sql: ${TABLE}.hub_customer_id ;;
  }

  dimension: integrations {
    type: string
    sql: ${TABLE}.integrations ;;
  }

  dimension: is_custom_contract {
    type: yesno
    sql: ${TABLE}.is_custom_contract ;;
  }

  dimension: market_data_company_id {
    type: number
    sql: ${TABLE}.market_data_company_id ;;
  }

  dimension: meets_contract_generation_criteria {
    type: yesno
    sql: ${TABLE}.meets_contract_generation_criteria ;;
  }

  dimension: one_off_amount_cents {
    type: number
    sql: ${TABLE}.one_off_amount_cents ;;
  }

  dimension: one_off_product_codes {
    type: string
    sql: ${TABLE}.one_off_product_codes ;;
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }

  dimension: owners {
    type: string
    sql: ${TABLE}.owners ;;
  }

  dimension: percent_tier1_units_in_bps {
    type: number
    sql: ${TABLE}.percent_tier1_units_in_bps ;;
  }

  dimension: primary_industry {
    type: string
    sql: ${TABLE}.primary_industry ;;
  }

  dimension: reasons_for_buying {
    type: string
    sql: ${TABLE}.reasons_for_buying ;;
  }

  dimension: recurring_product_codes {
    type: string
    sql: ${TABLE}.recurring_product_codes ;;
  }

  dimension: renewal_term_in_months {
    type: number
    sql: ${TABLE}.renewal_term_in_months ;;
  }

  dimension: sow_details_present {
    type: yesno
    sql: ${TABLE}.sow_details_present ;;
  }

  dimension: stage_name {
    type: string
    sql: ${TABLE}.stage_name ;;
  }

  dimension_group: target_mrr {
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
    sql: ${TABLE}.target_mrr_date ;;
  }

  dimension: tier {
    type: string
    sql: ${TABLE}.tier ;;
  }

  dimension: total_properties {
    type: number
    sql: ${TABLE}.total_properties ;;
  }

  dimension: total_units {
    type: number
    sql: ${TABLE}.total_units ;;
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
  }

  measure: count {
    type: count
    drill_fields: [id, opportunity_name, stage_name, account_name]
  }
}
