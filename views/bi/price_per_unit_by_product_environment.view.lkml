view: price_per_unit_by_product_environment {
  derived_table: {
    sql:
      SELECT product_environment_id, product_type, AVG(price_per_unit) as price_per_unit, SUM(DISTINCT unit_quantity) as unit_quantity
      FROM
      (SELECT product_environment_id, id,
      {% if finance_normalized_line_items.product_group_name._in_query %}
         product_type
          {% else %}
         'happy_inspector'
       {% endif %} as product_type,
      SUM(mrr)/SUM(DISTINCT unit_quantity) as price_per_unit, SUM(DISTINCT unit_quantity) as unit_quantity
      FROM
      (SELECT orders.product_environment_id, properties.id, properties_order_line_items.product_type, properties_order_line_items.amount_cents/1200 as mrr, orders.unit_quantity as unit_quantity
      FROM ${properties.SQL_TABLE_NAME} properties
      LEFT JOIN ${orders.SQL_TABLE_NAME} as orders
      ON properties.id = orders.real_property_id
      LEFT JOIN `happyco-internal-systems.hub__orders.properties_order_line_items` as properties_order_line_items
      ON orders.properties_order_id = properties_order_line_items.properties_order_id
      WHERE properties_order_line_items.is_recurring IS TRUE
      AND orders.deactivated_at IS NULL) x1
      GROUP BY 1,2,3) x2
      GROUP BY 1,2
        ;;
    #persist_for: "24 hours"
    #indexes: ["transaction_number","invoice_number"]
    }

    view_label: "HUB"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.product_environment_id||${TABLE}.product_type ;;
    hidden: yes
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension: product_type {
    type: string
    sql: CASE WHEN ${TABLE}.product_type = 'happy_insights' THEN 'Insights' WHEN ${TABLE}.product_type = 'happy_tasks' THEN 'Happy Tasks'  WHEN ${TABLE}.product_type = 'happy_inspector'  THEN 'Happy Inspector' ELSE NULL END ;;
    hidden: yes
  }

    dimension:price_per_unit_dimension {
      type: number
      sql: ${TABLE}.price_per_unit ;;
      hidden: yes
      #value_format: "$#,##0;($#,##0)"
      group_label: "Revenue"
    }

  dimension:unit_quantity_dimension {
    type: number
    sql: ${TABLE}.unit_quantity ;;
    hidden: yes
  }

  measure: price_per_unit {
    type: average
    sql: ${price_per_unit_dimension} ;;
    value_format: "$0.00;($0.00)"
    group_label: "Revenue"
  }

  measure: unit_quantity {
    label: "Units Ordered"
    type: sum
    sql: NULLIF(${unit_quantity_dimension},0) ;;
    group_label: "Revenue"
  }
  }
