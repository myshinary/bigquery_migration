view: apartment_pms {
  sql_table_name: `happyco-internal-systems.hub__aln_data.apartment_pms`
    ;;

    view_label: "ALN Apartment"

  dimension: aln_apartment_id {
    type: string
    sql: ${TABLE}.aln_apartment_id ;;
    hidden: yes
  }

  dimension: property_management_software {
    type: string
    sql: ${TABLE}.property_management_software ;;
    hidden: yes
  }

  dimension: pms_group {
    label: "Property Management Software"
    type: string
    sql: ${TABLE}.pms_group ;;
  }

  #measure: count {
  #  type: count
  #  drill_fields: []
  #}
}
