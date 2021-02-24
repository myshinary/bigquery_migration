view: product_environment_thinkific_enrollments {
  sql_table_name: `happyco-internal-systems.hub__reporting.product_environment_thinkific_enrollments`
    ;;
  drill_fields: [id]

  view_label: "HappyCo U"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension_group: completed {
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
    sql: ${TABLE}.completed_at ;;
  }

  dimension: course_id {
    type: number
    sql: ${TABLE}.course_id ;;
    hidden: yes
  }

  dimension: course_name {
    type: string
    sql: ${TABLE}.course_name ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: is_complete {
    type: yesno
    sql: ${TABLE}.is_complete ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: percentage_completed {
    type: number
    sql: ${TABLE}.percentage_completed ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension_group: started {
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
    sql: ${TABLE}.started_at ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, course_name, last_name, first_name, started_date]
    label: "Total Course Enrollments"
    hidden: yes
  }

  measure: count_users {
    type: count_distinct
    sql: ${user_id} ;;
    sql_distinct_key: ${user_id} ;;
    drill_fields: [id, course_name, last_name, first_name, started_date]
    label: "Users Enrolled"
  }

  measure: courses_completed {
    type: count
    filters: [is_complete: "yes"]
    drill_fields: [id, course_name, last_name, first_name, started_date]
    hidden: yes
  }

  measure: users_with_completions {
    type: count_distinct
    sql: ${user_id} ;;
    sql_distinct_key: ${user_id} ;;
    filters: [is_complete: "yes"]
    drill_fields: [id, course_name, last_name, first_name, started_date]
    label: "Users with Completed Course"
  }

  measure: avg_pct_completed {
    type: average
    sql: ${percentage_completed} ;;
    label: "Avg Percent Completed"
    value_format: "0.00%"
  }
}
