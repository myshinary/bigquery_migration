view: property_provisioning_active_counts_by_product_enivronment {
  derived_table: {
    sql:
    WITH property_orders AS (
      SELECT product_environment_id, CAST(activated_at AS DATE) as activated, CAST(deactivated_at AS DATE) as deactivated, unit_quantity, 1 as counter
      FROM ${orders.SQL_TABLE_NAME}
      WHERE canceled_at IS NULL
      AND activated_at IS NOT NULL
      ),

      calendar AS (
      SELECT product_environment_id, date
      FROM
      (SELECT product_environment_id, GENERATE_DATE_ARRAY(start_,current_date(), INTERVAL 1 DAY) as dates
      FROM
      (SELECT product_environment_id, MIN(activated) as start_
      FROM property_orders
      GROUP BY 1) x1) x2, UNNEST(dates) as date
      )

      SELECT a.date, a.product_environment_id, a2.properties_activated, a2.units_activated, d2.properties_deactivated, d2.units_deactivated, a.properties_activated-d.properties_deactivated as active_properties, a.units_activated-d.units_deactivated as active_units
      FROM
      (SELECT c.date, c.product_environment_id, SUM(counter) as properties_activated, SUM(unit_quantity) as units_activated
      FROM calendar c
      LEFT JOIN property_orders a
      ON (c.product_environment_id = a.product_environment_id AND c.date >= a.activated)
      GROUP BY 1,2) a
      LEFT JOIN
      (SELECT c.date, c.product_environment_id, COALESCE(SUM(counter),0) as properties_deactivated, COALESCE(SUM(unit_quantity),0) as units_deactivated
      FROM calendar c
      LEFT JOIN property_orders d
      ON (c.product_environment_id = d.product_environment_id AND c.date >= d.deactivated)
      GROUP BY 1,2) d
      ON (a.product_environment_id = d.product_environment_id AND a.date = d.date)
      LEFT JOIN
      (SELECT c.date, c.product_environment_id, COALESCE(SUM(counter),0) as properties_activated, COALESCE(SUM(unit_quantity),0) as units_activated
      FROM calendar c
      LEFT JOIN property_orders d
      ON (c.product_environment_id = d.product_environment_id AND c.date = d.activated)
      GROUP BY 1,2) a2
      ON (a.product_environment_id = a2.product_environment_id AND a.date = a2.date)
      LEFT JOIN
      (SELECT c.date, c.product_environment_id, COALESCE(SUM(counter),0) as properties_deactivated, COALESCE(SUM(unit_quantity),0) as units_deactivated
      FROM calendar c
      LEFT JOIN property_orders d
      ON (c.product_environment_id = d.product_environment_id AND c.date = d.deactivated)
      GROUP BY 1,2) d2
      ON (a.product_environment_id = d2.product_environment_id AND a.date = d2.date)
    ;;
  }

  view_label: "Customer"

  dimension: product_environment_id {
    type: string
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension_group: date {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.date AS TIMESTAMP) ;;
  }

  dimension: id {
    type: string
    sql: CONCAT(CAST(${product_environment_id} AS STRING),CAST(${date_date} AS STRING)) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: properties_activated {
    type: number
    sql: ${TABLE}.properties_activated;;
    hidden: yes
  }

  dimension: units_activated {
    type: number
    sql: ${TABLE}.units_activated;;
    hidden: yes
  }

  dimension: properties_deactivated {
    type: number
    sql: ${TABLE}.properties_deactivated;;
    hidden: yes
  }

  dimension: units_deactivated {
    type: number
    sql: ${TABLE}.units_deactivated;;
    hidden: yes
  }

  dimension: daily_active_properties_dimension {
    type: number
    sql: ${TABLE}.active_properties;;
    hidden: yes
  }

  dimension: daily_active_units_dimension {
    type: number
    sql: ${TABLE}.active_units;;
    hidden: yes
  }

  measure: active_properties {
    type: sum
    sql: ${properties_activated}-${properties_deactivated} ;;
    hidden: no
    drill_fields: [date_date,daily_active_properties]
    group_label: "Activations"
  }

  measure: active_units {
    type: sum
    sql: ${units_activated}-${units_deactivated} ;;
    hidden: no
    drill_fields: [date_date,daily_active_properties]
    group_label: "Activations"
  }

  measure: daily_active_properties {
    type: sum
    sql: ${daily_active_properties_dimension} ;;
    hidden: no
    group_label: "Activations"
  }

  measure: daily_active_units {
    type: sum
    sql: ${daily_active_units_dimension} ;;
    hidden: no
    group_label: "Activations"
  }

  measure: properties_activated_sum {
    label: "Properties Activated"
    type: sum
    sql: ${properties_activated};;
    hidden: yes
    group_label: "Activations"
  }

  measure: units_activated_sum {
    label: "Units Activated"
    type: sum
    sql: ${units_activated};;
    hidden: yes
    group_label: "Activations"
  }

  measure: properties_deactivated_sum {
    label: "Properties Deactivated"
    type: sum
    sql: ${properties_deactivated};;
    hidden: no
    group_label: "Activations"
  }

  measure: units_deactivated_sum {
    label: "Units Deativated"
    type: sum
    sql: ${units_deactivated};;
    hidden: no
    group_label: "Activations"
  }

}
