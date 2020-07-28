view: management_company_main_property_class {
  derived_table: {
    sql:
      WITH find_main_class AS (
        SELECT management_company_id, class, count, total, rn, ROW_NUMBER() OVER (PARTITION BY management_company_id ORDER BY unknown_exclude_step_1 DESC) as rn_2
        FROM
        (SELECT management_company_id, class, count, total, rn, CASE WHEN (classes > 1 AND class = 'Unknown') THEN rn ELSE total END as unknown_exclude_step_1
        FROM
        (SELECT management_company_id, class, count, SUM(count) OVER (PARTITION BY management_company_id) as total, ROW_NUMBER() OVER (PARTITION BY management_company_id ORDER BY count DESC) as rn, COUNT(0) OVER (PARTITION BY management_company_id) as classes
        FROM
        (SELECT management_company_id, class, COUNT(DISTINCT id) as count
        FROM
        (SELECT id, COALESCE(pricing_tier,'Unknown') as class, management_company_id
        FROM ${apartments.SQL_TABLE_NAME}
        WHERE management_company_id IS NOT NULL) x1
        GROUP BY 1,2) x2) x3) x4
        )

        SELECT COALESCE(include_unknown.management_company_id, exclude_unknown.management_company_id) as management_company_id, include_unknown.class as include_unknown_class, include_unknown.coverage as include_unknown_coverage, exclude_unknown.class as exclude_unknown_class, exclude_unknown.coverage as exclude_unknown_coverage
        FROM
        (SELECT management_company_id, class, count, total, count/total as coverage
        FROM find_main_class
        WHERE rn = 1) include_unknown
        LEFT JOIN
        (SELECT management_company_id, class, count, total, count/total as coverage
        FROM find_main_class
        WHERE rn_2 = 1) exclude_unknown
        ON include_unknown.management_company_id = exclude_unknown.management_company_id
         ;;
  }

  view_label: "ALN Management Company"

  dimension: management_company_id {
    type: number
    sql: ${TABLE}.management_company_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: include_unknown_class {
    type: string
    sql: ${TABLE}.include_unknown_class ;;
    hidden: yes
  }

  dimension: exclude_unknown_class {
    type: string
    sql: ${TABLE}.exclude_unknown_class ;;
    hidden: yes
  }

  dimension: include_unknown_coverage {
    type: number
    sql: ${TABLE}.include_unknown_coverage ;;
    hidden: yes
    value_format: "0.0%"
  }

  dimension: exclude_unknown_coverage {
    type: number
    sql: ${TABLE}.exclude_unknown_coverage ;;
    hidden: yes
    value_format: "0.0%"
  }

  parameter: exclude_unknown_main_class {
    type: unquoted
    allowed_value: {
      label: "Yes"
      value: "Exclude"
    }
    allowed_value: {
      label: "No"
      value: "Include"
    }
    group_label: "Class"
  }

  dimension: main_property_class {
    type: string
    sql:
    {% if exclude_unknown_main_class._parameter_value == 'Exclude' %}
      ${exclude_unknown_class}
    {% elsif exclude_unknown_main_class._parameter_value == 'Include' %}
      ${include_unknown_class}
    {% else %}
      ${include_unknown_class}
    {% endif %};;
    group_label: "Class"
  }

  dimension: main_property_class_coverage {
    type: number
    sql:
    {% if exclude_unknown_main_class._parameter_value == 'Exclude' %}
      ${exclude_unknown_coverage}
    {% elsif exclude_unknown_main_class._parameter_value == 'No' %}
      ${include_unknown_coverage}
    {% else %}
      ${include_unknown_coverage}
    {% endif %};;
    value_format: "0.0%"
    group_label: "Class"
  }
}
