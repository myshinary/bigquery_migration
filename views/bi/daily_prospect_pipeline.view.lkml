view: daily_prospect_pipeline {
  derived_table: {
    sql:
    SELECT id, activity_id, opportunity_id, pipeline_date, DATE_TRUNC(pipeline_date,QUARTER) as pipeline_quarter, owner_name, stage_name, probability, amount_cents, cmrr_cents, oneoff_amount_cents, COALESCE(probability-LAG(probability) OVER (PARTITION BY opportunity_id ORDER BY pipeline_date),probability) as probability_change, COALESCE(amount_cents-LAG(amount_cents) OVER (PARTITION BY opportunity_id ORDER BY pipeline_date),amount_cents) as amount_cents_change, COALESCE(cmrr_cents-LAG(cmrr_cents) OVER (PARTITION BY opportunity_id ORDER BY pipeline_date),cmrr_cents) as cmrr_change, COALESCE(oneoff_amount_cents-LAG(oneoff_amount_cents) OVER (PARTITION BY opportunity_id ORDER BY pipeline_date),oneoff_amount_cents) as oneoff_amount_cents_change, CASE WHEN pipeline_date = MAX(pipeline_date) OVER (PARTITION BY opportunity_id,DATE_TRUNC(pipeline_date,MONTH)) THEN TRUE ELSE FALSE END as month_end, CASE WHEN pipeline_date = MAX(pipeline_date) OVER (PARTITION BY opportunity_id,DATE_TRUNC(pipeline_date,QUARTER)) THEN TRUE ELSE FALSE END as quarter_end
      FROM `happyco-internal-systems.hub__reporting.prospect_daily_pipeline_data`

      ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id;;
    hidden: yes
    primary_key: yes
  }

  dimension: activity_id {
    type: string
    sql: ${TABLE}.activity_id;;
    hidden: yes
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id;;
    hidden: yes
  }

  dimension: owner_name {
    type: string
    sql: ${TABLE}.owner_name;;
    hidden: yes
  }

  dimension: stage_order {
    type: string
    sql:
      CASE
        WHEN ${stage_name} = 'Sales Qualified' THEN 1
        WHEN ${stage_name} = 'Discovery' THEN 2
        WHEN ${stage_name} = 'Pricing/Proposal' THEN 3
        WHEN ${stage_name} = 'Contract Delivered' THEN 4
        WHEN ${stage_name} = 'Launch & Activation' THEN 5
        WHEN ${stage_name} = 'Closed Won' THEN 6
        ELSE 0 END
        ;;
    hidden: yes
  }

  dimension: stage_name {
    label: "Stage"
    type: string
    sql: ${TABLE}.stage_name ;;
    order_by_field: stage_order
  }

  dimension_group: pipeline {
    type: time
    timeframes: [
      date,
      month,
      quarter
    ]
    sql: ${TABLE}.pipeline_date ;;
  }

  dimension: amount_cents {
    type: number
    sql: ${TABLE}.amount_cents/100 ;;
    hidden: yes
  }

  dimension: cmrr_cents {
    type: number
    sql: ${TABLE}.cmrr_cents/100 ;;
    hidden: yes
  }

  dimension: oneoff_amount_cents {
    type: number
    sql: ${TABLE}.oneoff_amount_cents/100 ;;
    hidden: yes
  }

  measure: amount_cents_change {
    type: sum
    sql: ${TABLE}.amount_cents_change/100;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: cmrr_change {
    type: sum
    sql: ${TABLE}.cmrr_change/100;;
    value_format: "$#,##0;($#,##0)"
  }

  measure: oneoff_amount_cents_change {
    type: sum
    sql: ${TABLE}.oneoff_amount_cents_change/100;;
    value_format: "$#,##0;($#,##0)"
  }

  #measure: mrr {
  #  type: sum
  #  sql: ${mrr_dimension} ;;
  #  label: "Current MRR"
  #  value_format: "$#,##0;($#,##0)"
  #}

}
