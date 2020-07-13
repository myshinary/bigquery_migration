view: customers {
  sql_table_name: `happyco-internal-systems.bi.customers`
    ;;
    view_label: "HappyCo Customer"
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: hub_customer_link_html {
    sql: 'https://hub.happy.co/customers/'||CAST(${id} AS STRING) ;;
    hidden: yes
  }

  dimension: hub_customer_link {
    label: "HUB Customer Link"
    sql: ${hub_customer_link_html} ;;
    html: <a href="{{ value }}" target="_blank">{{ id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "HUB Links"
  }

  dimension: ancestry {
    type: string
    sql: ${TABLE}.ancestry ;;
    hidden: yes
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
    hidden: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: parent {
    type: string
    sql: ${TABLE}.parent ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}.parent_id ;;
  }

  dimension: parent_saasoptics_id {
    type: number
    sql: ${TABLE}.parent_saasoptics_id ;;
  }

  dimension: saasoptics_id {
    type: number
    sql: ${TABLE}.saasoptics_id ;;
  }

  dimension: salesforce_id {
    type: string
    sql: ${TABLE}.salesforce_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
