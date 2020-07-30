view: aln_management_company_id_correction {
  derived_table: {
    sql:
    --has_short_term_leases and has_corporate_housing excluded as property features, not types
    WITH correct_management_company_id AS (
      SELECT m.aln_apartment_id, bm.aln_id as aln_management_company_id
      FROM ${aln_mappings.SQL_TABLE_NAME} m
      LEFT JOIN ${orders.SQL_TABLE_NAME} o
      ON m.property_id = o.real_property_id
      LEFT JOIN ${product_environments.SQL_TABLE_NAME} pe
      ON o.product_environment_id = pe.id
      LEFT JOIN ${business_mapping.SQL_TABLE_NAME} bm
      ON pe.happy_business_id = bm.happy_co_business_id
      )

      SELECT a.id as aln_apartment_id, COALESCE(mc.aln_management_company_id,a.management_company_id) as correct_management_company_id
      FROM ${apartments.SQL_TABLE_NAME} a
      LEFT JOIN correct_management_company_id mc
      ON a.id = mc.aln_apartment_id
    ;;
  }

  dimension: aln_apartment_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.aln_apartment_id ;;
    hidden: yes
  }

  dimension: correct_management_company_id {
    type: string
    sql: ${TABLE}.correct_management_company_id ;;
    hidden: yes
  }
}
