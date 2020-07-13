view: apartments {
  sql_table_name: `happyco-internal-systems.hub__aln_data.apartments`
    ;;

    view_label: "ALN"

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: agency_raw {
    type: string
    sql: ${TABLE}.agency_raw ;;
    hidden: yes
  }

  dimension: aln_id {
    type: number
    sql: ${TABLE}.aln_id ;;
    hidden: yes
  }

  dimension: application_fees {
    type: string
    sql: ${TABLE}.application_fees ;;
    hidden: yes
  }

  dimension: apt_owner_id {
    type: number
    sql: ${TABLE}.apt_owner_id ;;
    hidden: yes
  }

  dimension: area_supervisor_id {
    type: string
    sql: ${TABLE}.area_supervisor_id ;;
    hidden: yes
  }

  dimension: asset_or_fee_managed {
    type: string
    sql: ${TABLE}.asset_or_fee_managed ;;
  }

  dimension: average_rent {
    type: number
    sql: ${TABLE}.average_rent ;;
  }

  dimension: average_sq_ft {
    type: number
    sql: ${TABLE}.average_sq_ft ;;
    hidden: yes
  }

  dimension: current_manager {
    type: string
    sql: ${TABLE}.current_manager ;;
    hidden: yes
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    hidden: yes
  }

  dimension: directions {
    type: string
    sql: ${TABLE}.directions ;;
    hidden: yes
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    hidden: yes
  }

  dimension: geo_location_raw {
    type: string
    sql: ${TABLE}.geo_location_raw ;;
    hidden: yes
  }

  dimension: geo_location_latitude{
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${geo_location_raw},'$.GPSLatitude') AS NUMERIC) ;;
    hidden: yes
  }

  dimension: geo_location_longitude {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${geo_location_raw},'$.GPSLongitude') AS NUMERIC) ;;
    hidden: yes
  }

  dimension: geo_location {
    type: location
    label: "GEO Location"
    view_label: "Property Addresses"
    sql_latitude:${geo_location_latitude} ;;
    sql_longitude:${geo_location_longitude};;
    hidden: yes
  }

  dimension: has_corporate_housing {
    type: yesno
    sql: ${TABLE}.has_corporate_housing ;;
    label: "Corporate Housing"
    group_label: "Property Type"
  }

  dimension: has_short_term_leases {
    type: yesno
    sql: ${TABLE}.has_short_term_leases ;;
    group_label: "Property Type"
  }

  dimension: hours {
    type: string
    sql: ${TABLE}.hours ;;
    hidden: yes
  }

  dimension: income_restriction_details {
    type: string
    sql: ${TABLE}.income_restriction_details ;;
    hidden: yes
  }

  dimension: is_assisted_living {
    type: yesno
    sql: ${TABLE}.is_assisted_living ;;
    label: "Assisted Living"
    group_label: "Property Type"
  }

  dimension: is_income_restricted {
    type: yesno
    sql: ${TABLE}.is_income_restricted ;;
    label: "Income Restricted"
    group_label: "Property Type"
  }

  dimension: is_section8 {
    type: yesno
    sql: ${TABLE}.is_section8 ;;
    label: "Section 8"
    group_label: "Property Type"
  }

  dimension: is_senior_living {
    type: yesno
    sql: ${TABLE}.is_senior_living ;;
    label: "Senior Living"
    group_label: "Property Type"
  }

  dimension: is_student_housing {
    type: yesno
    sql: ${TABLE}.is_student_housing ;;
    label: "Student Housing"
    group_label: "Property Type"
  }

  dimension: lease_terms {
    type: string
    sql: ${TABLE}.lease_terms ;;
    hidden: yes
  }

  dimension: leasing_raw {
    type: string
    sql: ${TABLE}.leasing_raw ;;
    hidden: yes
  }

  dimension: management_company_id {
    type: string
    sql: ${TABLE}.management_company_id ;;
    hidden: yes
  }

  dimension: market {
    type: string
    sql: ${TABLE}.market ;;
    hidden: yes
  }

  dimension: number_of_floors {
    type: number
    sql: ${TABLE}.number_of_floors ;;
    hidden: yes
  }

  dimension: number_of_units {
    type: number
    sql: ${TABLE}.number_of_units ;;
  }

  measure: total_units {
    type: sum
    sql: ${number_of_units} ;;
    hidden: no
  }

  measure: avg_units {
    type: average
    sql: ${number_of_units} ;;
    hidden: no
  }

  measure: median_units {
    type: median
    sql: ${number_of_units} ;;
    hidden: no
  }

  dimension: unit_tier {
    type: string
    sql: CASE WHEN ${number_of_units} < 50 THEN '1. <50' WHEN ${number_of_units} BETWEEN 50 AND 100 THEN '2. 50-100' WHEN ${number_of_units} BETWEEN 101 AND 200 THEN '3. 101-200' WHEN ${number_of_units} BETWEEN 201 AND 300 THEN '4. 201-300' WHEN ${number_of_units} BETWEEN 301 AND 400 THEN '5. 301-400' WHEN ${number_of_units} BETWEEN 401 AND 500 THEN '6. 401-500' WHEN ${number_of_units} BETWEEN 501 AND 550 THEN '7. 501-550' WHEN ${number_of_units} > 550 THEN '8. >550' ELSE NULL END;;
  }

  dimension: occupancy {
    type: number
    sql: ${TABLE}.occupancy ;;
  }

  dimension: owner_id {
    type: string
    sql: ${TABLE}.owner_id ;;
    hidden: yes
  }

  dimension: pets_raw {
    type: string
    sql: ${TABLE}.pets_raw ;;
    hidden: yes
  }

  dimension: previous_name {
    type: string
    sql: ${TABLE}.previous_name ;;
    hidden: yes
  }

  dimension: pricing_tier {
    label: "Class"
    type: string
    sql: ${TABLE}.pricing_tier ;;
  }

  dimension: property_name {
    type: string
    sql: ${TABLE}.property_name ;;
  }

  dimension: property_raw {
    type: string
    sql: ${TABLE}.property_raw ;;
    hidden: yes
  }

  dimension: regional_management_company_id {
    type: string
    sql: ${TABLE}.regional_management_company_id ;;
    hidden: yes
  }

  dimension: row_version {
    type: number
    sql: ${TABLE}.row_version ;;
    hidden: yes
  }

  dimension: status_id {
    type: number
    sql: ${TABLE}.status_id ;;
    hidden: yes
  }

  dimension: sub_market_id {
    type: string
    sql: ${TABLE}.sub_market_id ;;
    hidden: yes
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
    hidden: yes
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
    sql: ${TABLE}.updated_at ;;
    hidden: yes
  }

  dimension: website_homepage {
    type: string
    sql: ${TABLE}.website_homepage ;;
    hidden: yes
  }

  dimension: year_built {
    type: number
    sql: ${TABLE}.year_built ;;
    value_format: "0000"
    hidden: yes
  }

  dimension: year_remodeled {
    type: number
    sql: ${TABLE}.year_remodeled ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id, previous_name, property_name]
  }
}
