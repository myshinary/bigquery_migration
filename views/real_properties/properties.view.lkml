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
    type: sum
    sql: ${number_of_units} ;;
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

  measure: count {
    type: count
    #drill_fields: [id, name, legal_name]
  }
}
