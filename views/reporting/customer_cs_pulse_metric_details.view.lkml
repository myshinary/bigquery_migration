view: customer_cs_pulse_metric_details {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_cs_pulse_metric_details`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: calendar_week_number {
    type: number
    sql: ${TABLE}.calendar_week_number ;;
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
  }

  dimension: employee_id {
    type: number
    sql: ${TABLE}.employee_id ;;
    hidden: yes
  }

  dimension: employee_name {
    type: string
    sql: ${TABLE}.employee_name ;;
  }

  dimension: four_week_group_number {
    type: number
    sql: ${TABLE}.four_week_group_number ;;
  }

  dimension_group: start_of_week {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.start_of_week ;;
  }

  measure: count {
    type: count
    drill_fields: [id, employee_name, customer_name]
  }
}
