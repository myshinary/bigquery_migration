view: management_companies {
  sql_table_name: `happyco-internal-systems.hub__aln_data.management_companies`
    ;;
  view_label: "ALN Management Company"

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: no
    label: "ID"
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    case_sensitive: no
  }

  dimension: website {
    type: number
    sql: ${TABLE}.website ;;
    hidden: no
  }

  dimension: market {
    type: string
    sql: ${TABLE}.market ;;
    hidden: yes
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}.parent_id ;;
    hidden: yes
  }

  dimension: row_version {
    type: string
    sql: ${TABLE}.row_version ;;
    hidden: yes
  }

  dimension: updated_at {
    type: string
    sql: ${TABLE}.updated_at ;;
    hidden: yes
  }

  dimension: in_house_maintenance {
    type: yesno
    sql:  CASE WHEN ${in_house_maintenance.id} IS NULL THEN FALSE ELSE TRUE END;;
    description: "Does the ALN-listed Company have any 'Maintenance' employees?"
  }

  dimension: has_happyco_account {
    type: yesno
    sql: CASE WHEN ${business_mapping.happy_co_business_id} IS NULL THEN FALSE ELSE TRUE END ;;
  }

  measure: count {
    type: count
    #drill_fields: [
    #  name,
    #  aln_business_mapping.happy_co_business_id
    #]
  }
}
