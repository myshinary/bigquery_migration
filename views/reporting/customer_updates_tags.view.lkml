view: customer_updates_tags {
    derived_table: {
      sql:
        SELECT id, tag
        FROM ${customer_updates.SQL_TABLE_NAME}, UNNEST(tags) as tag
        WHERE ARRAY_LENGTH(tags) > 1
      ;;
    }
    view_label: "Customer Updates"

  dimension: id {
    type: string
    sql: CAST(${TABLE}.id TO STRING)||${TABLE}.tag ;;
    primary_key: yes
    hidden: yes
  }

  dimension: update_id {
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: tag {
    type: string
    sql: ${TABLE}.tag ;;
  }

  measure: tags {
    type: string
    sql: STRING_AGG(DISTINCT ${tag},', ') ;;
  }

}
