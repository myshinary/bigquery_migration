view: property_provisioning_plan_recurring_products {
  sql_table_name: `happyco-internal-systems.hub__reporting.property_provisioning_plan_recurring_products`
    ;;

  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden:  yes
  }

  dimension: contract_terms_revision_id {
    type: number
    sql: ${TABLE}.contract_terms_revision_id ;;
    hidden:  yes
  }

  dimension: plan_id {
    type: number
    sql: ${TABLE}.plan_id ;;
    hidden:  yes
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.product_code ;;
    hidden:  yes
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden:  yes
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
    hidden:  yes
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
    hidden:  yes
  }

  dimension: rate_cents {
    type: number
    sql: ${TABLE}.rate_cents ;;
    hidden:  yes
  }

  dimension: so_item_id {
    type: number
    sql: ${TABLE}.so_item_id ;;
    hidden:  yes
  }

  #measure: count {
  #  type: count
  #  drill_fields: [id, product_name]
  #}
}
