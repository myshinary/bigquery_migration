view: properties {
  sql_table_name: `happyco-internal-systems.hub__real_properties.properties`
    ;;
    view_label: "Property"
  #drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    group_label: "Address"
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

  dimension: lat {
    type: string
    sql: CAST(${TABLE}.lat AS NUMERIC);;
    hidden: yes
  }

  dimension: legal_name {
    type: string
    sql: ${TABLE}.legal_name ;;
    hidden: yes
  }

  dimension: line_1 {
    type: string
    sql: ${TABLE}.line_1 ;;
    group_label: "Address"
  }

  dimension: line_2 {
    type: string
    sql: ${TABLE}.line_2 ;;
    group_label: "Address"
    hidden: yes
  }

  dimension: long {
    type: string
    sql: CAST(${TABLE}.long AS NUMERIC);;
    hidden: yes
  }

  dimension: geo_location {
    type: location
    label: "GEO Location"
    sql_latitude:${lat} ;;
    sql_longitude:${long};;
    #group_label: "Address"
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: number_of_units {
    type: number
    sql: ${TABLE}.number_of_units ;;
  }

  measure: total_units {
    type: sum_distinct
    sql: ${number_of_units} ;;
    sql_distinct_key: ${id} ;;
  }

  dimension: postcode {
    type: string
    label: "Zip"
    sql: ${TABLE}.postcode ;;
    group_label: "Address"
  }

  dimension: property_type {
    type: string
    sql: ${TABLE}.property_type ;;
  }

  dimension: revision {
    type: number
    sql: ${TABLE}.revision ;;
    hidden: yes
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    group_label: "Address"
  }

  dimension: full_address {
    type: string
    sql: ${line_1}||' '||${city}||', '||${state}||' '||${postcode};;
    group_label: "Address"
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

  dimension: is_happyco_customer {
    label: "HappyCo Customer?"
    type: yesno
    sql: CASE WHEN (${orders.product_environment_id} IS NULL OR ${orders.deactivated_date} IS NOT NULL) THEN FALSE ELSE TRUE END ;;
  }

  dimension: exists_in_aln {
    label: "Exists in ALN?"
    type: yesno
    sql: CASE WHEN ${aln_mappings.aln_apartment_id} IS NULL THEN FALSE ELSE TRUE END ;;
    hidden: yes
    #hidden until we bring in properties to the Real Properties Domain that don't exist in ALN (but do in HappyCo)
  }

  measure: count {
    type: count_distinct
    sql: ${id} ;;
    sql_distinct_key: ${id} ;;
    #drill_fields: [id, name, legal_name]
  }
}
