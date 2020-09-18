view: customers {
  sql_table_name: `happyco-internal-systems.bi.customers`
    ;;
    view_label: "Customer"
  drill_fields: [id]

  dimension: id {
    label: "Hub Customer ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    group_label: "HUB"
    #hidden: yes
    #not currently bringing in hierarchy as joins to revenue are simpler at the parent level
  }

  dimension: hub_customer_link_html {
    sql: 'https://hub.happy.co/customers/'||CAST(${id} AS STRING) ;;
    hidden: yes
  }

  dimension: hub_customer_link {
    label: "HUB Customer Link"
    sql: ${hub_customer_link_html} ;;
    html: <a href="{{ value }}" target="_blank">{{ id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "HUB"
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
    hidden: yes
    #not currently bringing in hierarchy as joins to revenue are simpler at the parent level
  }

  dimension: parent {
    type: string
    sql: ${TABLE}.parent ;;
    label: "Name"
    #renamed as customer field because not currently bringing in hierarchy as joins to revenue are simpler at the parent level
  }

  dimension: customer_dashboard_link_html {
    sql: 'https://data.happyco.com/dashboards/746?Customer='||${id} ;;
    hidden: yes
  }

  dimension: customer_dashboard {
    label: "Customer Dashboard Link"
    sql: ${customer_dashboard_link_html} ;;
    html: <a href="{{ value }}" target="_blank">{{ parent }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "HUB"
    hidden: yes
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}.parent_id ;;
    hidden: yes
    #same as saasoptics_id - not currently bringing in hierarchy as joins to revenue are simpler at the parent level
  }

  dimension: parent_saasoptics_id {
    type: number
    sql: ${TABLE}.parent_saasoptics_id ;;
    label: "SaasOptics ID"
    group_label: "SaasOptics"
    #renamed as customer field because not currently bringing in hierarchy as joins to revenue are simpler at the parent level
  }

  dimension: saasoptics_id {
    type: number
    sql: ${TABLE}.saasoptics_id ;;
    hidden: yes
  }

  dimension: saasoptics_url {
    sql: CONCAT('https://h12.saasoptics.com/qbov9_happyco/so/customers/',(CAST(${saasoptics_id} AS STRING)),'/') ;;
    hidden: yes
  }

  dimension: saasoptics_link {
    sql: ${saasoptics_url} ;;
    html: <a href="{{ value }}" target="_blank">{{ saasoptics_id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "SaasOptics"
  }

  dimension: salesforce_id {
    type: string
    sql: ${TABLE}.salesforce_id ;;
    group_label: "Salesforce"
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }

  measure: count_parent {
    type: count_distinct
    sql: ${parent_id} ;;
    hidden: yes
    }
}
