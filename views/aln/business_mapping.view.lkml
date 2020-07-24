view: business_mapping {
  sql_table_name: `happyco-internal-systems.hub__aln_data.business_mapping`
    ;;
    view_label: "ALN"

  dimension: aln_id {
    type: string
    sql: ${TABLE}.aln_id ;;
    hidden: yes
  }

  dimension: happy_co_business_id {
    type: number
    sql: ${TABLE}.happy_co_business_id ;;
    hidden: yes
  }

  measure: happy_co_business_ids {
    type: string
    sql: STRING_AGG(DISTINCT CAST(${happy_co_business_id} AS STRING),', ');;
    group_label: "Management Company"
  }

  #measure: count {
  #  type: count
  #  drill_fields: []
  #}
}
