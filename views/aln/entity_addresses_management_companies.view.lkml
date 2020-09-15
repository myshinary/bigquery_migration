view: entity_addresses_management_companies {
  derived_table: {
    sql:
      WITH primary_address AS (
      SELECT id, ROW_NUMBER() OVER (PARTITION BY entity_id ORDER BY ranking) as row_rank
      FROM
      (SELECT id, entity_id, CASE WHEN address_type LIKE '%Physical%' THEN 1 WHEN address_type LIKE '%Billing%' THEN 2 WHEN address_type LIKE '%Mailing%' THEN 3 WHEN address_type LIKE '%Other%' THEN 4 ELSE 5 END as ranking
      FROM `hub__aln_data.entity_addresses`
      WHERE is_primary) x
      )

      SELECT *
      FROM `hub__aln_data.entity_addresses`
      WHERE id NOT IN (SELECT id FROM primary_address WHERE row_rank != 1)
      AND is_primary
      ;;
  }
  view_label: "ALN Management Company"

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: entity_id {
    type: string
    sql: ${TABLE}.entity_id ;;
    hidden: yes
  }

  dimension: aln_id {
    type: number
    sql: ${TABLE}.aln_id ;;
    hidden: yes
  }

  dimension: entity_type {
    type: string
    sql: ${TABLE}.entity_type ;;
    hidden: yes
  }

  dimension: address_type {
    type: string
    sql: ${TABLE}.address_type ;;
    hidden: yes
  }

  dimension: line_1 {
    type: string
    sql: ${TABLE}.line_1 ;;
    hidden: yes
  }

  dimension: line_2 {
    type: string
    sql: ${TABLE}.line_2 ;;
    hidden: yes
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    hidden: yes
  }

  dimension: state {
    type: string
    sql: UPPER(TRIM(${TABLE}.state)) ;;
    group_label: "Market"
  }

  dimension: region {
    type: string
    sql: CASE WHEN ${state} IN ('AB','BC','CA','CO','ID','ND','NE','NV','OR','SD','UT','WA') THEN 'NW' WHEN ${state} IN ('AR','AZ','IA','IN','IL','KS','LA','MI','MN','MO','NM','OK','TX','WI') THEN 'SW' WHEN ${state} IN ('AL','FL','GA','KY','MO','NC','OH','SC','TN') THEN 'SE' WHEN ${state} IN ('DC','MA','MD','ME','NH','NJ','NY','ON','PA','QC','VA') THEN 'NE' ELSE NULL END ;;
    group_label: "Market"
  }

  dimension: postal_code {
    label: "Zip"
    type: string
    sql: ${TABLE}.postal_code ;;
    group_label: "Market"
  }

  dimension: is_primary {
    type: string
    sql: ${TABLE}.is_primary ;;
    hidden: yes
  }

  dimension: address_id {
    type: string
    sql: ${TABLE}.address_id ;;
    hidden: yes
  }
}
