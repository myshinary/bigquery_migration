view: product_environment_nps_responses {
  sql_table_name: `happyco-internal-systems.hub__reporting.product_environment_nps_responses`
    ;;
  drill_fields: [id]
  view_label: "Account Management"

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
    group_label: "NPS"
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
    group_label: "NPS"
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: email {
    label: "User Email"
    type: string
    sql: ${TABLE}.email ;;
    group_label: "NPS"
  }

  dimension: happy_business_id {
    type: number
    sql: ${TABLE}.happy_business_id ;;
    hidden: yes
  }

  dimension: happy_user_id {
    type: number
    sql: ${TABLE}.happy_user_id ;;
    hidden: yes
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension_group: responded {
    label: "NPS"
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.responded_at AS TIMESTAMP) ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: user_full_name {
    label: "User Name"
    type: string
    sql: ${TABLE}.user_full_name ;;
    group_label: "NPS"
  }

  dimension: nps_type {
    label: "NPS Type"
    type: string
    sql: CASE WHEN ${answer} < 7 THEN 'Detractor' WHEN ${answer} BETWEEN 7 AND 8 THEN 'Passive' WHEN ${answer} > 8 THEN 'Promoter' ELSE NULL END;;
  }

  measure: promoter_percent {
    type: number
    sql: SUM(CASE WHEN ${answer} > 8 THEN 1 ELSE 0 END) / ${count} ;;
    group_label: "NPS"
    value_format: "0.0%"
  }

  measure: detractor_percent {
    type: number
    sql: SUM(CASE WHEN ${answer} < 7 THEN 1 ELSE 0 END) / ${count} ;;
    group_label: "NPS"
    value_format: "0.0%"
  }

  measure: nps {
    label: "NPS Score"
    type: number
    sql: ROUND((${promoter_percent} - ${detractor_percent}) * 100, 2) ;;
    group_label: "NPS"
    value_format: "0.#"
  }

  measure: count {
    type: count
    #drill_fields: [id, user_full_name]
    hidden: yes
  }
}
