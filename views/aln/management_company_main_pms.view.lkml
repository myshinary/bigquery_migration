view: management_company_main_pms {
  derived_table: {
    sql:
      SELECT management_company_id, pms_group, count, total, count/total as coverage
        FROM
        (SELECT management_company_id, pms_group, count, SUM(count) OVER (PARTITION BY management_company_id) as total, ROW_NUMBER() OVER (PARTITION BY management_company_id ORDER BY count DESC) as rn
        FROM
        (SELECT a.management_company_id, COALESCE(p.pms_group,'Unknown') as pms_group, COUNT(DISTINCT a.id) as count
        FROM ${apartments.SQL_TABLE_NAME} a
        LEFT JOIN ${apartment_pms.SQL_TABLE_NAME} p
        ON a.id = p.aln_apartment_id
        WHERE a.management_company_id IS NOT NULL
        GROUP BY 1,2) x1
        WHERE pms_group != 'Unknown') x2
        WHERE rn = 1
         ;;
  }

  view_label: "ALN Management Company"

  dimension: management_company_id {
    type: number
    sql: ${TABLE}.management_company_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: main_pms {
    type: string
    sql: ${TABLE}.pms_group ;;
    group_label: "PMS"
  }

  dimension: main_pms_coverage {
    type: number
    sql: ${TABLE}.coverage ;;
    value_format: "0.0%"
    group_label: "PMS"
  }

}
