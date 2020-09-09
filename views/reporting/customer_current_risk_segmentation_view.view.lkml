view: customer_current_risk_segmentation_view {
  view_label: "Customer"
  derived_table: {
    sql:
    SELECT id, customer_id, overall_risk
    FROM ${customer_current_overall_risks.SQL_TABLE_NAME} ;;
  }

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
    hidden: yes
  }

  dimension: overall_risk_rounded {
    label: "Risk Score Rounded"
    type: number
    sql: ROUND(${overall_risk},-1) ;;
    view_label: "Customer"
    group_label: "Risk Score"
    description: "Current Risk Score rounded to the nearest 10"
  }

  measure: risk_score {
    label: "Average Risk Score"
    type: average
    sql: ${overall_risk} ;;
    view_label: "Customer"
    group_label: "Risk Score"
    description: "Current Average Risk Score rounded to the nearest 10"
    value_format: "0.0"
  }

  #measure: count {
  #  type: count
  #  drill_fields: [id]
  #}
}
