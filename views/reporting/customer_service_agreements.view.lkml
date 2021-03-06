view: customer_service_agreements {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_service_agreements`
    ;;
  view_label: "Customer"
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: cmrr_cents {
    type: number
    sql: ${TABLE}.cmrr_cents ;;
    hidden: yes
  }

  dimension: cmrr_dimension {
    type: number
    sql: ${cmrr_cents}/100;;
    hidden: yes
  }

  dimension: in_launch_cmrr_dimension {
    type: number
    sql: CASE WHEN ${in_launch} IS TRUE THEN ${cmrr_dimension}  ELSE NULL END;;
    hidden: yes
  }

  dimension_group: contract_expiry {
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
    sql: ${TABLE}.contract_expiry_date ;;
    hidden: yes
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
    label: "Service Agreement: Contract Issue"
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: in_launch {
    type: yesno
    sql: ${TABLE}.in_launch ;;
    group_label: "Service Agreement"
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
    sql: ${TABLE}.launch_end_date ;;
    label: "Service Agreement: Launch End"
    description: "Launch Period End Date"
  }

  dimension_group: launch_start {
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
    sql: ${TABLE}.launch_start_date ;;
    label: "Service Agreement: Launch Start"
  }

  dimension: oneoff_amount_cents {
    type: number
    sql: ${TABLE}.oneoff_amount_cents ;;
    hidden: yes
  }

  dimension: oneoff_amount_dimension {
    type: number
    sql: ${oneoff_amount_cents}/100;;
    hidden: yes
  }

  dimension_group: opportunity_close {
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
    sql: ${TABLE}.opportunity_close_date ;;
    hidden: yes
    #should stay hidden and fully activated on should be un hidden instead
    description: "Launch Completion Date"
  }

  dimension_group: fully_activated_on {
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
    sql: CASE WHEN ${launch_end_date} > ${opportunity_close_date} THEN ${launch_end_date} ELSE ${opportunity_close_date} END;;
    #find highest date between launch to protect against lack of checks and balances from salesforce sourced opp close date
    hidden: yes
    description: "Launch Completion Date"
  }

  dimension: recurring_products {
    type: string
    sql: ${TABLE}.recurring_products ;;
    hidden: yes
  }

  dimension: salesforce_opportunity_id {
    type: string
    sql: ${TABLE}.salesforce_opportunity_id ;;
    hidden: yes
  }

  dimension: opportunity_type {
    type: string
    sql: ${TABLE}.salesforce_opportunity_type ;;
    group_label: "Service Agreement"
  }

  dimension: special_terms {
    type: string
    sql: ${TABLE}.special_terms ;;
    hidden: yes
  }

  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
    hidden: yes
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
    sql: ${TABLE}.subscription_renewal_date ;;
    hidden: yes
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
    sql: ${TABLE}.subscription_start_date ;;
    label: "Service Agreement: Subscription Start"
  }

  dimension: transactional_products {
    type: string
    sql: ${TABLE}.transactional_products ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id]
    group_label: "Service Agreement"
  }

  measure: cmrr {
    label: "CMRR"
    type: sum
    sql: ${cmrr_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "Service Agreement"
  }

  measure: in_launch_cmrr {
    label: "CMRR (In Launch)"
    description: "This only adds the CMRR for Opportunities that are currently in Launch"
    type: sum
    sql: ${cmrr_dimension} ;;
    filters: [in_launch: "yes"]
    value_format: "$#,##0;($#,##0)"
    group_label: "Service Agreement"
  }

  measure: oneoff_amount {
    label: "One-Off Amount"
    type: sum
    sql: ${oneoff_amount_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "Service Agreement"
  }

}
