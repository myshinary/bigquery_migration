view: approximate_transaction_renewals {
  derived_table: {
    sql:
    WITH step_1 AS (
    SELECT hub_customer_id as customer_id, so_customer_id, CASE WHEN original_ended_on > current_date THEN CAST(original_ended_on AS DATE) ELSE NULL END as original_ended_on
    FROM ${finance_normalized_line_items.SQL_TABLE_NAME}
    WHERE is_so_item_recurring
    ),

    so_count AS (
    SELECT customer_id, so_customer_id, original_ended_on, COUNT(0) as occurence
    FROM step_1
    GROUP BY 1,2,3
    ),

    cust_count AS (
    SELECT customer_id, original_ended_on, COUNT(0) as occurence
    FROM step_1
    GROUP BY 1,2
    ),

    so_occ AS (
    SELECT customer_id, so_customer_id, original_ended_on, occurence, ROW_NUMBER() OVER (PARTITION BY customer_id, so_customer_id ORDER BY occurence DESC) as most_occ
    FROM so_count
    WHERE original_ended_on IS NOT NULL
    ),

    cust_occ AS (
    SELECT customer_id, original_ended_on, occurence, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY occurence DESC) as most_occ
    FROM cust_count
    WHERE original_ended_on IS NOT NULL
    ),

    so_renewal AS (
    SELECT customer_id, so_customer_id, SUM(occurence) as occurence, CAST(MIN(original_ended_on) AS DATE) as approx_txn_renewal_date
    FROM so_occ
    WHERE most_occ = 1
    GROUP BY 1,2
    ),

    cust_renewal AS (
    SELECT customer_id, SUM(occurence) as occurence, CAST(MIN(original_ended_on) AS DATE) as approx_txn_renewal_date
    FROM cust_occ
    WHERE most_occ = 1
    GROUP BY 1
    )

    SELECT COALESCE(so_renewal.customer_id,cust_renewal.customer_id) as customer_id, so_renewal.so_customer_id, so_renewal.approx_txn_renewal_date, cust_renewal.approx_txn_renewal_date as parent_approx_txn_renewal_date
    FROM so_renewal
    FULL OUTER JOIN cust_renewal
    ON so_renewal.customer_id = cust_renewal.customer_id ;;
  }

  view_label: "HUB"

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: so_customer_id {
    type: number
    sql: ${TABLE}.so_customer_id ;;
    hidden: yes
  }

  dimension_group: approx_txn_renewal_customer {
    type: time
    sql: ${TABLE}.approx_txn_renewal_date ;;
    timeframes: [
          date,
          week,
          month,
          quarter,
          year
        ]
    datatype: date
    convert_tz: no
    description: "By combining the most common transaction renewal date and the soonest date when there's more than one result, we can approximate the Renewal Date for the Child Customer"
  }

  dimension_group: approx_txn_renewal_parent {
    type: time
    sql: ${TABLE}.parent_approx_txn_renewal_date ;;
    timeframes: [
          date,
          week,
          month,
          quarter,
          year
        ]
    datatype: date
    convert_tz: no
    description: "By combining the most common transaction renewal date and the soonest date when there's more than one result, we can approximate the Renewal Date for the Parent Customer"
  }

  #dimension_group: approximate_renewal {
  #  type: time
  #  timeframes: [
  #    date,
  #    week,
  #    month,
  #    quarter,
  #    year
  #  ]
  #  convert_tz: no
  #  datatype: date
  #  sql: ${approximate_transaction_renewal_date} ;;
  #}

}
