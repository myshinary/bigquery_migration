view: customer_current_overall_risks {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_current_overall_risks`
    ;;

    view_label: "HUB"
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: overall_risk {
    label: "Current Risk Score"
    type: number
    sql: ${TABLE}.overall_risk ;;

  }

  #measure: count {
  #  type: count
  #  drill_fields: [id]
  #}
}
