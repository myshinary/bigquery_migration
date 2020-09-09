view: customer_nps_responses {
view_label: "Customer"
  derived_table: {
    sql:
    SELECT id, customer_id, answer
    FROM ${product_environment_nps_responses.SQL_TABLE_NAME} ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: answer {
    label: "Score"
    type: number
    sql: ${TABLE}.answer ;;
    hidden: no
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  measure: promoter_percent {
    type: number
    sql: SUM(CASE WHEN ${answer} > 8 THEN 1 ELSE 0 END) / SUM(1) ;;
    group_label: "NPS"
    value_format: "0.0%"
    hidden: yes
  }

  measure: detractor_percent {
    type: number
    sql: SUM(CASE WHEN ${answer} < 7 THEN 1 ELSE 0 END) / SUM(1) ;;
    group_label: "NPS"
    value_format: "0.0%"
    hidden: yes
  }

  measure: nps {
    label: "NPS Score"
    type: number
    sql: ROUND((${promoter_percent} - ${detractor_percent}) * 100, 2) ;;
    group_label: "NPS"
    value_format: "0.0"
  }

  measure: count {
    label: "NPS COUNT"
    type: count
    #drill_fields: [id, user_full_name]
    hidden: yes
  }
}
