view: product_environment_active_counts {
  sql_table_name: `happyco-internal-systems.hub__reporting.product_environment_active_counts`
    ;;
  drill_fields: [product_environment_id]

  view_label: "Customer"

  dimension: id {
    # primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes

  }

  dimension: active_users {
    type: number
    sql: ${TABLE}.active_users ;;
    group_label: "Product Environment"
  }

  dimension: product_environment_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  measure: total_active_users {
    type: sum_distinct
    sql_distinct_key: ${product_environment_id} ;;
    sql:  ${active_users};;
    group_label: "Product Environment"
    # sql:  ;;
  }

  # measure: count {
  #   type: count
  #   drill_fields: [id]
  # }
}
