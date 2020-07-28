view: orders {
  sql_table_name: `happyco-internal-systems.hub__property_provisioning.orders`
    ;;
  drill_fields: [id]

  view_label: "Customer"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension_group: activate_on {
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
    sql: ${TABLE}.activate_on_date ;;
    hidden: yes
  }

  dimension_group: activated {
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
    sql: ${TABLE}.activated_at ;;
    hidden: yes
  }

  dimension: activation_requested_by_id {
    type: number
    sql: ${TABLE}.activation_requested_by_id ;;
    hidden: yes
  }

  dimension: activation_requested_by_type {
    type: string
    sql: ${TABLE}.activation_requested_by_type ;;
    hidden: yes
  }

  dimension: address_city {
    type: string
    sql: ${TABLE}.address_city ;;
    hidden: yes
  }

  dimension: address_line1 {
    type: string
    sql: ${TABLE}.address_line1 ;;
    hidden: yes
  }

  dimension: address_state {
    type: string
    sql: ${TABLE}.address_state ;;
    hidden: yes
  }

  dimension: address_zip {
    type: string
    sql: ${TABLE}.address_zip ;;
    hidden: yes
  }

  dimension: billing_email {
    type: string
    sql: ${TABLE}.billing_email ;;
    hidden: yes
  }

  dimension_group: canceled {
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
    sql: ${TABLE}.canceled_at ;;
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

  dimension_group: deactivate_on {
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
    sql: ${TABLE}.deactivate_on_date ;;
    hidden: yes
  }

  dimension_group: deactivated {
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
    sql: ${TABLE}.deactivated_at ;;
    hidden: yes
  }

  dimension: external_id {
    type: string
    sql: ${TABLE}.external_id ;;
    hidden: yes
  }

  dimension: folder_id {
    type: number
    sql: ${TABLE}.folder_id ;;
    hidden: yes
  }

  dimension: integration_details {
    type: string
    sql: ${TABLE}.integration_details ;;
    hidden: yes
  }

  dimension: legal_name {
    type: string
    sql: ${TABLE}.legal_name ;;
    hidden: yes
  }


  dimension: plan_id {
    type: number
    sql: ${TABLE}.plan_id ;;
    hidden: yes
  }

  dimension: product_environment_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension: properties_order_id {
    type: number
    sql: ${TABLE}.properties_order_id ;;
    hidden: yes
  }

  dimension: property_order_link_html {
    sql: 'https://hub.happy.co/property_provisioning/customers/'||CAST(${product_environment_id} AS STRING)||'/orders/'||CAST(${properties_order_id} AS STRING) ;;
    hidden: yes
  }

  dimension: hub_property_order_link {
    sql: ${property_order_link_html} ;;
    html: <a href="{{ value }}" target="_blank">{{ properties_order_id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    label: "HUB Property Order Link"
    group_label: "HUB Links"
  }

  dimension: provisioning_plan_link_html {
    sql: 'https://hub.happy.co/properties/plans/'||CAST(${plan_id} AS STRING) ;;
    hidden: yes
  }

  dimension: hub_provisioning_plan_link {
    label: "HUB Provisioning Plan Link"
    sql: ${provisioning_plan_link_html} ;;
    html: <a href="{{ value }}" target="_blank">{{ plan_id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "HUB Links"
  }

  dimension: property_code {
    type: string
    sql: ${TABLE}.property_code ;;
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

  dimension: so_customer_id {
    type: number
    sql: ${TABLE}.so_customer_id ;;
    hidden: yes
  }

  dimension: unit_quantity {
    type: number
    sql: ${TABLE}.unit_quantity ;;
    hidden: yes
  }

  measure: units_ordered {
    type: sum
    sql: ${unit_quantity} ;;
    group_label: "Revenue"
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
  #  drill_fields: [id, property_name, legal_name, product_environments.name, product_environments.id]
  #}
}
