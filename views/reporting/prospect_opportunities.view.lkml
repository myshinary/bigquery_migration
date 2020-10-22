view: prospect_opportunities {
  sql_table_name: `happyco-internal-systems.hub__reporting.prospect_opportunities`
    ;;

  view_label: "Opportunities"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: account_id {
    label: "Salesforce ID"
    type: string
    sql: ${TABLE}.account_id ;;
    group_label: "Salesforce"
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: billable_from_provisioning {
    type: yesno
    sql: ${TABLE}.billable_from_provisioning ;;
    group_label: "Contract Terms"
  }

  dimension: cmrr_cents {
    label: "CMRR"
    type: number
    sql: ${TABLE}.cmrr_cents/100 ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "Financials"
  }

  measure: cmrr {
    label: "CMRR"
    type: sum
    sql: ${cmrr_cents};;
    value_format: "$#,##0;($#,##0)"
    group_label: "Financials"
  }

  #dimension: contract_dates {
  #  type: string
  #  sql: ${TABLE}.contract_dates ;;
  #}

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

  dimension_group: contract_expiration {
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
    sql:JSON_EXTRACT_SCALAR(${TABLE}.contract_dates,'$.contract_expires_on');;
  }

  dimension_group: subscription_start {
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
    sql:JSON_EXTRACT_SCALAR(${TABLE}.contract_dates,'$.subscription_starts_on');;
  }

  dimension_group: subscription_renewal {
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
    sql:JSON_EXTRACT_SCALAR(${TABLE}.contract_dates,'$.subscription_renews_on');;
  }

  dimension_group: launch_end {
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
    sql:JSON_EXTRACT_SCALAR(${TABLE}.contract_dates,'$.launch_ends_on');;
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

  dimension: has_custom_launch_product {
    type: yesno
    sql: ${TABLE}.has_custom_launch_product ;;
    group_label: "Contract Terms"
  }

  dimension: hub_customer_id {
    type: number
    sql: ${TABLE}.hub_customer_id ;;
    group_label: "HUB"
  }

  dimension: hub_customer_link_html {
    sql: 'https://hub.happy.co/customers/'||CAST(${id} AS STRING) ;;
    hidden: yes
  }

  dimension: hub_customer_link {
    label: "HUB Customer Link"
    sql: ${hub_customer_link_html} ;;
    html: <a href="{{ value }}" target="_blank">{{ id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "HUB"
  }

  #dimension: integrations {
  #  type: string
  #  sql: ${TABLE}.integrations ;;
  #}

  dimension: is_custom_contract {
    type: yesno
    sql: ${TABLE}.is_custom_contract ;;
    group_label: "Contract Terms"
  }

  dimension: market_data_company_id {
    type: number
    sql: ${TABLE}.market_data_company_id ;;
    hidden: yes
  }

  dimension: meets_contract_generation_criteria {
    type: yesno
    sql: ${TABLE}.meets_contract_generation_criteria ;;
    group_label: "Contract Terms"
  }

  dimension: one_off_amount_cents {
    label: "One-Off Amount"
    type: number
    sql: ${TABLE}.one_off_amount_cents/100 ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "Financials"
  }

  measure: one_off_amount {
    label: "One-Off Amount"
    type: sum
    sql: ${one_off_amount_cents} ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "Financials"
  }

  #dimension: one_off_product_codes {
  #  type: string
  #  sql: ${TABLE}.one_off_product_codes ;;
  #}

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
    hidden: yes
  }

  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }

  dimension: owners {
    type: string
    sql: ${TABLE}.owners ;;
    hidden: yes
  }

  dimension: launch_owner {
    type: string
    sql: JSON_EXTRACT_SCALAR(${TABLE}.owners,'$.launch_owner');;
    group_label: "Account Owners"
  }

  dimension: sales_owner {
    type: string
    sql: JSON_EXTRACT_SCALAR(${TABLE}.owners,'$.sales_owner');;
    group_label: "Account Owners"
  }

  dimension: percent_tier1_units_in_bps {
    label: "Percent Tier 1 Units"
    type: number
    sql: ${TABLE}.percent_tier1_units_in_bps/100 ;;
    value_format: "0.0\%"
    group_label: "Tier Info"
  }

  dimension: primary_industry {
    type: string
    sql: ${TABLE}.primary_industry ;;
    group_label: "Tier Info"
  }

  #dimension: reasons_for_buying {
  #  type: string
  #  sql: ${TABLE}.reasons_for_buying ;;
  #}

  #dimension: recurring_product_codes {
  #  type: string
  #  sql: ${TABLE}.recurring_product_codes ;;
  #}

  dimension: renewal_term_in_months {
    type: number
    sql: ${TABLE}.renewal_term_in_months ;;
    group_label: "Contract Terms"
  }

  dimension: sow_details_present {
    type: yesno
    sql: ${TABLE}.sow_details_present ;;
    group_label: "Contract Terms"
  }

  dimension: stage_order {
    type: number
    sql: CASE WHEN ${TABLE}.stage_name = 'Sales Qualified' THEN 1
            WHEN ${TABLE}.stage_name = 'Discovery' THEN 2
            WHEN ${TABLE}.stage_name = 'Pricing/Proposal' THEN 3
            WHEN ${TABLE}.stage_name = 'Contract Delivered' THEN 4
            WHEN ${TABLE}.stage_name = 'Launch & Activation' THEN 5
            WHEN ${TABLE}.stage_name = 'Closed Won' THEN 6
            WHEN ${TABLE}.stage_name = 'Closed Lost' THEN 7
          ELSE 8 END ;;
  hidden: yes
  }

  dimension: stage_name {
    label: "Stage"
    type: string
    sql: ${TABLE}.stage_name ;;
    order_by_field: stage_order
  }

  dimension_group: target_mrr {
    label: "Target MRR"
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
    group_label: "Tier Info"
  }

  dimension: total_properties {
    type: number
    sql: ${TABLE}.total_properties ;;
    group_label: "Tier Info"
  }

  dimension: total_units {
    type: number
    sql: ${TABLE}.total_units ;;
    group_label: "Tier Info"
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

  measure: count {
    type: count
    #drill_fields: [id, opportunity_name, stage_name, account_name]
  }
}
