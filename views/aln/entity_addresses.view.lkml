view: entity_addresses {
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
  view_label: "Property Addresses"

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
  }

  dimension: line_2 {
    type: string
    sql: ${TABLE}.line_2 ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    type: string
    sql: UPPER(TRIM(${TABLE}.state)) ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }

  dimension: is_primary {
    type: string
    sql: ${TABLE}.is_primary ;;
  }

  dimension: address_id {
    type: string
    sql: ${TABLE}.address_id ;;
    hidden: yes
  }
}
