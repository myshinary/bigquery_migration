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

  join: product_environments {
    sql_on: ${customers.id} = ${product_environments.customer_id} ;;
    relationship: one_to_many
    type: left_outer
  }

  #join: price_per_unit_by_product_environment {
  #  sql_on: ${product_environments.id} = ${price_per_unit_by_product_environment.product_environment_id} ;;
  #  relationship: one_to_one
  #  type: left_outer
  #}

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
      sql_on: ${daily_revenue_by_customer_product.parent_id} = ${customers.saasoptics_id} ;;
      relationship: many_to_one
      type: left_outer
    }
}
