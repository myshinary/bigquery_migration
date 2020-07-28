view: customer_owners {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_owners`
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

  dimension_group: effective {
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
    sql: ${TABLE}.effective_on ;;
    hidden: yes
  }

  dimension_group: effective_until {
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
    sql: ${TABLE}.effective_until ;;
    hidden: yes
  }

  dimension: employee_email {
    type: string
    sql: ${TABLE}.employee_email ;;
    hidden: yes
  }

  dimension: employee_id {
    type: number
    sql: ${TABLE}.employee_id ;;
    hidden: yes
  }

  dimension: employee_name {
    type: string
    sql: ${TABLE}.employee_name ;;
    group_label: "Account Managers"
  }

  dimension: owner_type {
    label: "Employee Role"
    type: string
    sql: ${TABLE}.owner_type ;;
    group_label: "Account Managers"
  }

  #measure: count {
  #  type: count
  #  drill_fields: [id, employee_name]
  #}
}