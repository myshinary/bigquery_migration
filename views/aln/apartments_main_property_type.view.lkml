view: apartments_main_property_type {
view_label: "ALN"
  derived_table: {
    sql:
    --has_short_term_leases and has_corporate_housing excluded as property features, not types
    WITH type_filtering AS (
    SELECT property_type_filter
    FROM
    (SELECT CASE WHEN {% if apartments.is_income_restricted._is_filtered %} {% condition apartments.is_income_restricted %} TRUE {% endcondition %} {% else %} TRUE {% endif %} IS TRUE THEN 'Income Restricted' ELSE null END as property_type_filter
    UNION ALL
    SELECT CASE WHEN {% if apartments.is_section8._is_filtered %} {% condition apartments.is_section8 %} TRUE {% endcondition %} {% else %} TRUE {% endif %} IS TRUE THEN 'Section8' ELSE null END as property_type_filter
    UNION ALL
    SELECT CASE WHEN {% if apartments.is_senior_living._is_filtered %} {% condition apartments.is_senior_living %} TRUE {% endcondition %} {% else %} TRUE {% endif %} IS TRUE THEN 'Senior Living' ELSE null END as property_type_filter
    UNION ALL
    SELECT CASE WHEN {% if apartments.is_student_housing._is_filtered %} {% condition apartments.is_student_housing %} TRUE {% endcondition %} {% else %} TRUE {% endif %} IS TRUE THEN 'Student Housing' ELSE null END as property_type_filter
    UNION ALL
    SELECT CASE WHEN {% if apartments.is_assisted_living._is_filtered %} {% condition apartments.is_assisted_living %} TRUE {% endcondition %} {% else %} TRUE {% endif %} IS TRUE THEN 'Assisted Living' ELSE null END as property_type_filter)
    WHERE property_type_filter IS NOT NULL
    ),

    property_types AS (

    SELECT management_company_id, id, 'Standard Multi-Family' as type
    FROM `hub__aln_data.apartments`
    WHERE is_income_restricted IS FALSE
    AND is_section8 IS FALSE
    AND is_senior_living IS FALSE
    AND is_student_housing IS FALSE
    AND is_assisted_living IS FALSE
    --AND has_short_term_leases IS FALSE
    --AND has_corporate_housing IS FALSE
    UNION ALL
    SELECT management_company_id, id, type
    FROM
    (SELECT management_company_id, id, 'Income Restricted' as type
    FROM `hub__aln_data.apartments`
    WHERE is_income_restricted IS TRUE
    UNION ALL
    SELECT management_company_id, id, 'Section8' as type
    FROM `hub__aln_data.apartments`
    WHERE is_section8 IS TRUE
    UNION ALL
    SELECT management_company_id, id, 'Senior Living' as type
    FROM `hub__aln_data.apartments`
    WHERE is_senior_living IS TRUE
    UNION ALL
    SELECT management_company_id, id, 'Student Housing' as type
    FROM `hub__aln_data.apartments`
    WHERE is_student_housing IS TRUE
    UNION ALL
    SELECT management_company_id, id, 'Assisted Living' as type
    FROM `hub__aln_data.apartments`
    WHERE is_assisted_living IS TRUE
    /*UNION
    SELECT management_company_id, id, 'Has Short Term Leases' as type
    FROM aln_data.apartments
    WHERE has_short_term_leases IS TRUE
    UNION
    SELECT management_company_id, id, 'Has Corporate Housing' as type
    FROM aln_data.apartments
    WHERE has_corporate_housing IS TRUE*/
    ) x
    WHERE type IN (SELECT property_type_filter FROM type_filtering)
    ),

    find_type_coverage AS (
    SELECT x.management_company_id, x.type, x.type_count, y.total_properties, x.type_count/y.total_properties as portfolio_coverage
    FROM
    (SELECT management_company_id, type, COUNT(DISTINCT id) as type_count
    FROM property_types
    GROUP BY 1,2) x
    JOIN
    (SELECT management_company_id, COUNT(DISTINCT id) as total_properties
    FROM property_types
    GROUP BY 1) y
    ON x.management_company_id = y.management_company_id
    )

    SELECT management_company_id, CASE WHEN main_type_count > 1 THEN 'Mixed Portfolio' ELSE main_types END as main_property_type, main_types as main_property_type_list
    FROM
    (SELECT management_company_id, STRING_AGG(main_type,', ') as main_types, COUNT(0) as main_type_count
    FROM
    (SELECT management_company_id, CASE WHEN portfolio_coverage = MAX(portfolio_coverage) OVER (PARTITION BY management_company_id) THEN type ELSE NULL END as main_type
    FROM find_type_coverage) x1
    GROUP BY 1) x2
    ;;
  }

  dimension: management_company_id {
    type: string
    sql: ${TABLE}.management_company_id ;;
    hidden: yes
  }

  dimension: main_property_type {
    type: string
    sql: ${TABLE}.main_property_type ;;
    hidden: no
    group_label: "Management Company"
  }

  dimension: main_property_type_list {
    type: string
    sql: ${TABLE}.main_property_type_list ;;
    hidden: no
    group_label: "Management Company"
  }

  #measure: count {
  #  type: count
  #  drill_fields: []
  #}
}
