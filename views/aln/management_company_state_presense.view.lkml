view: management_company_state_presense {
  derived_table: {
    sql:
      SELECT management_company_id, state, count, total, count/total as coverage, rn as coverage_rank
        FROM
        (SELECT management_company_id, state, count, SUM(count) OVER (PARTITION BY management_company_id) as total, ROW_NUMBER() OVER (PARTITION BY management_company_id ORDER BY count DESC) as rn
        FROM
        (SELECT management_company_id, COALESCE(p.state,'N/A') as state, COUNT(DISTINCT id) as count
        FROM ${apartments.SQL_TABLE_NAME} a
          JOIN ${aln_mappings.SQL_TABLE_NAME} m
        ON a.id = m.aln_apartment_id
          JOIN ${properties.SQL_TABLE_NAME} p
        ON m.property_id = p.id
        WHERE a.management_company_id IS NOT NULL
        GROUP BY 1,2) x1) x2
         ;;
  }

  view_label: "ALN Management Company"

  dimension: management_company_id {
    type: number
    sql: ${TABLE}.management_company_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    group_label: "Property Market"
  }

  dimension: state_coverage {
    type: number
    sql: ${TABLE}.coverage ;;
    value_format: "0.0%"
    group_label: "Property Market"
    label: "Percent of Units in State"
  }

  dimension: coverage_rank {
    type: string
    sql: CASE WHEN ${TABLE}.coverage_rank = 1 THEN TRUE ELSE FALSE END;;
    group_label: "Property Market"
    label: "Main State"
  }

  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
    group_label: "Property Market"
    label: "Units in State"
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
    group_label: "Property Market"
    label: "Total Units"
    hidden: yes
  }

}
