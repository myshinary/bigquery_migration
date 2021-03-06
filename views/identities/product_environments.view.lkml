view: product_environments {
  sql_table_name: `happyco-internal-systems.hub__identities.product_environments`
    ;;
  drill_fields: [id]

  view_label: "Customer"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
    sql: CAST(${TABLE}.created_at AS TIMESTAMP) ;;
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
    sql: ${TABLE}.effective_at ;;
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

  dimension: happy_business_id {
    label: "Product Environment ID"
    type: number
    sql: ${TABLE}.happy_business_id ;;
    hidden: no
    group_label: "Product Environment"
  }

  measure: happy_business_ids {
    label: "Product Environment IDs"
    type: string
    sql: STRING_AGG(DISTINCT CAST(${happy_business_id} AS STRING),', ') ;;
    group_label: "Product Environment"
  }

  dimension: happy_business_link_html {
    sql: 'https://manage.happyco.com/admin/businesses/'||CAST(${happy_business_id} AS STRING);;
    hidden: yes
  }

  dimension: happy_business_link {
    sql: ${happy_business_link_html} ;;
    html: <a href="{{ value }}" target="_blank">{{ happy_business_id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    label: "Admin Link"
    group_label: "Product Environment"
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    label: "Product Environment Name"
    view_label: "Customer"
    group_label: "Product Environment"
  }

  dimension: server_environment {
    type: string
    sql: ${TABLE}.environment ;;
    view_label: "Customer"
    group_label: "Product Environment"
    hidden: yes
  }

  measure: happy_business_names {
    label: "Product Environment Names"
    type: string
    sql: STRING_AGG(DISTINCT CAST(${name} AS STRING),', ') ;;
    group_label: "Product Environment"
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
    sql: CAST(${TABLE}.updated_at AS TIMESTAMP) ;;
    hidden: yes
  }

  measure: count {
    type: count
    #drill_fields: [id, name, orders.count, sales_order_line_items.count]
    hidden: no
    label: "Product Environment Count"
    group_label: "Product Environment"
  }
}
