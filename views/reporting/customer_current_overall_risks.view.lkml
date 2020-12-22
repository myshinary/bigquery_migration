view: customer_current_overall_risks {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_current_overall_risks`
    ;;

    view_label: "Account Management"
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
    hidden: yes
  }

  dimension: cmrr_at_risk_dimension {
    type: number
    sql: ${overall_risk}*${customer_service_agreements.in_launch_cmrr_dimension}/100 ;;
    hidden: yes
  }

  measure: mrr_at_risk {
    type: sum_distinct
    sql_distinct_key: ${customer_id} ;;
    sql: ${mrr_at_risk_dimension} ;;
    description: "Current MRR * (Risk Score as a percentage). Ex. $1,000 with a risk score of 90 will have $900 MRR at Risk."
    value_format: "$#,##0;($#,##0)"
    label: "MRR at Risk"
    group_label: "CS"
    drill_fields: [customers.parent,overall_risk,customers.hub_customer_link,mrr_at_risk,fnli_current_mrr_by_root_so_customer.current_mrr_by_parent,customer_owners.empoyee_names]
  }

  measure: cmrr_at_risk {
    type: sum_distinct
    sql_distinct_key: ${customer_service_agreements.id} ;;
    sql: ${cmrr_at_risk_dimension};;
    description: "Current CMRR * (Risk Score as a percentage) for Opportunities In Launch. Ex. $1,000 with a risk score of 90 will have $900 MRR at Risk."
    value_format: "$#,##0;($#,##0)"
    label: "CMRR at Risk"
    group_label: "CS"
    drill_fields: [customers.parent,overall_risk,customers.hub_customer_link,mrr_at_risk,fnli_current_mrr_by_root_so_customer.current_mrr_by_parent,customer_owners.empoyee_names]
  }

  #measure: count {
  #  type: count
  #  drill_fields: [id]
  #}
}
