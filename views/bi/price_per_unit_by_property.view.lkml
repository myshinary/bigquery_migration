view: price_per_unit_by_property {
  derived_table: {
    sql:

      SELECT id, SUM(price_per_unit) as price_per_unit
        FROM
        (SELECT id, product_type, SUM(mrr)/SUM(DISTINCT unit_quantity) as price_per_unit
        FROM
        (SELECT properties.id, properties_order_line_items.product_type, properties_order_line_items.amount_cents/1200 as mrr, CASE WHEN unit_type.unit_type = 'bed' THEN COALESCE(NULLIF(apartments.number_of_units,0),orders.unit_quantity) ELSE orders.unit_quantity END as unit_quantity
        FROM ${properties.SQL_TABLE_NAME} properties
        LEFT JOIN ${aln_mappings.SQL_TABLE_NAME} as aln_mappings
        ON properties.id = aln_mappings.property_id
        LEFT JOIN ${apartments.SQL_TABLE_NAME} as apartments
        ON aln_mappings.aln_apartment_id = apartments.id
        LEFT JOIN ${orders.SQL_TABLE_NAME} as orders
        ON properties.id = orders.real_property_id
        LEFT JOIN ${properties_order_line_items.SQL_TABLE_NAME} as properties_order_line_items
        ON orders.properties_order_id = properties_order_line_items.properties_order_id
        LEFT JOIN ${property_provisioning_plans.SQL_TABLE_NAME} unit_type
        ON orders.plan_id = unit_type.plan_id
        WHERE properties_order_line_items.is_recurring IS TRUE
        AND orders.deactivated_at IS NULL) x1
        GROUP BY 1,2) x2
        GROUP BY 1
        ;;
    #persist_for: "24 hours"
    #indexes: ["transaction_number","invoice_number"]
    }

    view_label: "Customer"

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.id ;;
      hidden: yes
    }

    dimension:price_per_unit_dimension {
      type: number
      sql: ${TABLE}.price_per_unit ;;
      hidden: yes
      #value_format: "$#,##0;($#,##0)"
      group_label: "Revenue"
    }

    measure: price_per_unit {
      type: average
      sql: ${price_per_unit_dimension} ;;
      value_format: "$0.00;($0.00)"
      group_label: "Revenue"
      description: "Price per Unit for all Products in a Property."
    }
  }
