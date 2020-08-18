view: fnli_current_mrr_by_root_so_customer {
  #view_label: "HUB"
  derived_table: {
    sql:
    SELECT root_so_customer_id, SUM(CASE WHEN (current_date >= original_started_on AND current_date <=  original_ended_on) THEN (CASE WHEN is_so_item_recurring THEN monthly_normalized_amount_cents/100 ELSE NULL END) ELSE NULL END) as current_mrr
    FROM ${finance_normalized_line_items.SQL_TABLE_NAME}
    GROUP BY 1 ;;
  }

  dimension: root_so_customer_id {
    type: string
    sql: ${TABLE}.root_so_customer_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: current_mrr_by_parent {
    type: number
    sql: ${TABLE}.current_mrr ;;
    hidden: yes
  }
}
