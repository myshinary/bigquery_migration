view: customer_intercom_conversation_ratings {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_intercom_conversation_ratings`
    ;;
  drill_fields: [id]
  view_label: "Customer Support"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: conversation_id {
    type: string
    sql: ${TABLE}.conversation_id ;;
    hidden: yes
  }

  dimension_group: intercom_conversation_rated_on {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.rated_at AS TIMESTAMP) ;;
  }

  dimension: rating {
    type: number
    sql: ${TABLE}.rating ;;
    hidden: yes
  }

  measure: count_of_conversations_with_ratings {
    type: count
    drill_fields: [id]
    hidden: yes
  }

  measure: count_of_conversations_positive_ratings {
    type: count_distinct
    sql: ${conversation_id} ;;
    filters: [rating: ">= 4"]
    hidden: yes
  }

  measure: csat_score {
    label: "CSAT Score (Rating Date)"
    description: "The CSAT score is calculated based on the date the conversation was rated."
    type: number
    value_format_name: percent_2
    sql: ${count_of_conversations_positive_ratings} / ${count_of_conversations_with_ratings} ;;
  }
}
