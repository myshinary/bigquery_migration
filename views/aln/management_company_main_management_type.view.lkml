view: management_company_main_management_type {
  derived_table: {
    sql:
      SELECT management_company_id, asset_or_fee_managed, count, total, count/total as coverage
        FROM
        (SELECT management_company_id, asset_or_fee_managed, count, SUM(count) OVER (PARTITION BY management_company_id) as total, ROW_NUMBER() OVER (PARTITION BY management_company_id ORDER BY count DESC) as rn
        FROM
        (SELECT management_company_id, COALESCE(asset_or_fee_managed,'Unknown') as asset_or_fee_managed, COUNT(DISTINCT id) as count
        FROM ${apartments.SQL_TABLE_NAME}
        WHERE management_company_id IS NOT NULL
        GROUP BY 1,2) x1
        WHERE asset_or_fee_managed != 'Unknown') x2
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

  dimension: main_management_type {
    type: string
    sql: ${TABLE}.asset_or_fee_managed ;;
    group_label: "Asset or Fee Managed"
  }

  dimension: main_management_type_coverage {
    type: number
    sql: ${TABLE}.coverage ;;
    value_format: "0.0%"
    group_label: "Asset or Fee Managed"
  }

}
