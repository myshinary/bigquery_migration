connection: "bq_internal_systems"

label: "CRM"

include: "/views/real_properties/*.lkml"
include: "/views/aln/*.lkml"
include: "/views/bi/*.lkml"
include: "/views/due_diligence/*.lkml"
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

  join: aln_management_company_id_correction {
    sql_on: ${apartments.id} = ${aln_management_company_id_correction.aln_apartment_id} ;;
    relationship: many_to_many
    type: left_outer
  }

  join: management_companies {
    sql_on: ${aln_management_company_id_correction.correct_management_company_id} = ${management_companies.id} ;;
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

  join: management_company_main_property_class {
    sql_on: ${management_companies.id} = ${management_company_main_property_class.management_company_id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: management_company_main_pms {
    sql_on: ${management_companies.id} = ${management_company_main_pms.management_company_id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: dd_orders {
    sql_on: (${properties.id} = ${dd_orders.real_property_id}) ;;
    relationship: one_to_one
    type: left_outer
  }

  join: due_diligence_fulfilled_orders_amount {
    sql_on: ${properties.id} = ${due_diligence_fulfilled_orders_amount.real_property_id} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: management_company_main_management_type {
    sql_on: ${management_companies.id} = ${management_company_main_management_type.management_company_id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: management_company_percent_multi_family {
    sql_on: ${management_companies.id} = ${management_company_percent_multi_family.management_company_id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: customer_nps_responses {
    sql_on: ${customers.id} = ${customer_nps_responses.customer_id} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: customer_current_risk_segmentation_view {
    sql_on: ${customers.id} = ${customer_current_risk_segmentation_view.customer_id};;
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
  fields: [ALL_FIELDS*]

  #sql_always_where: ${aln.apartments.status_id} != 15
  #  ;;

  join: customer_ancestry {
    sql_on: ${customers.id} = ${customer_ancestry.root_id};;
    relationship: one_to_many
    type: left_outer
  }


  join: finance_normalized_line_items {
    sql_on: ${customers.saasoptics_id} = ${finance_normalized_line_items.root_so_customer_id};;
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

  join: customer_jira_issues {
    sql_on: ${customers.id} = ${customer_jira_issues.root_customer_id} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: product_environments {
    sql_on: ${customer_ancestry.id} = ${product_environments.customer_id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: due_diligence_fullfilled_orders {
    sql_on: ${product_environments.id} = ${due_diligence_fullfilled_orders.product_environment_id} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: property_provisioning_active_counts {
    sql_on: ${product_environments.id} = ${property_provisioning_active_counts.product_environment_id};;
    relationship: one_to_many
    type: left_outer
  }

  join: product_environment_features_enabled {
    sql_on: ${product_environments.id} = ${product_environment_features_enabled.product_environment_id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: customer_current_overall_risks {
    sql_on: ${customers.id} = ${customer_current_overall_risks.customer_id};;
    relationship: one_to_one
    type: left_outer
  }

  join: customer_cs_pulse_metric_details {
    sql_on: ${customers.id} = ${customer_cs_pulse_metric_details.customer_id};;
    relationship: one_to_many
    type: left_outer
  }

  join: approximate_transaction_renewals {
    sql_on: ${customers.saasoptics_id} = ${approximate_transaction_renewals.so_customer_id};;
    relationship: one_to_one
    type: left_outer
  }

  join: fnli_current_mrr_by_root_so_customer {
    sql_on: ${customers.saasoptics_id} = ${fnli_current_mrr_by_root_so_customer.root_so_customer_id};;
    relationship: one_to_many
    type: left_outer
  }

  join: product_environment_nps_responses {
    sql_on: ${product_environments.id} = ${product_environment_nps_responses.product_environment_id} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: property_provisioning_active_counts_by_product_enivronment {
    sql_on: ${product_environments.id} = ${property_provisioning_active_counts_by_product_enivronment.product_environment_id} ;;
    relationship: one_to_many
    type: left_outer
  }

  #join: price_per_unit_by_product_environment {
  #  sql_on: (${product_environments.id} = ${price_per_unit_by_product_environment.product_environment_id} AND ${finance_normalized_line_items.product_group_name} = ${price_per_unit_by_product_environment.product_type}) ;;
  #  relationship: many_to_one
  #  type: left_outer
  #escaped until I can figure out proper ppu....
  #}

}
