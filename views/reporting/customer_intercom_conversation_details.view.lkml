view: customer_intercom_conversation_details {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_intercom_conversation_details`
    ;;
  drill_fields: [id]
  view_label: "Customer Support"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: contact_id {
    type: string
    sql: ${TABLE}.contact_id ;;
    hidden: yes
  }

  dimension: conversation_id {
    type: string
    sql: ${TABLE}.conversation_id ;;
    hidden: yes
  }

  dimension: intercom_link {
    type: string
    sql: ${TABLE}.conversation_id ;;
    html: <a href="https://app.intercom.com/a/apps/yaqkh6zy/inbox/inbox/conversation/{{ value }}" target="_blank">{{ value }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "Intercom Conversations"
  }

  dimension_group: conversation_last_message {
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
    sql: ${TABLE}.conversation_last_message_at ;;
    hidden: yes
  }

  dimension_group: conversation_started {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.conversation_started_at AS TIMESTAMP) ;;
    group_label: "Intercom Conversations"
  }


  dimension: conversation_status {
    type: string
    sql: ${TABLE}.conversation_status ;;
    group_label: "Intercom Conversations"
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: happy_business_id {
    type: number
    sql: ${TABLE}.happy_business_id ;;
    hidden: yes
  }

  dimension: happy_user_id {
    type: number
    sql: ${TABLE}.happy_user_id ;;
    group_label: "Intercom Conversations"
  }

  dimension: product_environment_id {
    type: number
    sql: ${TABLE}.product_environment_id ;;
    hidden: yes
  }

  dimension: rating {
    type: number
    sql: ${TABLE}.rating ;;
    group_label: "Intercom Conversations"
  }

  dimension: user_email {
    type: string
    sql: ${TABLE}.user_email ;;
    group_label: "Intercom Conversations"
  }

  measure: count {
    type: count_distinct
    sql: ${conversation_id} ;;
    # drill_fields: [conversation_id]
    # group_label: "Intercom Conversations"
    label: "Number of Conversations"
  }

  measure: count_of_conversations_positive_ratings {
    type: count_distinct
    sql: ${conversation_id} ;;
    filters: [rating: ">= 4"]
    hidden: yes
  }
  measure: count_of_conversations_with_ratings {
    type: count_distinct
    sql: ${conversation_id} ;;
    filters: [rating: ">= 0"]
    hidden: yes
  }
  measure: csat_score {
    label: "CSAT Score"
    type: number
    value_format_name: percent_2
    sql: ${count_of_conversations_positive_ratings} / ${count_of_conversations_with_ratings} ;;
  }
}
