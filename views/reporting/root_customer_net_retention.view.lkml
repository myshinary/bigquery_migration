view: root_customer_net_retention {
  view_label: "Retention"
  derived_table: {
    sql:
    WITH customer_active_dates AS (
      SELECT root_so_customer_id, MIN(original_started_on) first_started_on, MAX(original_ended_on) as last_ended_on
      FROM ${finance_normalized_line_items.SQL_TABLE_NAME}
      WHERE is_so_item_recurring
      --AND product_group_name = 'Happy Inspector'
      GROUP BY 1
      ),

      net_customer_list AS (
      SELECT root_so_customer_id, CAST({% parameter start_date %} AS DATE) as start_date, CAST({% parameter end_date %} AS DATE) as end_date
      FROM customer_active_dates
      WHERE (first_started_on <= CAST({% parameter start_date %} AS DATE) AND last_ended_on >= CAST({% parameter end_date %} AS DATE))
      ),

      start_mrr AS (
      SELECT SUM(daily_mrr) as mrr
      FROM ${daily_mrr_by_customer_product.SQL_TABLE_NAME}
      WHERE date = (SELECT DISTINCT start_date FROM net_customer_list)
      AND parent_id IN (SELECT root_so_customer_id FROM net_customer_list)
      )

      SELECT (SELECT mrr FROM start_mrr) as start_mrr, SUM(daily_mrr) end_mrr
      FROM bi.daily_mrr_by_customer_product
      WHERE date = (SELECT DISTINCT end_date FROM net_customer_list)
      AND parent_id IN (SELECT root_so_customer_id FROM net_customer_list);;
  }

  dimension: root_so_customer_id {
    type: string
    sql: ${TABLE}.root_so_customer_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: start_mrr {
    type: number
    sql: ${TABLE}.start_mrr ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "MRR"
  }

  dimension: end_mrr {
    type: number
    sql: ${TABLE}.end_mrr ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "MRR"
  }

  dimension: net_retention {
    label: "Net Dollar Retention"
    type: number
    sql: ${end_mrr}/${start_mrr} ;;
    value_format: "0.00"
    description: "Use Start and End date Filters"
  }

  parameter: start_date {
    type: date
    group_label: "Date Range"
    default_value: "2019-01-01"
  }

  parameter: end_date {
    type: date
    group_label: "Date Range"
    default_value: "2020-01-01"
  }

}
