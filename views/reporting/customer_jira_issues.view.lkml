view: customer_jira_issues {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_jira_issues`
    ;;
  view_label: "Account Management"
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
    hidden: yes
  }

  dimension: assignee_employee_id {
    type: number
    sql: ${TABLE}.assignee_employee_id ;;
    hidden: yes
  }

  dimension: assignee_name {
    type: string
    sql: ${TABLE}.assignee_name ;;
    hidden: yes
  }

  dimension_group: jira_ticket_created {
    type: time
    timeframes: [
      date
    ]
    sql: CAST(${TABLE}.created_at AS TIMESTAMP) ;;
    group_label: "Jira Issues"
  }

  dimension: creator_email {
    type: string
    sql: ${TABLE}.creator_email ;;
    hidden: yes
  }

  dimension: creator_employee_id {
    type: number
    sql: ${TABLE}.creator_employee_id ;;
    hidden: yes
  }

  dimension: creator_name {
    type: string
    sql: ${TABLE}.creator_name ;;
    hidden: yes
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: issue_type {
    label: "Jira Issue Type"
    type: string
    sql: ${TABLE}.issue_type ;;
    group_label: "Jira Issues"
  }

  dimension: jira_issue_key {
    type: string
    sql: ${TABLE}.jira_issue_key ;;
    hidden: yes
  }

  dimension: priority {
    label: "Jira Issue Priority"
    type: string
    sql: ${TABLE}.priority ;;
    group_label: "Jira Issues"
    order_by_field: priority_score
  }

  dimension: priority_score {
    type: number
    sql: CASE WHEN ${TABLE}.priority = 'Default' THEN 5 WHEN ${TABLE}.priority = 'Low' THEN 4 WHEN ${TABLE}.priority = 'Medium' THEN 3 WHEN ${TABLE}.priority = 'High' THEN 2 WHEN ${TABLE}.priority = 'Highest' THEN 1 ELSE 0 END ;;
    hidden: yes
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension: root_customer_id {
    type: number
    sql: ${TABLE}.root_customer_id ;;
    hidden: yes
  }

  dimension: jira_issue_status {
    type: string
    sql: ${TABLE}.status ;;
    group_label: "Jira Issues"
  }

  dimension: summary {
    type: string
    sql: ${TABLE}.summary ;;
    hidden: yes
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
    hidden: yes
  }

  dimension: jira_issue_link {
    label: "Jira Issue Link"
    type: string
    sql: ${TABLE}.jira_issue_link ;;
    html: <a href="{{ value }}" target="_blank">{{ title }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "Jira Issues"
  }

  dimension: total_comments {
    type: number
    sql: ${TABLE}.total_comments ;;
    hidden: yes
  }

  dimension_group: jira_ticket_updated {
    type: time
    timeframes: [
      date
    ]
    sql: CAST(${TABLE}.updated_at AS TIMESTAMP);;
    group_label: "Jira Issues"
  }

  measure: count {
    label: "Jira Issues Count"
    type: count
    drill_fields: [jira_issue_link, jira_issue_status, jira_ticket_created_date, jira_ticket_updated_date]
  }
}
