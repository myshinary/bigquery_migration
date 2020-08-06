connection: "bq_internal_systems"

label: "Metrics"

include: "/views/real_properties/*.lkml"
include: "/views/aln/*.lkml"
include: "/views/bi/*.lkml"
include: "/views/due_diligence/*.lkml"
include: "/views/identities/*.lkml"
include: "/views/saas_optics/*.lkml"
include: "/views/property_provisioning/*.lkml"
include: "/views/orders/*.lkml"
include: "/views/reporting/*.lkml"

explore: net_retention {
  from: root_customer_net_retention
  view_name: root_customer_net_retention
  label: "Net Dollar Retention"
  persist_for: "24 hour"
  #description: "Which customers have what product(s), how much do they pay, who's assigned to their account(s), and what have they been tagged with"
  fields: [ALL_FIELDS*]

  #sql_always_where: ${aln.apartments.status_id} != 15
  #  ;;
}
