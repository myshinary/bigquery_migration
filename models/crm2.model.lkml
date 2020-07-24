connection: "bq_internal_systems"

label: "CRM"

include: "/views/real_properties/*.lkml"
include: "/views/aln/*.lkml"
include: "/views/bi/*.lkml"
include: "/views/identities/*.lkml"
include: "/views/saas_optics/*.lkml"
include: "/views/property_provisioning/*.lkml"
include: "/views/orders/*.lkml"
include: "/views/reporting/*.lkml"

explore: segmentation {
  from: properties
  view_name: properties
  label: "Segmentation [beta.2]"
  persist_for: "24 hour"

  #sql_always_where: ${aln.apartments.status_id} != 15
  #  ;;

  join: aln_mappings {
    sql_on: ${properties.id} = ${aln_mappings.property_id};;
    relationship: one_to_many
    type: left_outer
  }

  join: apartments {
    sql_on: ${aln_mappings.aln_apartment_id} = ${apartments.id};;
    relationship: many_to_one
    type: left_outer
  }

  join: management_companies {
    sql_on: ${apartments.management_company_id} = ${management_companies.id} ;;
    relationship: many_to_many
    type: left_outer
  }

  join: property_type {
    sql_on: ${apartments.id} = ${property_type.id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: apartments_main_property_type {
    sql_on: ${management_companies.id} = ${apartments_main_property_type.management_company_id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: orders {
    sql_on: ${properties.id} = ${orders.real_property_id} ;;
    relationship: many_to_one
    type: left_outer
  }

  join: properties_order_line_items {
    sql_on: ${orders.properties_order_id} = ${properties_order_line_items.properties_order_id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: property_provisioning_plans {
    sql_on: ${properties_order_line_items.properties_plan_id} = ${property_provisioning_plans.plan_id} ;;
    relationship: many_to_one
    type: left_outer
  }

  join: product_environments {
    sql_on: ${orders.product_environment_id} = ${product_environments.id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: customers {
    sql_on: ${product_environments.customer_id} = ${customers.id} ;;
    relationship: one_to_one
    type: left_outer
  }

  #removing because it shows MRR at the customer level, not the property level as intended
  #join: current_mrr {
  #  sql_on: ${customers.saasoptics_id} = ${current_mrr.customer} ;;
  #  relationship: one_to_many
  #  type: left_outer
  #}

  join: in_house_maintenance {
    sql_on: ${management_companies.id} = ${in_house_maintenance.id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: price_per_unit_by_property {
    sql_on: (${properties.id} = ${price_per_unit_by_property.id}) ;;
    relationship: one_to_one
    type: left_outer
  }

  join: aln_units_under_management {
    sql_on: ${management_companies.id} = ${aln_units_under_management.management_company_id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: business_mapping {
    sql_on: ${management_companies.id} = ${business_mapping.aln_id} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: apartment_pms {
    sql_on: ${apartments.id} = ${apartment_pms.aln_apartment_id} ;;
    relationship: one_to_one
    type: left_outer
  }
}

explore: hub_customers {
  from: customers
  view_name: customers
  label: "HUB Customers"
  persist_for: "24 hour"
  description: "Which customers have what product(s), how much do they pay, who's assigned to their account(s), and what have they been tagged with"
  fields: [ALL_FIELDS*, -customers.hub_customer_link]

  #sql_always_where: ${aln.apartments.status_id} != 15
  #  ;;

  join: finance_normalized_line_items {
    sql_on: ${customers.saasoptics_id} = ${finance_normalized_line_items.so_customer_id};;
    relationship: one_to_many
    type: left_outer
  }

  join: customer_owners {
    sql_on: ${customers.id} = ${customer_owners.customer_id};;
    relationship: one_to_many
    type: left_outer
  }

  join: customer_tags {
    sql_on: ${customers.id} = ${customer_tags.customer_id};;
    relationship: one_to_many
    type: left_outer
  }

  join: product_environments {
    sql_on: ${customers.id} = ${product_environments.customer_id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: property_provisioning_active_counts {
    sql_on: ${product_environments.id} = ${property_provisioning_active_counts.product_environment_id};;
    relationship: one_to_many
    type: left_outer
  }

  join: product_environment_feature_flags_and_status {
    sql_on: ${product_environments.id} = ${product_environment_feature_flags_and_status.product_environment_id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: customer_current_overall_risks {
    sql_on: ${customers.id} = ${customer_current_overall_risks.customer_id};;
    relationship: one_to_one
    type: left_outer
  }

  join: approximate_transaction_renewals {
    sql_on: ${customers.saasoptics_id} = ${approximate_transaction_renewals.so_customer_id};;
    relationship: one_to_one
    type: left_outer
  }

}
