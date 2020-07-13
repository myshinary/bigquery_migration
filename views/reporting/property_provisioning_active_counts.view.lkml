view: property_provisioning_active_counts {
  sql_table_name: `happyco-internal-systems.hub__reporting.property_provisioning_active_counts`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: active_properties {
    type: number
    sql: ${TABLE}.active_properties ;;
  }

  dimension: active_units {
    type: number
    sql: ${TABLE}.active_units ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }

  dimension: deactivation_pending_properties {
    type: number
    sql: ${TABLE}.deactivation_pending_properties ;;
  }

  dimension: deactivation_pending_units {
    type: number
    sql: ${TABLE}.deactivation_pending_units ;;
  }

  dimension: hub_customer_link {
    type: string
    sql: ${TABLE}.hub_customer_link ;;
  }

  dimension: invoice_billed_on {
    type: string
    sql: ${TABLE}.invoice_billed_on ;;
  }

  dimension: invoice_billed_to {
    type: string
    sql: ${TABLE}.invoice_billed_to ;;
  }

  dimension: plan_id {
    type: number
    sql: ${TABLE}.plan_id ;;
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
  }

  dimension: product_environment_name {
    type: string
    sql: ${TABLE}.product_environment_name ;;
  }

  dimension: provisioning_plan_link {
    type: string
    sql: ${TABLE}.provisioning_plan_link ;;
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
  }

  measure: count {
    type: count
    drill_fields: [id, product_environment_name, customer_name]
  }
}
