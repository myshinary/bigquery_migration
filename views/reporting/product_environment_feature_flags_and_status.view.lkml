view: product_environment_feature_flags_and_status {
  sql_table_name: `happyco-internal-systems.hub__reporting.product_environment_feature_flags_and_status`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: activation_management_enabled {
    type: yesno
    sql: ${TABLE}.activation_management_enabled ;;
  }

  dimension: admin_only_template_access_enabled {
    type: yesno
    sql: ${TABLE}.admin_only_template_access_enabled ;;
  }

  dimension: create_folders_enabled {
    type: yesno
    sql: ${TABLE}.create_folders_enabled ;;
  }

  dimension: create_users_enabled {
    type: yesno
    sql: ${TABLE}.create_users_enabled ;;
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
  }

  dimension: custom_roles_enabled {
    type: yesno
    sql: ${TABLE}.custom_roles_enabled ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: effective {
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
    sql: ${TABLE}.effective_on ;;
  }

  dimension_group: effective_until {
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
    sql: ${TABLE}.effective_until ;;
  }

  dimension: inspection_assignment_enabled {
    type: yesno
    sql: ${TABLE}.inspection_assignment_enabled ;;
  }

  dimension: looker_enabled {
    type: yesno
    sql: ${TABLE}.looker_enabled ;;
  }

  dimension: multi_family_enabled {
    type: yesno
    sql: ${TABLE}.multi_family_enabled ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: permissions_access_enabled {
    type: yesno
    sql: ${TABLE}.permissions_access_enabled ;;
  }

  dimension: plan_id {
    type: number
    sql: ${TABLE}.plan_id ;;
  }

  dimension: plan_name {
    type: string
    sql: ${TABLE}.plan_name ;;
  }

  dimension: plan_status {
    type: string
    sql: ${TABLE}.plan_status ;;
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
  }

  dimension: projects_enabled {
    type: yesno
    sql: ${TABLE}.projects_enabled ;;
  }

  dimension: push_inspect_enabled {
    type: yesno
    sql: ${TABLE}.push_inspect_enabled ;;
  }

  dimension: remote_inspections_enabled {
    type: yesno
    sql: ${TABLE}.remote_inspections_enabled ;;
  }

  dimension: report_workflows_enabled {
    type: yesno
    sql: ${TABLE}.report_workflows_enabled ;;
  }

  dimension: revision {
    type: number
    sql: ${TABLE}.revision ;;
  }

  dimension: schedules_enabled {
    type: yesno
    sql: ${TABLE}.schedules_enabled ;;
  }

  dimension: support_enabled {
    type: yesno
    sql: ${TABLE}.support_enabled ;;
  }

  dimension: tasks_enabled {
    type: yesno
    sql: ${TABLE}.tasks_enabled ;;
  }

  dimension: template_logic_enabled {
    type: yesno
    sql: ${TABLE}.template_logic_enabled ;;
  }

  measure: count {
    type: count
    drill_fields: [id, plan_name, name]
  }
}
