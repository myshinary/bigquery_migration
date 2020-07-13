view: product_groups {
  sql_table_name: `happyco-internal-systems.hub__commissions.product_groups`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: projection_recurrence_factor {
    type: number
    sql: ${TABLE}.projection_recurrence_factor ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, sales_levels.count, normalized_order_line_items.count]
  }
}
