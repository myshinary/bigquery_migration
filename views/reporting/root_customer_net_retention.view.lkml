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
      SELECT date, parent_id, mrr, mrr_segment_by_start,
      CASE WHEN max_mrr < 500 THEN '1. <$500' WHEN max_mrr BETWEEN 500 AND 3000 THEN '2. $500-$3,000' ELSE '3. >$3,000' END as mrr_segment_by_max
      FROM
      (SELECT date, parent_id, mrr, MAX(mrr) OVER (PARTITION BY parent_id) as max_mrr,
      CASE WHEN mrr < 500 THEN '1. <$500' WHEN mrr BETWEEN 500 AND 3000 THEN '2. $500-$3,000' ELSE '3. >$3,000' END as mrr_segment_by_start
      FROM
      (SELECT date, parent_id, SUM(daily_mrr) as mrr
      FROM ${daily_mrr_by_customer_product.SQL_TABLE_NAME}
      WHERE {% condition products %} product {% endcondition %}
      GROUP BY 1,2) x) x2
      ),

      find_start_and_end_mrr AS (
      SELECT date, date_past, customer_id, mrr_segment_by_start, mrr_segment_by_max,

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
      (SELECT c.date_current as date, c.date_past, c.customer_current as customer_id, mp.mrr_segment_by_start, mp.mrr_segment_by_max, mp.mrr as start_mrr, mc.mrr as end_mrr
      FROM connect_with_past c
      LEFT JOIN sum_mrr_to_parent mc
      ON (c.customer_current = mc.parent_id AND c.date_current = mc.date)
      LEFT JOIN sum_mrr_to_parent mp
      ON (c.customer_past = mp.parent_id AND c.date_past = mp.date)) x1
      WHERE start_mrr > 0
      AND date <= current_date
      ORDER BY 1
      ),

      find_date_frame AS (
      SELECT date_interval, MIN(date) as date
      FROM find_start_and_end_mrr
      GROUP BY 1
      )

      SELECT date, date_past, date_interval, customer_id, mrr_segment_by_start, mrr_segment_by_max, start_mrr, end_mrr
      FROM find_start_and_end_mrr
      WHERE date_interval IN (SELECT date_interval FROM find_date_frame)
      AND
        {% if root_customer_net_retention.date_year._in_query %}
        DATE_TRUNC(date,YEAR) = date
      {% elsif root_customer_net_retention.date_quarter._in_query %}
        DATE_TRUNC(date,QUARTER) = date
      {% elsif root_customer_net_retention.date_month._in_query %}
        DATE_TRUNC(date,MONTH) = date
      {% else %}
        1=1
      {% endif %}
      ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: start_mrr {
    type: number
    sql: ${TABLE}.start_mrr ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "MRR"
    label: "Start MRR"
    #hidden: yes
  }

  dimension: mrr_segment_by_max {
    label: "by Max MRR"
    type: string
    sql: ${TABLE}.mrr_segment_by_max ;;
    view_label: "Customer"
    group_label: "MRR Segment"
    description: "MRR amount at peak of Customer's Revenue"
  }

  dimension: mrr_segment_by_start {
    label: "by Start MRR"
    type: string
    sql: ${TABLE}.mrr_segment_by_start ;;
    view_label: "Customer"
    group_label: "MRR Segment"
    description: "MRR amount at start of Net Retention calculation"
  }

  dimension: end_mrr {
    type: number
    sql: ${TABLE}.end_mrr ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "MRR"
    label: "End MRR"
    hidden: yes
  }

  measure: net_retention {
    label: "Net Dollar Retention"
    type: number
    sql: SUM(${end_mrr})/SUM(${start_mrr}) ;;
    value_format: "0.0%"
    drill_fields: [customers.name,customers.hub_customer_link,start_mrr,end_mrr,net_retention]
  }

  measure: mrr {
    label: "MRR"
    type: sum
    sql: ${end_mrr} ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "MRR"
    drill_fields: [customers.name,customers.hub_customer_link,start_mrr,end_mrr,net_retention]
  }

  measure: mrr_previous {
    label: "Previous MRR"
    type: sum
    sql: ${start_mrr} ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "MRR"
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

  dimension: date_past {
    type: date
    convert_tz: no
    sql: ${TABLE}.date_past ;;
    hidden: yes
  }

  dimension: id {
    type: string
    sql: ${customer_id}||${date_date} ;;
    hidden: yes
    primary_key: yes
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
