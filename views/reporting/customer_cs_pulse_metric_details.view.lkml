view: customer_cs_pulse_metric_details {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_cs_pulse_metric_details`
    ;;
  drill_fields: [id]

  view_label: "HUB"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: calendar_week_number {
    label: "Week Number"
    type: number
    sql: ${TABLE}.calendar_week_number ;;
    group_label: "CS"
    description: "Used for Pulse Metrics Reporting"
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
    hidden: yes
  }

  dimension: employee_email {
    type: string
    sql: ${TABLE}.employee_email ;;
    group_label: "CS"
  }

  dimension: employee_id {
    type: number
    sql: ${TABLE}.employee_id ;;
    hidden: yes
  }

  dimension: employee_name {
    type: string
    sql: ${TABLE}.employee_name ;;
    group_label: "CS"
  }

  dimension: four_week_group_number {
    label: "Week Group Number"
    type: number
    sql: ${TABLE}.four_week_group_number ;;
    group_label: "CS"
    description: "Number of week per every 4 weeks, used for Pulse Metrics Reporting"
  }

  dimension: start_of_week {
    label: "Week"
    type: date
    convert_tz: no
    datatype: date
    sql: ${TABLE}.start_of_week ;;
    group_label: "CS"
    description: "Used for Pulse Metrics Reporting"
  }

  #measure: count {
  #  type: count
  #  drill_fields: [id, employee_name, customer_name]
  #}
}
