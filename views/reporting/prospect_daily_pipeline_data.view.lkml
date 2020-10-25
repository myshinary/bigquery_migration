view: prospect_daily_pipeline_data {
  sql_table_name: `happyco-internal-systems.hub__reporting.prospect_daily_pipeline_data`
    ;;
  drill_fields: [id]
  view_label: "Opportunity History"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
    hidden: yes
  }

  dimension_group: activity {
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
    sql: ${TABLE}.activity_date ;;
    hidden: yes
  }

  dimension: activity_id {
    type: string
    sql: ${TABLE}.activity_id ;;
    hidden: yes
  }

  dimension_group: activity_performed {
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
    sql: ${TABLE}.activity_performed_on ;;
    hidden: yes
  }

  dimension: amount_cents {
    type: number
    sql: ${TABLE}.amount_cents ;;
    hidden: yes
  }

  measure: amount {
    label: "ACV"
    type: sum
    sql: CASE WHEN ${amount_cents} IS NOT NULL THEN ${amount_cents}/100 ELSE NULL END;;
    value_format: "$#,##0;($#,##0)"
    group_label: "Booking Values"
  }

  dimension_group: close {
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
    sql: ${TABLE}.close_date ;;
  }

  dimension: cmrr_cents {
    type: number
    sql: ${TABLE}.cmrr_cents ;;
    hidden: yes
  }

  measure: cmrr {
    label: "CMRR"
    type: sum
    sql: CASE WHEN ${cmrr_cents} IS NOT NULL THEN ${cmrr_cents}/100 ELSE NULL END;;
    value_format: "$#,##0;($#,##0)"
    group_label: "Booking Values"
  }

  dimension: lost_reason {
    type: string
    sql: ${TABLE}.lost_reason ;;
  }

  dimension: modified_by_name {
    type: string
    sql: ${TABLE}.modified_by_name ;;
    hidden: yes
  }

  dimension: oneoff_amount_cents {
    type: number
    sql: ${TABLE}.oneoff_amount_cents ;;
    hidden: yes
  }

  measure: oneoff_amount {
    label: "Oneoff Amount"
    type: sum
    sql: CASE WHEN ${oneoff_amount_cents} IS NOT NULL THEN ${oneoff_amount_cents}/100 ELSE NULL END;;
    value_format: "$#,##0;($#,##0)"
    group_label: "Booking Values"
  }

  dimension_group: opportunity_created {
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
    sql: ${TABLE}.opportunity_created_on ;;
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
    hidden: yes
  }

  dimension: opportunity_tier {
    type: string
    sql: ${TABLE}.opportunity_tier ;;
  }

  dimension: opportunity_type {
    type: string
    sql: ${TABLE}.opportunity_type ;;
  }

  dimension: owner_name {
    type: string
    sql: ${TABLE}.owner_name ;;
  }

  dimension_group: pipeline_date {
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
    sql: ${TABLE}.pipeline_date ;;
    label: "Pipeline Date"
  }

  dimension: probability {
    type: number
    sql: ${TABLE}.probability ;;
    hidden: yes
  }

  dimension: stage_name {
    type: string
    sql: ${TABLE}.stage_name ;;
    hidden: yes
  }

  dimension: stage {
    type: string
    sql:
      CASE
        WHEN ${stage_name} = 'Sales Qualified' THEN '1. Sales Qualified'
        WHEN ${stage_name} = 'Discovery' THEN '2. Discovery'
        WHEN ${stage_name} = 'Pricing/Proposal' THEN '3. Pricing/Proposal'
        WHEN ${stage_name} = 'Contract Delivered' THEN '4. Contract Delivered'
        WHEN ${stage_name} = 'Launch & Activation' THEN '5. Launch & Activation'
        WHEN ${stage_name} = 'Closed Won' THEN '6. Closed Won'
        ELSE ${stage_name} END
        ;;
  }

  dimension: tier_source {
    type: string
    sql: ${TABLE}.tier_source ;;
  }

  measure: count {
    type: count
    drill_fields: [id, owner_name, stage_name, modified_by_name]
    hidden: yes
  }

  measure: number_of_distinct_opportunities {
    type: count_distinct
    sql: ${opportunity_id} ;;
  }
}