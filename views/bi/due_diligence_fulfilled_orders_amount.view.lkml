view: due_diligence_fulfilled_orders_amount {
  view_label: "Customer"
  derived_table: {
    sql:
    SELECT id, product_environment_id, real_property_id, amount_cents
    FROM ${due_diligence_fullfilled_orders.SQL_TABLE_NAME}
    ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: product_environment_id {
    type: string
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension: real_property_id {
    type: string
    sql: ${TABLE}.real_property_id ;;
    hidden: yes
  }

  dimension: amount_cents {
    type: number
    sql: ${TABLE}.amount_cents ;;
    hidden: yes
  }

  measure: amount {
    type: sum
    sql: ${amount_cents}/100 ;;
    label: "DD Amount"
    value_format: "$#,##0;($#,##0)"
    group_label: "Revenue"
  }
}
