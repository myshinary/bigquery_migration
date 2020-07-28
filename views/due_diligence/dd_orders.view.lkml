view: dd_orders {
  sql_table_name: `happyco-internal-systems.hub__due_diligence.orders`
    ;;

    view_label: "Customer"

  drill_fields: [dd_order_id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: dd_order_id {
    type: number
    sql: ${TABLE}.dd_order_id ;;
    hidden: yes
  }

  dimension: asana_project_id {
    type: number
    sql: ${TABLE}.asana_project_id ;;
    hidden: yes
  }

  dimension: billing_notes {
    type: string
    sql: ${TABLE}.billing_notes ;;
    hidden: yes
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
    sql: CAST(${TABLE}.created_at AS TIMESTAMP) ;;
    hidden: yes
  }

  dimension_group: design_report_delivered {
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
    sql: ${TABLE}.design_report_delivered_at ;;
    hidden: yes
  }

  dimension_group: design_report_required {
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
    sql: ${TABLE}.design_report_required_at ;;
    hidden: yes
  }

  dimension_group: lfa_completed {
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
    sql: ${TABLE}.lfa_completed_at ;;
    hidden: yes
  }

  dimension: lfa_project_code {
    type: string
    sql: ${TABLE}.lfa_project_code ;;
    hidden: yes
  }

  dimension: lfa_project_id {
    type: number
    sql: ${TABLE}.lfa_project_id ;;
    hidden: yes
  }

  dimension_group: lfa_scheduled {
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
    sql: ${TABLE}.lfa_scheduled_at ;;
    hidden: yes
  }

  dimension: plan_id {
    type: number
    sql: ${TABLE}.plan_id ;;
    hidden: yes
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension: property_address {
    type: string
    sql: ${TABLE}.property_address ;;
    hidden: yes
  }

  dimension: property_name {
    type: string
    sql: ${TABLE}.property_name ;;
    hidden: yes
  }

  dimension: real_property_id {
    type: number
    sql: ${TABLE}.real_property_id ;;
    hidden: yes
  }

  dimension: rent_roll_source {
    type: string
    sql: ${TABLE}.rent_roll_source ;;
    hidden: yes
  }

  dimension: reports_drive_link {
    type: string
    sql: ${TABLE}.reports_drive_link ;;
    hidden: yes
  }

  dimension: setup_configuration {
    type: string
    sql: ${TABLE}.setup_configuration ;;
    hidden: yes
  }

  dimension: setup_notes {
    type: string
    sql: ${TABLE}.setup_notes ;;
    hidden: yes
  }

  dimension: unit_quantity {
    type: number
    sql: ${TABLE}.unit_quantity ;;
    hidden: yes
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
    sql: CAST(${TABLE}.updated_at AS TIMESTAMP) ;;
    hidden: yes
  }

  dimension: using_resident_inspections {
    type: yesno
    sql: ${TABLE}.using_resident_inspections ;;
    hidden: yes
  }

  dimension: using_video_inspections {
    type: yesno
    sql: ${TABLE}.using_video_inspections ;;
    hidden: yes
  }

  dimension_group: walk_completed {
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
    sql: ${TABLE}.walk_completed_at ;;
    hidden: yes
  }

  dimension: walk_folder_id {
    type: number
    sql: ${TABLE}.walk_folder_id ;;
    hidden: yes
  }

  dimension_group: walk_scheduled {
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
    sql: ${TABLE}.walk_scheduled_at ;;
    hidden: yes
  }

  dimension: count_lfa_dimension {
    type: number
    sql: CASE WHEN ${lfa_project_code} IS NULL THEN 0 ELSE 1 END;;
    hidden: yes
  }

  measure: count_lfa {
    type: sum_distinct
    label: "LFAs"
    sql: ${count_lfa_dimension} ;;
    sql_distinct_key: ${id} ;;
    group_label: "DD"
  }

  measure: count {
    label: "DDs"
    type: count_distinct
    sql_distinct_key: ${id} ;;
    sql: ${id} ;;
    group_label: "DD"
    #drill_fields: [dd_order_id, property_name]
  }

}
