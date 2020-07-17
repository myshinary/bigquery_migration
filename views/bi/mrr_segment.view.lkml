view: mrr_segment {
  derived_table: {
    sql:
    SELECT parent_id, CASE WHEN max_daily_mrr >=3000 THEN '1. > $3,000' WHEN (max_daily_mrr < 3000 AND max_daily_mrr >= 500) THEN '2. $500 - $2,999' WHEN max_daily_mrr < 500 THEN '3. < $499' ELSE 'unknown' END as segment
    FROM
    (SELECT parent_id, MAX(daily_mrr) as max_daily_mrr
    FROM
    (SELECT parent_id, date, SUM(daily_mrr) as daily_mrr
    FROM ${daily_mrr_by_customer_product.SQL_TABLE_NAME}
    GROUP BY 1,2) x
    GROUP BY 1) x2;;
  #persist_for: "24 hours"
  #indexes: ["transaction_number","invoice_number"]
    }

  dimension: parent_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.parent_id ;;
    hidden: yes
  }

  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
    view_label: "MRR"
  }
}
