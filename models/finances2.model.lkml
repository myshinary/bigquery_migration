connection: "bq_internal_systems"

# include all the views
include: "/views/**/*.view"

datagroup: bigquery_migration_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: bigquery_migration_default_datagroup

explore: mrr {
  label: "MRR"
  from: daily_mrr_by_customer_product
  view_name: daily_mrr_by_customer_product
  always_filter: {
    filters: {
      field: daily_mrr_by_customer_product.date_date
      value: "before today"
    }
  }

  join: customers {
    sql_on: ${daily_mrr_by_customer_product.parent_id} = ${customers.saasoptics_id} ;;
    relationship: many_to_one
    type: left_outer
  }

  join: mrr_segment {
    sql_on: ${daily_mrr_by_customer_product.parent_id} = ${mrr_segment.parent_id} ;;
    relationship: many_to_one
    type: left_outer
  }

}

explore: transactions {
  label: "Transactions"
  from: daily_revenue_by_customer_product
  view_name: daily_revenue_by_customer_product
  always_filter: {
    filters: {
      field: daily_revenue_by_customer_product.date_date
      value: "before today"
    }
  }

    join: customers {
      sql_on: ${daily_revenue_by_customer_product.customer_id} = ${customers.saasoptics_id} ;;
      relationship: many_to_one
      type: left_outer
    }

  #join: saasoptics_customer_private_data {
  #  sql_on: ${saasoptics_customers.id} = ${saasoptics_customer_private_data.id} ;;
  #  relationship: one_to_one
  #  type: left_outer
  #}

  #join: saasoptics_contracts {
  #  sql_on: ${saasoptics_customers.id} = ${saasoptics_contracts.customer} ;;
  #  relationship: many_to_one
  #  type: left_outer
  #}
  #
  #join: saasoptics_transactions {
  #  sql_on: ${saasoptics_revenue.transaction_id} = ${saasoptics_transactions.id} ;;
  #  relationship: one_to_one
  #  type: left_outer
  #}
  #
  #join: saasoptics_invoice_line_items {
  #  sql_on: ${saasoptics_transactions.id} = ${saasoptics_invoice_line_items.transaction} ;;
  #  relationship: one_to_one
  #  type: left_outer
  #}
  #join: saasoptics_invoices {
  #  sql_on: ${saasoptics_invoices.id} = ${saasoptics_invoice_line_items.invoice} ;;
  #  relationship: many_to_one
  #  type: left_outer
  #}
}

#explore: daily_revenue_by_customer_product {}
