view: invoices {
  sql_table_name: `happyco-internal-systems.hub__saas_optics.invoices`
    ;;


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: saasoptics_url {
    sql: CONCAT('https://a12.saasoptics.com/qbov9_happyco/so/invoices/',(CAST(${id} AS STRING)),'/') ;;
    hidden: yes
  }

  dimension: saasoptics_link {
    sql: ${saasoptics_url} ;;
    html: <a href="{{ value }}" target="_blank">{{ id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
  }

  dimension: applied_amount {
    type: number
    sql: ${TABLE}.applied_amount_cents/100 ;;
  }

  dimension: balance {
    type: number
    sql: ${TABLE}.balance_cents/100 ;;
  }

 #dimension: billing_addr_1 {
 #  type: string
 #  sql: ${TABLE}.billing_addr_1 ;;
 #}

 #dimension: billing_addr_2 {
 #  type: string
 #  sql: ${TABLE}.billing_addr_2 ;;
 #}

 #dimension: billing_addr_3 {
 #  type: string
 #  sql: ${TABLE}.billing_addr_3 ;;
 #}

 #dimension: city {
 #  type: string
 #  sql: ${TABLE}.city ;;
 #}

 dimension: contract {
   type: number
   # hidden: yes
   sql: ${TABLE}.contract_id ;;
 }

 #dimension: country {
 #  type: string
 #  map_layer_name: countries
 #  sql: ${TABLE}.country ;;
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

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

 #dimension: deleted_in_qb {
 #  type: yesno
 #  sql: ${TABLE}.deleted_in_qb ;;
 #}

 #dimension: do_not_sync {
 #  type: yesno
 #  sql: ${TABLE}.do_not_sync ;;
 #}

  dimension_group: due {
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
    sql: ${TABLE}.due_date ;;
  }

  dimension: days_past_due {
    type: number
    sql:  DATE_DIFF(current_date,${due_date},DAY) ;;
  }

  dimension: days_past_invoice {
    type: number
    sql:  DATE_DIFF(current_date,${date_date},DAY) ;;
  }

  measure: number_days_past_due {
    type: max
    sql: ${days_past_due} ;;
  }

  dimension: due_date_range {
    type: string
    sql: CASE
            WHEN ${days_past_due} <= -91 THEN 'Future'
            WHEN ${days_past_due} >= -90 AND ${days_past_due} <= 0 THEN '0 Days Past Due (Current)'
            WHEN ${days_past_due} > 0 AND ${days_past_due} <= 30 THEN '1-30 Days Past Due'
            WHEN (${days_past_due} > 30 AND ${days_past_due} <= 60) THEN '31-60 Days Past Due'
            WHEN (${days_past_due} > 60 AND ${days_past_due} <= 90) THEN '61-90 Days Past Due'
            WHEN (${days_past_due} > 90 AND ${days_past_due} <= 120) THEN '91-120 Days Past Due'
          ELSE 'Greater Than 120 Days Past Due'
  END ;;
  }

 #dimension: email_from_so {
 #  type: yesno
 #  sql: ${TABLE}.email_from_so ;;
 #}

 #dimension: enable_ach_payment {
 #  type: yesno
 #  sql: ${TABLE}.enable_ach_payment ;;
 #}

 #dimension: enable_cc_payment {
 #  type: yesno
 #  sql: ${TABLE}.enable_cc_payment ;;
 #}

 #dimension_group: exported {
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
 #  sql: CAST(${TABLE}.exported_at AS TIMESTAMP) ;;
 #}

 #dimension: external_id {
 #  type: string
 #  sql: ${TABLE}.external_id ;;
 #}

 #dimension: foreign_exchange_rate_cents {
 #  type: number
 #  sql: ${TABLE}.foreign_exchange_rate_cents ;;
 #}

 #dimension: ignore_date_when_syncing {
 #  type: yesno
 #  sql: ${TABLE}.ignore_date_when_syncing ;;
 #}

 #dimension: is_paid {
 #  type: yesno
 #  sql: ${TABLE}.is_paid ;;
 #}

 #dimension: json {
 #  type: string
 #  sql: ${TABLE}.json ;;
 #}

 #dimension: local_currency {
 #  type: string
 #  sql: ${TABLE}.local_currency ;;
 #}

 #dimension: memo {
 #  type: string
 #  sql: ${TABLE}.memo ;;
 #}

 #dimension: number {
 #  type: string
 #  sql: ${TABLE}.number ;;
 #}

 #dimension: other {
 #  type: string
 #  sql: ${TABLE}.other ;;
 #}

 #dimension: override {
 #  type: yesno
 #  sql: ${TABLE}.override ;;
 #}

 #dimension: po_number {
 #  type: string
 #  sql: ${TABLE}.po_number ;;
 #}

 dimension: qb_number {
   type: string
   sql: ${TABLE}.qb_number ;;
 }

 #dimension_group: qb_synced {
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
 #  sql: CAST(${TABLE}.qb_synced_at AS TIMESTAMP) ;;
 #}

 dimension: qb_txn_id {
   type: string
   sql: ${TABLE}.qb_txn_id ;;
 }

 dimension: recurly_id {
   type: string
   sql: ${TABLE}.recurly_id ;;
 }

 #dimension: refund_of_id {
 #  type: number
 #  sql: ${TABLE}.refund_of_id ;;
 #}

 #dimension: revision {
 #  type: number
 #  sql: ${TABLE}.revision ;;
 #}

 #dimension: sales_tax_cents {
 #  type: number
 #  sql: ${TABLE}.sales_tax_cents ;;
 #}

 #dimension: sales_tax_percentage {
 #  type: number
 #  sql: ${TABLE}.sales_tax_percentage ;;
 #}

 #dimension_group: ship {
 #  type: time
 #  timeframes: [
 #    raw,
 #    date,
 #    week,
 #    month,
 #    quarter,
 #    year
 #  ]
 #  convert_tz: no
 #  datatype: date
 #  sql: ${TABLE}.ship_date ;;
 #}

 #dimension: shipping_billing_addr_1 {
 #  type: string
 #  sql: ${TABLE}.shipping_billing_addr_1 ;;
 #}

 #dimension: shipping_billing_addr_2 {
 #  type: string
 #  sql: ${TABLE}.shipping_billing_addr_2 ;;
 #}

 #dimension: shipping_billing_addr_3 {
 #  type: string
 #  sql: ${TABLE}.shipping_billing_addr_3 ;;
 #}

 #dimension: shipping_city {
 #  type: string
 #  sql: ${TABLE}.shipping_city ;;
 #}

 #dimension: shipping_country {
 #  type: string
 #  sql: ${TABLE}.shipping_country ;;
 #}

 #dimension: shipping_state {
 #  type: string
 #  sql: ${TABLE}.shipping_state ;;
 #}

 #dimension: shipping_zip_code {
 #  type: string
 #  sql: ${TABLE}.shipping_zip_code ;;
 #}

 #dimension: state {
 #  type: string
 #  sql: ${TABLE}.state ;;
 #}

 dimension: stripe_id {
   type: string
   sql: ${TABLE}.stripe_id ;;
 }

 #dimension: stripe_refund_id {
 #  type: string
 #  sql: ${TABLE}.stripe_refund_id ;;
 #}

 dimension: subtotal {
   type: number
   sql: ${TABLE}.subtotal_cents/100 ;;
 }

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

 #dimension: to_be_emailed {
 #  type: yesno
 #  sql: ${TABLE}.to_be_emailed ;;
 #}

 #dimension: to_be_printed {
 #  type: yesno
 #  sql: ${TABLE}.to_be_printed ;;
 #}

 dimension: type {
   type: string
   sql: ${TABLE}.type ;;
 }

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

 #dimension: zip_code {
 #  type: zipcode
 #  sql: ${TABLE}.zip_code ;;
 #}

  measure: count {
    type: count
    drill_fields: [id, contracts.id, invoice_items.count]
  }
}
