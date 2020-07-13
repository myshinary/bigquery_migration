view: management_companies {
  sql_table_name: `happyco-internal-systems.hub__aln_data.management_companies`
    ;;
  view_label: "ALN"

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    group_label: "Management Company"
  }

  dimension: website {
    type: number
    sql: ${TABLE}.website ;;
    hidden: yes
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

  #measure: count {
  #  type: count
  #  drill_fields: [
  #    name,
  #    aln_business_mapping.happy_co_business_id
  #  ]
  #}
}
