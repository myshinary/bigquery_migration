view: customer_ancestry {
  sql_table_name: `happyco-internal-systems.hub__reporting.customer_ancestry`
    ;;
  view_label: "Customer"
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: ancestry {
    type: string
    sql: ${TABLE}.ancestry ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: is_root {
    label: "Is Root Customer?"
    type: yesno
    sql: ${TABLE}.is_root ;;
    description: "A root customer is the top level customer."
    #group_label: "Customer"
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}.parent_id ;;
    hidden: yes
  }

  dimension: root_id {
    type: number
    sql: ${TABLE}.root_id ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: power_of_one {
    type: number
    sql: 1 ;;
    description: "This provides a common value to easily to merge queries on customer measures"
  }
}
