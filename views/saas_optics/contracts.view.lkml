view: contracts {
  sql_table_name: `happyco-internal-systems.hub__saas_optics.contracts`
    ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: saasoptics_url {
    sql: CONCAT('https://h12.saasoptics.com/qbov9_happyco/so/contracts/',(CAST(${id} AS STRING)),'/') ;;
    hidden: yes
  }

  dimension: saasoptics_link {
    sql: ${saasoptics_url} ;;
    html: <a href="{{ value }}" target="_blank">{{ id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
  }

  #dimension_group: created {
  #  type: time
  #  timeframes: [
  #    raw,
  #    time,
  #    date,
  #    week,
  #    month,
  #    quarter,
  #    year
  #  ]
  #  sql: CAST(${TABLE}.created_at AS TIMESTAMP) ;;
  #}

  dimension: customer {
    type: number
    # hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  #dimension: json {
  #  type: string
  #  sql: ${TABLE}.json ;;
  #}

  dimension: number {
    type: string
    sql: ${TABLE}.number ;;
  }

  #dimension: override {
  #  type: yesno
  #  sql: ${TABLE}.override ;;
  #}

  dimension: register {
    type: number
    sql: ${TABLE}.register_id ;;
  }

 #dimension: revision {
 #  type: number
 #  sql: ${TABLE}.revision ;;
 #}

 #dimension_group: synced {
 #  type: time
 #  timeframes: [
 #    raw,
 #    time,
 #    date,
 #    week,
 #    month,
 #    quarter,
 #    year
 #  ]
 #  sql: CAST(${TABLE}.synced_at AS TIMESTAMP) ;;
 #}

 #dimension_group: updated {
 #  type: time
 #  timeframes: [
 #    raw,
 #    time,
 #    date,
 #    week,
 #    month,
 #    quarter,
 #    year
 #  ]
 #  sql: CAST(${TABLE}.updated_at AS TIMESTAMP) ;;
 #}

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      customers.name,
      customers.name,
      customers.id,
      customers.legal_name,
      transactions.count,
      invoices.count
    ]
  }
}
