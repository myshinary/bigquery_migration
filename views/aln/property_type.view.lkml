view: property_type {
  view_label: "ALN"
  derived_table: {
    sql:
    SELECT id, STRING_AGG(property_type,', ') as property_types
    FROM
    (SELECT id, 'Assisted Living' as property_type
    FROM `hub__aln_data.apartments`
    WHERE is_assisted_living IS TRUE
    UNION ALL
    SELECT id, 'Income Restricted' as property_type
    FROM `hub__aln_data.apartments`
    WHERE is_income_restricted IS TRUE
    UNION ALL
    SELECT id, 'Section8' as property_type
    FROM `hub__aln_data.apartments`
    WHERE is_section8 IS TRUE
    UNION ALL
    SELECT id, 'Senior Living' as property_type
    FROM `hub__aln_data.apartments`
    WHERE is_senior_living IS TRUE
    UNION ALL
    SELECT id, 'Student Housing' as property_type
    FROM `hub__aln_data.apartments`
    WHERE is_student_housing IS TRUE
    UNION ALL
    SELECT id, 'Standard Multi-Family' as property_type
    FROM `hub__aln_data.apartments`
    WHERE is_income_restricted IS FALSE
    AND is_section8 IS FALSE
    AND is_senior_living IS FALSE
    AND is_student_housing IS FALSE
    AND is_assisted_living IS FALSE) x
    GROUP BY 1;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: property_types_detail {
    type: string
    sql: ${TABLE}.property_types ;;
    label: "Property Type List Detailed"
    group_label: "Property Type"
  }

  dimension: property_types {
    type: string
    sql: CASE WHEN ${TABLE}.property_types LIKE '%,%' THEN 'Mixed Property' ELSE ${TABLE}.property_types END;;
    label: "Property Type List"
    group_label: "Property Type"
  }
}
