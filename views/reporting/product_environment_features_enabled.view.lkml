view: product_environment_features_enabled {
derived_table: {
  sql:
    SELECT product_environment_id, 'Create Folders' as feature, create_folders_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Create Users' as feature, create_users_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Permissions Access' as feature, permissions_access_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Looker' as feature, looker_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Push Inspect' as feature, push_inspect_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Custom Roles' as feature, custom_roles_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Support' as feature, support_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Activation Management' as feature, activation_management_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Template Logic' as feature, template_logic_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Schedules' as feature, schedules_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Admin Only Template Access' as feature, admin_only_template_access_enabled as enabledfeature
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Report Workflows' as feature, report_workflows_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Tasks' as feature, tasks_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Projects' as feature, projects_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Multi-Family' as feature, multi_family_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Remote Inspections' as feature, remote_inspections_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
      UNION ALL
      SELECT product_environment_id, 'Inspection Assignment' as feature, inspection_assignment_enabled as enabled
      FROM ${product_environment_feature_flags_and_status.SQL_TABLE_NAME}
    ;;
  }

  view_label: "Customer"

  dimension: product_environment_id {
    type: string
    sql: ${TABLE}.product_environment_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: feature {
    type: string
    sql: ${TABLE}.feature ;;
    group_label: "Features Enabled"
  }

  dimension: enabled  {
    type: string
    sql: ${TABLE}.enabled;;
    group_label: "Features Enabled"
  }

  dimension: feature_enabled  {
    type: string
    sql: CASE WHEN ${enabled} IS TRUE THEN ${feature} ELSE NULL END;;
    hidden: yes
  }

  measure: features_enabled {
    type: string
    sql:  STRING_AGG(CASE WHEN ${enabled} IS TRUE THEN 'Yes' ELSE NULL END,', ') ;;
    group_label: "Features Enabled"
    description: "Use with Feature Dimension either as a column or pivot"
  }

  measure: features_enabled_named {
    type: string
    sql:  STRING_AGG(DISTINCT ${feature_enabled},', ') ;;
    group_label: "Features Enabled"
  }

}
