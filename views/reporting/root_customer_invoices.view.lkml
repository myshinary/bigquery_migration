view: root_customer_invoices {
  view_label: "HUB"
  derived_table: {
    sql:
    SELECT DISTINCT hub_customer_id, i.number as invoice, i.id as invoice_id, is_paid, i.due_date, i.balance_cents, i.date = MIN(i.date) OVER (PARTITION BY n.root_so_customer_id) as first_invoice
      FROM hub__reporting.finance_normalized_line_items n
      JOIN hub__saas_optics.invoices i
      ON n.so_contract_id = i.contract_id
      WHERE i.date <= current_date
      ;;
  }

  dimension: invoice_id {
    type: number
    sql: ${TABLE}.invoice_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: hub_customer_id {
    type: number
    sql: ${TABLE}.hub_customer_id ;;
    hidden: yes
  }

  dimension: invoice {
    type: string
    sql: ${TABLE}.invoice ;;
    hidden: yes
  }

  dimension: is_paid {
    type: yesno
    sql: ${TABLE}.is_paid ;;
    group_label: "Invoices"
  }

  dimension: due_date {
    type: date
    convert_tz: no
    sql: ${TABLE}.due_date ;;
    group_label: "Invoices"
  }

  dimension: balance_cents_dimension {
    type: number
    sql: ${TABLE}.balance_cents/100 ;;
    hidden: yes
  }

  measure: balance {
    type: sum
    sql: ${balance_cents_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "Invoices"
    drill_fields: [customers.parent,due_date,hub_invoices_link,saasoptics_link,balance]
  }

  dimension: first_invoice {
    type: yesno
    sql: ${TABLE}.first_invoice ;;
    group_label: "Invoices"
  }

  dimension: past_due {
    type: yesno
    sql: (current_date > ${due_date} AND ${balance_cents_dimension} > 0) ;;
    group_label: "Invoices"
  }

  dimension: days_past_due_dimension {
    type: number
    sql: CASE WHEN ${past_due} IS TRUE THEN DATE_DIFF(current_date,${due_date},DAY) ELSE NULL END;;
    hidden: yes
  }

  measure: days_past_due {
    type: max
    sql: ${days_past_due_dimension} ;;
    value_format: "0\" Days Past Due\""
    description: "If more than 1 invoice is past due, will display the oldest invoice"
    group_label: "Invoices"
  }

  dimension: hub_invoices_link_html {
    sql: CONCAT('https://hub.happy.co/customers/',${hub_customer_id},'/finance_invoices');;
    hidden: yes
  }

  dimension: hub_invoices_link {
    label: "HUB Invoices Link"
    sql: ${hub_invoices_link_html} ;;
    html: <a href="{{ value }}" target="_blank">{{ invoice_id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "Invoices"
  }

  dimension: saasoptics_url {
    sql: CONCAT('https://h12.saasoptics.com/qbov9_happyco/so/customers/',(CAST(${invoice_id} AS STRING)),'/') ;;
    hidden: yes
  }

  dimension: saasoptics_link {
    label: "SaasOptics Invoice Link"
    sql: ${saasoptics_url} ;;
    html: <a href="{{ value }}" target="_blank">{{ invoice_id }} <img src="https://storage.googleapis.com/happyco-downloadable-assets/bi/public/external-link.png" style=" width: 8px; height: 8px; display: inline-block;" /></a> ;;
    group_label: "Invoices"
  }

  measure: count {
    type: count
    drill_fields: [hub_invoices_link,saasoptics_link,balance]
    group_label: "Invoices"
  }

}
