view: price_per_unit_by_propery {
derived_table: {
  sql:
      SELECT product_environment_id, SUM(rate_cents/1200) as ppu
      FROM
      (SELECT id, product_environment_id, product_type, rate_cents
      FROM ${property_provisioning_plan_recurring_products.SQL_TABLE_NAME}) x
      GROUP BY 1;;
#persist_for: "24 hours"
#indexes: ["transaction_number","invoice_number"]
}

  dimension: product_environment_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension:price_per_unit_dimension {
    label: "Price per Unit by Property"
    type: number
    sql: ${TABLE}.ppu ;;
    hidden: yes
    #value_format: "$#,##0;($#,##0)"
    view_label: "HappyCo"
    group_label: "Revenue"
    description: "Price per Unit for all Products in a Property."
  }

  measure: price_per_unit {
    type: average
    sql: ${price_per_unit_dimension} ;;
    value_format: "$0.00;($0.00)"
    view_label: "HappyCo"
    group_label: "Revenue"
    description: "Price per Unit for all Products in a Property."
  }
}
