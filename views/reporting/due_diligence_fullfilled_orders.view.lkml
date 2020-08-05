view: due_diligence_fullfilled_orders {
  sql_table_name: `happyco-internal-systems.hub__reporting.due_diligence_fullfilled_orders`
    ;;
  drill_fields: [id]

  view_label: "DD Orders"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: amount_cents {
    type: number
    sql: ${TABLE}.amount_cents ;;
    hidden: yes
  }

  measure: revenue_amount {
    label: "Revenue"
    type: sum
    sql: ${amount_cents}/100;;
    value_format: "$#,##0;($#,##0)"

  }

  dimension_group: completed {
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
    sql: ${TABLE}.completed_at ;;
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

  dimension: lfa_project_id {
    label: "LFA Project ID"
    type: number
    sql: ${TABLE}.lfa_project_id ;;
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

  dimension: product_names {
    label: "Product"
    type: string
    sql: ${TABLE}.product_names ;;
  }

  dimension: property_address {
    type: string
    sql: ${TABLE}.property_address ;;
  }

  dimension: property_name {
    type: string
    sql: ${TABLE}.property_name ;;
  }

  dimension: real_property_id {
    type: number
    sql: ${TABLE}.real_property_id ;;
    hidden: yes
  }

  dimension: rent_roll_source {
    type: string
    sql: ${TABLE}.rent_roll_source ;;
  }

  dimension_group: started {
    label: "DD Started"
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
    sql: ${TABLE}.started_at ;;
  }

  dimension: unit_quantity {
    type: number
    sql: ${TABLE}.unit_quantity ;;
    hidden: yes
  }

  measure: units {
    type: sum
    sql: ${unit_quantity} ;;
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

  dimension: walk_folder_id {
    label: "Unit Walk Folder ID"
    type: number
    sql: ${TABLE}.walk_folder_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, property_name]
  }
}
