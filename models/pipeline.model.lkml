connection: "bq_internal_systems"

include: "/views/real_properties/*.lkml"
include: "/views/aln/*.lkml"
include: "/views/bi/*.lkml"
include: "/views/due_diligence/*.lkml"
include: "/views/identities/*.lkml"
include: "/views/saas_optics/*.lkml"
include: "/views/property_provisioning/*.lkml"
include: "/views/orders/*.lkml"
include: "/views/reporting/*.lkml"

#explore: prospect_opportunities {
#  from: prospect_opportunities
#  view_name: prospect_opportunities
#  label: "Opportunities"
#  #persist_for: "24 hour"
#
#  #sql_always_where: ${aln.apartments.status_id} != 15
#  #  ;;
#
#  join: prospect_opportunities_integrations {
#    sql_on: ${prospect_opportunities.id} = ${prospect_opportunities_integrations.opportunity_id};;
#    relationship: one_to_many
#    type: left_outer
#  }
#
#  join: prospect_opportunities_one_off_product_codes {
#    sql_on: ${prospect_opportunities.id} = ${prospect_opportunities_one_off_product_codes.opportunity_id};;
#    relationship: one_to_many
#    type: left_outer
#  }
#
#  join: prospect_opportunities_reasons_for_buying {
#    sql_on: ${prospect_opportunities.id} = ${prospect_opportunities_reasons_for_buying.opportunity_id};;
#    relationship: one_to_many
#    type: left_outer
#  }
#
#  join: prospect_opportunities_recurring_product_codes {
#    sql_on: ${prospect_opportunities.id} = ${prospect_opportunities_recurring_product_codes.opportunity_id};;
#    relationship: one_to_many
#    type: left_outer
#  }
#
#}
#
#explore: prospect_historical_opportunities {
#  from: prospect_daily_pipeline_data
#  view_name: prospect_daily_pipeline_data
#  label: "Historical Opportunities"
#  #persist_for: "24 hour"
#
#  #sql_always_where: ${aln.apartments.status_id} != 15
#  #  ;;
#
#  join: prospect_opportunities {
#    sql_on: ${prospect_daily_pipeline_data.opportunity_id} = ${prospect_opportunities.opportunity_id} ;;
#    relationship: many_to_one
#    type: inner
#  }
#
#  join: customers {
#    sql_on: ${prospect_daily_pipeline_data.account_id} = ${customers.salesforce_id} ;;
#    relationship: many_to_one
#    type: left_outer
#  }
#
#  join: finance_normalized_line_items {
#    sql_on: ${customers.saasoptics_id} = ${finance_normalized_line_items.root_so_customer_id};;
#    relationship: one_to_many
#    type: left_outer
#  }
#
#}
#
