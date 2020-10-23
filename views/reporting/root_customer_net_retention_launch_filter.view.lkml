view: root_customer_net_retention_launch_filter {
view_label: "Customer"
  derived_table: {
    sql:

    WITH full_list AS (
      SELECT customers.saasoptics_id as customer_id, orders.id, DATE_TRUNC(CAST(activated_at AS DATE), MONTH) as activated_month, DATE_TRUNC(CAST(deactivated_at AS DATE), MONTH) as deactivated_month
      FROM `happyco-internal-systems.hub__identities.customers` customers
      JOIN ${product_environments.SQL_TABLE_NAME} product_environments
      ON customers.id = product_environments.customer_id
      JOIN ${orders.SQL_TABLE_NAME} orders
      ON product_environments.id = orders.product_environment_id
      ),

      date_arrays AS (
      SELECT customer_id, GENERATE_DATE_ARRAY(start_date, date_range_end, INTERVAL 1 MONTH) as months
      FROM
      (SELECT customer_id, start_date, end_date, CASE WHEN end_date < current_date THEN (CASE WHEN DATE_ADD(end_date,INTERVAL 1 YEAR) > current_date THEN current_date ELSE DATE_ADD(end_date,INTERVAL 1 YEAR) END) ELSE end_date END as date_range_end
      FROM
      (SELECT customer_id, CAST(current_date AS DATE) as end_date, MIN(activated_month) as start_date
      FROM full_list
      GROUP BY 1,2) x) x2
      ),

      unnest_date_arrays AS (
      SELECT customer_id, month
      FROM date_arrays, UNNEST(months) as month
      ),

      find_activation_coverage AS (
      SELECT customer_id, month, activated_properties, deactivated_properties, active_properties, total_deactivated_properties, max_active_properties, active_properties/NULLIF(max_active_properties,0) as activation, DATE_DIFF(month,activated_month,MONTH) as age_in_months
      FROM
      (SELECT customer_id, month, activated_properties, deactivated_properties, active_properties, total_deactivated_properties, MAX(active_properties) OVER (PARTITION BY customer_id) as max_active_properties, MIN(month) OVER (PARTITION BY customer_id) as activated_month
      FROM
      (SELECT customer_id, month, activated_properties, deactivated_properties, active_properties-total_deactivated_properties as active_properties, total_deactivated_properties
      FROM
      (SELECT customer_id, month, activated_properties, deactivated_properties, SUM(activated_properties) OVER (PARTITION BY customer_id ORDER BY month) as active_properties, SUM(deactivated_properties) OVER (PARTITION BY customer_id ORDER BY month) as total_deactivated_properties
      FROM
      (SELECT unnest_date_arrays.customer_id, unnest_date_arrays.month, COUNT(DISTINCT ap.id) as activated_properties, COUNT(DISTINCT dp.id) as deactivated_properties
      FROM unnest_date_arrays
      LEFT JOIN full_list ap
      ON (unnest_date_arrays.customer_id = ap.customer_id AND unnest_date_arrays.month = ap.activated_month)
      LEFT JOIN full_list dp
      ON (unnest_date_arrays.customer_id = dp.customer_id AND unnest_date_arrays.month = dp.deactivated_month)
      GROUP BY 1,2) x) x2) x3) x4
      )

      SELECT  customer_id, MIN(month) as launched
      FROM find_activation_coverage
      WHERE {% condition portfolio_launched %} activation*100 {% endcondition %}
      AND {% condition age_in_months %} age_in_months {% endcondition %}
      /*insert parameter here for launch coverage minimum and age limit if necessary*/
      GROUP BY 1
      ;;
  }

  dimension: customer_id {
     type: string
     sql: ${TABLE}.customer_id ;;
    primary_key: yes
     hidden: yes
   }

  dimension: launched {
    type: date
    convert_tz: no
    sql: ${TABLE}.launched ;;
    hidden: yes
  }

  filter: portfolio_launched {
    type: number
    label: "Percent of Portfolio Launched"
    description: "percent of highest number of active properties activated"
  }

  filter: age_in_months {
    type: number
  }

}
