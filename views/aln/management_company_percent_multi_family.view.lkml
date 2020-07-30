view: management_company_percent_multi_family {
  derived_table: {
    sql:
    --has_short_term_leases and has_corporate_housing excluded as property features, not types
    SELECT x.management_company_id, multi_family, all_properties
      FROM
      (SELECT management_company_id, COUNT(DISTINCT id) as all_properties
          FROM ${apartments.SQL_TABLE_NAME}
          GROUP BY 1) x
      LEFT JOIN
      (SELECT management_company_id, COUNT(DISTINCT id) as multi_family
          FROM ${apartments.SQL_TABLE_NAME}
          WHERE is_income_restricted IS FALSE
          AND is_section8 IS FALSE
          AND is_senior_living IS FALSE
          AND is_student_housing IS FALSE
          AND is_assisted_living IS FALSE
              GROUP BY 1) mf
      ON x.management_company_id = mf.management_company_id
    ;;
  }

  view_label: "ALN Management Company"

  dimension: management_company_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.management_company_id ;;
    hidden: yes
  }

  dimension: multi_family {
    type: number
    sql: ${TABLE}.multi_family ;;
    hidden: yes
  }

  dimension: all_properties {
    type: number
    sql: ${TABLE}.all_properties ;;
    hidden: yes
  }

  dimension: percent_multi_family {
    type: number
    sql: ${multi_family}/${all_properties} ;;
    value_format: "0.0%"
    hidden: no
    group_label: "Industry"
    description: "How much of the Management Company's portfolio is Standard Multifamily? (No student, section 8 or assisted living, etc. units in property)"
  }

}
