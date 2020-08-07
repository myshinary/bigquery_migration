view: root_customer_net_retention {
  view_label: "Retention"
  derived_table: {
    sql:

    WITH customer_active_dates AS (
      SELECT root_so_customer_id, MIN(original_started_on) start_date, MAX(original_ended_on) as end_date
      FROM ${finance_normalized_line_items.SQL_TABLE_NAME}
      WHERE is_so_item_recurring
      AND {% condition products %} product_group_name {% endcondition %}
      GROUP BY 1
      ),

      date_arrays AS (
      SELECT root_so_customer_id, start_date, end_date, GENERATE_DATE_ARRAY(start_date, end_date, INTERVAL 1 DAY) as dates
      --FROM net_customer_list
      FROM customer_active_dates
      ),

      unnest_date_arrays AS (
      SELECT date, DATE_TRUNC(DATE_ADD(date, INTERVAL 1 {% parameter interval %}),DAY) as future_date, root_so_customer_id
      FROM date_arrays, UNNEST(dates) as date
      ),

      connect_with_past AS (
      SELECT x.date as date_past, y.date as date_current, y.root_so_customer_id as customer_current, x.root_so_customer_id as customer_past
      FROM unnest_date_arrays x
      LEFT JOIN unnest_date_arrays y
      ON (x.future_date = y.date AND x.root_so_customer_id = y.root_so_customer_id)
      ),

      sum_mrr_to_parent AS (
      SELECT date, parent_id, SUM(daily_mrr) as mrr
      FROM ${daily_mrr_by_customer_product.SQL_TABLE_NAME}
      WHERE {% condition products %} product {% endcondition %}
      GROUP BY 1,2
      ),

      find_start_and_end_mrr AS (
      SELECT date,

      {% if root_customer_net_retention.date_year._in_query %}
        DATE_TRUNC(date,YEAR) as date_interval,
      {% elsif root_customer_net_retention.date_quarter._in_query %}
        DATE_TRUNC(date,QUARTER) as date_interval,
      {% elsif root_customer_net_retention.date_month._in_query %}
        DATE_TRUNC(date,MONTH) as date_interval,
      {% else %}
        date as date_interval,
      {% endif %}

      start_mrr, end_mrr
      FROM
      (SELECT c.date_current as date, SUM(mp.mrr) as start_mrr, SUM(mc.mrr) as end_mrr
      FROM connect_with_past c
      LEFT JOIN sum_mrr_to_parent mc
      ON (c.customer_current = mc.parent_id AND c.date_current = mc.date)
      LEFT JOIN sum_mrr_to_parent mp
      ON (c.customer_past = mp.parent_id AND c.date_past = mp.date)
      GROUP BY 1) x1
      WHERE start_mrr > 0
      AND date <= current_date
      ORDER BY 1
      ),

      find_date_frame AS (
      SELECT date_interval, MIN(date) as date
      FROM find_start_and_end_mrr
      GROUP BY 1
      )

      SELECT date, date_interval, start_mrr, end_mrr
      FROM find_start_and_end_mrr
      WHERE date IN (SELECT date FROM find_date_frame)
      ;;
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
    hidden: yes
  }

  dimension: end_mrr {
    type: number
    sql: ${TABLE}.end_mrr ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "MRR"
    hidden: yes
  }

  dimension: net_retention_dimension {
    label: "Net Dollar Retention"
    type: number
    sql: ${end_mrr}/${start_mrr} ;;
    value_format: "0.00"
    hidden: yes
  }

  measure: mrr {
    label: "MRR"
    type: sum
    sql: ${end_mrr} ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "MRR"
  }

  measure: mrr_previous {
    label: "Previous MRR"
    type: sum
    sql: ${start_mrr} ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "MRR"
  }

  measure: net_retention {
    type: average
    sql: ${net_retention_dimension} ;;
    value_format: "0.00"
  }

  dimension_group: date {
    type: time
    timeframes: [
      date,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  parameter: interval {
    type: unquoted
    allowed_value: {
      label: "Annual"
      value: "YEAR"
    }
    allowed_value: {
      label: "Quarterly"
      value: "QUARTER"
    }
    allowed_value: {
      label: "Monthly"
      value: "Month"
    }
    default_value: "YEAR"
  }

  parameter: products {
    type: unquoted
    allowed_value: {
      label: "Inspector"
      value: "Happy Inspector"
    }
    allowed_value: {
      label: "Tasks"
      value: "Happy Tasks"
    }
    allowed_value: {
      label: "Insights"
      value: "Insights"
    }
    allowed_value: {
      label: "Optigo"
      value: "Optigo"
    }
    allowed_value: {
      label: "Subscription"
      value: "DD Subscription"
    }
  }

}
