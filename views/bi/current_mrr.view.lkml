view: current_mrr {
view_label: "MRR"
  derived_table: {
    sql:
    SELECT date, CONCAT(customer,product) as unique, parent_id, customer, product, SUM(daily_mrr) as mrr
    FROM ${daily_mrr_by_customer_product.SQL_TABLE_NAME}
    WHERE date = current_date
    GROUP BY 1,2,3,4,5 ;;
  }

  dimension: unique {
    type: string
    sql: ${TABLE}.unique ;;
    primary_key: yes
    hidden: yes
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.customer ;;
    hidden: yes
  }

  dimension: parent {
    type: string
    sql: ${TABLE}.parent_id ;;
    hidden: yes
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
  }

  dimension: mrr_dimension {
    type: number
    sql: ${TABLE}.mrr ;;
    hidden: yes
  }

  measure: mrr {
    type: sum
    sql: ${mrr_dimension} ;;
    label: "Current MRR"
    value_format: "$#,##0;($#,##0)"
  }

}
