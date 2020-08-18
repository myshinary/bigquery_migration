view: customer_current_overall_risks {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_current_overall_risks`
    ;;

    view_label: "HUB"
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: overall_risk {
    label: "Current Risk Score"
    type: number
    sql: ${TABLE}.overall_risk ;;
    group_label: "CS"
  }

  dimension: overall_risk_rounded {
    label: "Risk Score Rounded"
    type: number
    sql: ROUND(${overall_risk},-1) ;;
    group_label: "CS"
    description: "Current Risk Score rounded to the nearest 10"
  }

  dimension: mrr_at_risk_dimension {
    type: number
    sql: ${overall_risk}*${fnli_current_mrr_by_root_so_customer.current_mrr_by_parent}/100 ;;
    hidden: no
  }

  measure: mrr_at_risk {
    type: sum_distinct
    sql_distinct_key: ${customer_id} ;;
    sql: ${mrr_at_risk_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    label: "MRR at Risk"
    group_label: "CS"
  }

  #measure: count {
  #  type: count
  #  drill_fields: [id]
  #}
}
