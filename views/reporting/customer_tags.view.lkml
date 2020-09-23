view: customer_tags {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_tags`
    ;;
  drill_fields: [id]
  view_label: "HUB"

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

  dimension_group: tag_most_recent {
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
    sql: CAST(${TABLE}.last_used_at AS TIMESTAMP) ;;
  }

  dimension: tag {
    type: string
    sql: ${TABLE}.tag ;;
  }

  measure: tag_list {
    label: "Tags List"
    type: string
    sql: STRING_AGG(DISTINCT ${tag},', ') ;;
    group_label: "Tags"
  }

  measure: count {
    label: "Tags Count"
    type: count
    #drill_fields: [id]
    group_label: "Tags"
  }
}
