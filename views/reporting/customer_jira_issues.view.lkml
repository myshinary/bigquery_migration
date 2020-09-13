view: customer_jira_issues {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_jira_issues`
    ;;
  view_label: "Customer Tickets"
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: assignee_email {
    type: string
    sql: ${TABLE}.assignee_email ;;
  }

  dimension: assignee_employee_id {
    type: number
    sql: ${TABLE}.assignee_employee_id ;;
    hidden: yes
  }

  dimension: assignee_name {
    type: string
    sql: ${TABLE}.assignee_name ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: creator_email {
    type: string
    sql: ${TABLE}.creator_email ;;
  }

  dimension: creator_employee_id {
    type: number
    sql: ${TABLE}.creator_employee_id ;;
    hidden: yes
  }

  dimension: creator_name {
    type: string
    sql: ${TABLE}.creator_name ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: issue_type {
    type: string
    sql: ${TABLE}.issue_type ;;
  }

  dimension: jira_issue_key {
    type: string
    sql: ${TABLE}.jira_issue_key ;;
  }

  dimension: jira_issue_link {
    type: string
    sql: ${TABLE}.jira_issue_link ;;
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.priority ;;
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
  }

  dimension: root_customer_id {
    type: number
    sql: ${TABLE}.root_customer_id ;;
    hidden: yes
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: summary {
    type: string
    sql: ${TABLE}.summary ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: total_comments {
    type: number
    sql: ${TABLE}.total_comments ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, assignee_name, creator_name]
  }
}
