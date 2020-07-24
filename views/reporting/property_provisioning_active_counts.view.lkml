view: property_provisioning_active_counts {
  sql_table_name: `happyco-internal-systems.hub__reporting.property_provisioning_active_counts`
    ;;
  drill_fields: [id]
  view_label: "HUB"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: active_properties_dimension {
    type: number
    sql: ${TABLE}.active_properties ;;
    hidden: yes
  }

  measure: active_properties {
    type: sum
    sql: ${active_properties_dimension} ;;
    group_label: "Active Counts"
  }

  dimension: active_units_dimension {
    type: number
    sql: ${TABLE}.active_units ;;
    hidden: yes
  }

  measure: active_units {
    type: sum
    sql: ${active_units_dimension} ;;
    group_label: "Active Counts"
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
    hidden: yes
  }

  dimension: deactivation_pending_properties_dimension {
    type: number
    sql: ${TABLE}.deactivation_pending_properties ;;
    hidden: yes
  }

  measure: deactivation_pending_properties {
    type: sum
    sql: ${deactivation_pending_properties_dimension} ;;
    group_label: "Active Counts"
  }

  dimension: deactivation_pending_units_dimension {
    type: number
    sql: ${TABLE}.deactivation_pending_units ;;
    hidden: yes
  }

  measure: deactivation_pending_units {
    type: sum
    sql: ${deactivation_pending_units_dimension} ;;
    group_label: "Active Counts"
  }

  dimension: hub_customer_link {
    type: string
    sql: ${TABLE}.hub_customer_link ;;
    hidden: yes
  }

  dimension: hub_customer {
    label: "Customer"
    sql: ${hub_customer_link} ;;
    html: <a href="{{ value }}" target="_blank">{{ customer_id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "HUB Links"
  }

  dimension: invoice_billed_on {
    label: "Billed On"
    type: string
    sql: ${TABLE}.invoice_billed_on ;;
    group_label: "Finances"
  }

  dimension: invoice_billed_to {
    label: "Billed To"
    type: string
    sql: ${TABLE}.invoice_billed_to ;;
    group_label: "Finances"
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

  dimension: product_environment_name {
    label: "HappyCo Business Name"
    type: string
    sql: ${TABLE}.product_environment_name ;;
    view_label: "HappyCo"
  }

  dimension: provisioning_plan_link {
    type: string
    sql: ${TABLE}.provisioning_plan_link ;;
    hidden: yes
  }

  dimension: provisioning_plan {
    label: "Property Provisioning"
    sql: ${provisioning_plan_link} ;;
    html: <a href="{{ value }}" target="_blank">{{ id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "HUB Links"
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

  #measure: count {
  #  type: count
  #  drill_fields: [id, product_environment_name, customer_name]
  #}
}
