view: daily_mrr_by_customer_product {
  sql_table_name: `bi.daily_mrr_by_customer_product`
    ;;
    view_label: "MRR"

  dimension: mrr_dimension {
    type: number
    sql: ${TABLE}.mrr ;;
    hidden: yes
  }

  dimension: customer {
    type: number
    sql: ${TABLE}.customer ;;
    hidden: yes
    #not currently bringing in hierarchy as joins to revenue are simpler at the parent level
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      day_of_month,
      quarter,
      quarter_of_year,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: fx_adjustment_dimension {
    type: number
    sql: ${TABLE}.fx_adjustment ;;
    hidden: yes
  }
  dimension: parent_change_type {
    type: string
    sql: ${TABLE}.parent_change_type ;;
    drill_fields: [saasoptics_customer_private_data.parent_name]
  }

  filter: remove_fx_adjustment {
    type: yesno
    sql:  ${fx_adjustment_change_dimension} IS NULL;;
    hidden: yes
  }

  dimension: fx_adjustment_change_dimension {
    type: number
    sql: ${TABLE}.fx_adjustment_change ;;
    hidden: yes
  }

  dimension: parent_lost_dimension {
    type: number
    sql: ${TABLE}.parent_lost ;;
    hidden: yes
  }

  dimension: product_lost_dimension {
    type: number
    sql: ${TABLE}.product_lost ;;
    hidden: yes
  }

  dimension: daily_mrr_dimension {
    type: number
    sql: ${TABLE}.daily_mrr ;;
    hidden: yes
  }

  dimension: parent_new_dimension {
    type: number
    sql: ${TABLE}.parent_new ;;
    hidden: yes
  }

  dimension: product_new_dimension {
    type: number
    sql: ${TABLE}.product_new ;;
    hidden: yes
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}.parent_id ;;
    label: "HUB ID"
    view_label: "Customer"
    #renamed as customer field because not currently bringing in hierarchy as joins to revenue are simpler at the parent level
  }

  dimension: parent_expansion_contraction_dimension {
    type: number
    sql: ${TABLE}.parent_expansion_contraction ;;
    hidden: yes
  }

  dimension: parent_expansion_dimension {
    type: number
    sql: CASE WHEN ${parent_expansion_contraction_dimension} > 0 THEN ${parent_expansion_contraction_dimension} ELSE NULL END ;;
    hidden: yes
  }

  dimension: parent_contraction_dimension {
    type: number
    sql: CASE WHEN ${parent_expansion_contraction_dimension} < 0 THEN ${parent_expansion_contraction_dimension} ELSE NULL END ;;
    hidden: yes
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
  }

  dimension: product_expansion_contraction_dimension {
    type: number
    sql: ${TABLE}.product_expansion_contraction ;;
    hidden: yes
  }

  dimension: product_expansion_dimension {
    type: number
    sql: CASE WHEN ${product_expansion_contraction_dimension} > 0 THEN ${product_expansion_contraction_dimension} ELSE NULL END;;
    hidden: yes
  }

  dimension: product_contraction_dimension {
    type: number
    sql: CASE WHEN ${product_expansion_contraction_dimension} < 0 THEN ${product_expansion_contraction_dimension} ELSE NULL END ;;
    hidden: yes
  }

  measure: fx_adjustment {
    type: sum
    sql: ${fx_adjustment_dimension} ;;
    hidden: yes
  }

  measure: fx_adjustment_change {
    type: sum
    sql: ${fx_adjustment_change_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    group_label: "MRR Change"
    hidden: yes
  }

  measure: parent_lost {
    type: sum
    sql: ${parent_lost_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    drill_fields: [change_drill*]
    group_label: "MRR Change"
  }

  measure: product_lost {
    type: sum
    sql: ${product_lost_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    drill_fields: [change_drill*]
    group_label: "MRR Change"
  }

  measure: daily_mrr {
    type: sum
    sql: ${daily_mrr_dimension} ;;
    label: "Daily MRR"
    value_format: "$#,##0;($#,##0)"
    drill_fields: [mrr_drill*]

  }

  measure: parent_new {
    type: sum
    sql: ${parent_new_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    drill_fields: [change_drill*]
    group_label: "MRR Change"
  }

  measure: product_new {
    type: sum
    sql: ${product_new_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    drill_fields: [change_drill*]
    group_label: "MRR Change"
  }

  measure: parent_expansion {
    type: sum
    sql: ${parent_expansion_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    drill_fields: [change_drill*]
    group_label: "MRR Change"
  }

  measure: parent_contraction {
    type: sum
    sql: ${parent_contraction_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    drill_fields: [change_drill*]
    group_label: "MRR Change"
  }

  measure: product_expansion {
    type: sum
    sql: ${product_expansion_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    drill_fields: [change_drill*]
    group_label: "MRR Change"
  }

  measure: product_contraction {
    type: sum
    sql: ${product_contraction_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    drill_fields: [change_drill*]
    group_label: "MRR Change"
  }

  measure: mrr {
    type: sum
    label: "MRR"
    sql: ${mrr_dimension} ;;
    value_format: "$#,##0;($#,##0)"
    drill_fields: [change_drill*]
    group_label: "MRR Change"
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
    #not currently bringing in hierarchy as joins to revenue are simpler at the parent level
  }

  #parameter: mrr_change_bucket_size {
  #  type: number
  #}

  #dimension: mrr_change_bucket {
  # this really doesn't seem to be working
  # type: number
  #  sql: CAST(${new_parent_dimension} as INT64) - MOD(CAST(${new_parent_dimension} as INT64), CAST({% parameter mrr_change_bucket_size %} as INT64));;
  #}

  measure: parent_count {
    type:  count_distinct
    sql:  ${parent_id} ;;
    label: "Count"
    #renamed as customer field because not currently bringing in hierarchy as joins to revenue are simpler at the parent level
  }

  set: mrr_drill {
    fields: [
      date_date,
      daily_mrr,
      mrr,
      parent_new,
      product_new,
      parent_expansion,
      product_expansion,
      parent_contraction,
      product_contraction,
      parent_lost,
      product_lost

    ]
  }

  set: change_drill {
    fields: [
      date_date,
      saasoptics_customer_private_data.name,
      parent_new,
      product_new,
      parent_expansion,
      product_expansion,
      parent_contraction,
      product_contraction,
      parent_lost,
      product_lost

    ]
  }
}
