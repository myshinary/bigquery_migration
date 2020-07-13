view: invoice_items {
  sql_table_name: `happyco-internal-systems.hub__saas_optics.invoice_items`
    ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: saasoptics_url {
    sql: CONCAT('https://a12.saasoptics.com/qbov9_happyco/so/ilis/',(CAST(${id} AS STRING)),'/') ;;
    hidden: yes
  }

  dimension: saasoptics_link {
    sql: ${saasoptics_url} ;;
    html: <a href="{{ value }}" target="_blank">{{ id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
  }

  #dimension: amount_cents {
  #  type: number
  #  sql: ${TABLE}.amount_cents ;;
  #}

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

 #dimension: deleted_in_qb {
 #  type: yesno
 #  sql: ${TABLE}.deleted_in_qb ;;
 #}

 #dimension: external_id {
 #  type: string
 #  sql: ${TABLE}.external_id ;;
 #}

  dimension: invoice {
    type: number
    # hidden: yes
    sql: ${TABLE}.invoice_id ;;
  }

  #dimension: item_id {
  #  type: number
  #  sql: ${TABLE}.item_id ;;
  #}

  #dimension: json {
  #  type: string
  #  sql: ${TABLE}.json ;;
  #}

  #dimension: local_amount_cents {
  #  type: number
  #  sql: ${TABLE}.local_amount_cents ;;
  #}

 #dimension: no_transaction_permitted {
 #  type: yesno
 #  sql: ${TABLE}.no_transaction_permitted ;;
 #}

 dimension: notes {
   type: string
   sql: ${TABLE}.notes ;;
 }

 #dimension: number {
 #  type: string
 #  sql: ${TABLE}.number ;;
 #}

 #dimension: override {
 #  type: yesno
 #  sql: ${TABLE}.override ;;
 #}

 #dimension: quantity {
 #  type: number
 #  sql: ${TABLE}.quantity ;;
 #}

 #dimension: recurly_id {
 #  type: string
 #  sql: ${TABLE}.recurly_id ;;
 #}

 #dimension: refund_of_id {
 #  type: number
 #  sql: ${TABLE}.refund_of_id ;;
 #}

 #dimension: refund_of_stripe_id {
 #  type: string
 #  sql: ${TABLE}.refund_of_stripe_id ;;
 #}

 #dimension: revision {
 #  type: number
 #  sql: ${TABLE}.revision ;;
 #}

 #dimension: stripe_id {
 #  type: string
 #  sql: ${TABLE}.stripe_id ;;
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

  #dimension: transaction_id {
  #  type: number
  #  # hidden: yes
  #  sql: ${TABLE}.transaction_id ;;
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
    drill_fields: [id, transactions.id, invoices.id]
  }
}
