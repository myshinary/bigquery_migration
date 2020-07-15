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

  join: properties_billed_on_unit_type {
    sql_on: ${orders.id} = ${properties_billed_on_unit_type.id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: in_house_maintenance {
    sql_on: ${management_companies.id} = ${in_house_maintenance.id} ;;
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

  #sql_always_where: ${aln.apartments.status_id} != 15
  #  ;;

  join: current_recurring_finance_normalized_line_items {
    sql_on: ${customers.id} = ${current_recurring_finance_normalized_line_items.hub_customer_id};;
    relationship: one_to_many
    type: left_outer
  }
}
