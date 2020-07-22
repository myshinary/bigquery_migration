view: product_environment_feature_flags_and_status {
  sql_table_name: `happyco-internal-systems.hub__reporting.product_environment_feature_flags_and_status`
    ;;
    view_label: "HUB"
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: activation_management {
    type: yesno
    sql: ${TABLE}.activation_management_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: admin_only_template_access {
    type: yesno
    sql: ${TABLE}.admin_only_template_access_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: create_folders {
    type: yesno
    sql: ${TABLE}.create_folders_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: create_users {
    type: yesno
    sql: ${TABLE}.create_users_enabled ;;
    group_label: "Features Enabled"
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

  dimension: custom_roles {
    type: yesno
    sql: ${TABLE}.custom_roles_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
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
    hidden: yes
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
    hidden: yes
  }

  dimension: inspection_assignment {
    type: yesno
    sql: ${TABLE}.inspection_assignment_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: looker {
    type: yesno
    sql: ${TABLE}.looker_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: multi_family {
    type: yesno
    sql: ${TABLE}.multi_family_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    hidden: yes
  }

  dimension: permissions_access {
    type: yesno
    sql: ${TABLE}.permissions_access_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: plan_id {
    type: number
    sql: ${TABLE}.plan_id ;;
    hidden: yes
  }

  dimension: plan_name {
    type: string
    sql: ${TABLE}.plan_name ;;
    view_label: "HappyCo"
    group_label: "Admin Plan"
  }

  dimension: plan_status {
    type: string
    sql: ${TABLE}.plan_status ;;
    view_label: "HappyCo"
    group_label: "Admin Plan"
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension: projects {
    type: yesno
    sql: ${TABLE}.projects_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: push_inspect {
    type: yesno
    sql: ${TABLE}.push_inspect_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: remote_inspections {
    type: yesno
    sql: ${TABLE}.remote_inspections_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: report_workflows {
    type: yesno
    sql: ${TABLE}.report_workflows_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: revision {
    type: number
    sql: ${TABLE}.revision ;;
    hidden: yes
  }

  dimension: schedules {
    type: yesno
    sql: ${TABLE}.schedules_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: support {
    type: yesno
    sql: ${TABLE}.support_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: tasks {
    type: yesno
    sql: ${TABLE}.tasks_enabled ;;
    group_label: "Features Enabled"
  }

  dimension: template_logic {
    type: yesno
    sql: ${TABLE}.template_logic_enabled ;;
    group_label: "Features Enabled"
  }

  #measure: count {
  #  type: count
  #  drill_fields: [id, plan_name, name]
  #}
}
