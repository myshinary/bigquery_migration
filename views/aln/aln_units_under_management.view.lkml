view: aln_units_under_management {
derived_table: {
  sql:
  SELECT management_company_id, SUM(number_of_units) as units_under_management, COUNT(DISTINCT id) as properties_under_management
    FROM ${apartments.SQL_TABLE_NAME}
    WHERE management_company_id IS NOT NULL
    GROUP BY 1
     ;;
  }

  view_label: "ALN Management Company"

  dimension: management_company_id {
    type: number
    sql: ${TABLE}.management_company_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: units_under_management {
    type: number
    sql: ${TABLE}.units_under_management ;;
    group_label: "TUUM"
  }

  dimension: properties_under_management {
    type: number
    sql: ${TABLE}.properties_under_management ;;
    group_label: "TUUM"
  }

  dimension: units_under_management_tier {
    type: string
    sql: CASE WHEN ${units_under_management} < 1000 THEN '1. <1k' WHEN ${units_under_management} BETWEEN 1000 AND 10000 THEN '2. 1k-10k' WHEN ${units_under_management} BETWEEN 10001 AND 20000 THEN '3. 10k-20k' WHEN ${units_under_management} > 20000 THEN '4. >20k' ELSE NULL END;;
    group_label: "TUUM"
  }

  parameter: units_under_management_rounded_by {
    label: "Round Units By"
    type: unquoted
    allowed_value: {
      label: "Nearest 10"
      value: "1"
    }
    allowed_value: {
      label: "Nearest 50"
      value: "2"
    }
    allowed_value: {
      label: "Nearest 100"
      value: "3"
    }
    allowed_value: {
      label: "Nearest 1,000"
      value: "4"
    }
    allowed_value: {
      label: "Nearest 2,000"
      value: "5"
    }
    allowed_value: {
      label: "Nearest 5,000"
      value: "6"
    }
    allowed_value: {
      label: "Nearest 10,000"
      value: "7"
    }
    group_label: "TUUM"
  }

  dimension: units_under_management_rounded {
    type: number
    sql:
    {% if units_under_management_rounded_by._parameter_value == "1" %}
    ROUND(${units_under_management},-1)
    {% elsif units_under_management_rounded_by._parameter_value == "2" %}
    ROUND(${units_under_management}*2,-3)/2
    {% elsif units_under_management_rounded_by._parameter_value == "3" %}
    ROUND(${units_under_management},-2)
    {% elsif units_under_management_rounded_by._parameter_value == "4" %}
    ROUND(${units_under_management},-3)
    {% elsif units_under_management_rounded_by._parameter_value == "5" %}
    ROUND(${units_under_management}/2,-3)*2
    {% elsif units_under_management_rounded_by._parameter_value == "6" %}
    ROUND(${units_under_management}/5,-3)*5
    {% elsif units_under_management_rounded_by._parameter_value == "7" %}
    ROUND(${units_under_management},-4)
    {% else %}
    ROUND(${units_under_management},-2)
    {% endif %};;
    description: "Units under management rounded to the nearest 100 or amount specified by the Round Units By filter located under TUUM above"
    value_format: "#,##0"
    group_label: "TUUM"
  }

  dimension: units_under_management_normalized_group_ordering {
    type: number
    sql: CASE WHEN ${units_under_management} < 50 THEN "1" WHEN ${units_under_management} BETWEEN 50 AND 54 THEN "2" WHEN ${units_under_management} BETWEEN 55 AND 69 THEN "3" WHEN ${units_under_management} BETWEEN 70 AND 84 THEN "4" WHEN ${units_under_management} BETWEEN 85 AND 99 THEN "5" WHEN ${units_under_management} BETWEEN 100 AND 114 THEN "6" WHEN ${units_under_management} BETWEEN 115 AND 124 THEN "7" WHEN ${units_under_management} BETWEEN 125 AND 149 THEN "8" WHEN ${units_under_management} BETWEEN 150 AND 174 THEN "9" WHEN ${units_under_management} BETWEEN 175 AND 199 THEN "10" WHEN ${units_under_management} BETWEEN 200 AND 249 THEN "11" WHEN ${units_under_management} BETWEEN 250 AND 299 THEN "12" WHEN ${units_under_management} BETWEEN 300 AND 349 THEN "13" WHEN ${units_under_management} BETWEEN 350 AND 399 THEN "14" WHEN ${units_under_management} BETWEEN 400 AND 449 THEN "15" WHEN ${units_under_management} BETWEEN 450 AND 499 THEN "16" WHEN ${units_under_management} BETWEEN 500 AND 549 THEN "17" WHEN ${units_under_management} BETWEEN 550 AND 649 THEN "18" WHEN ${units_under_management} BETWEEN 650 AND 799 THEN "19" WHEN ${units_under_management} BETWEEN 800 AND 999 THEN "20" WHEN ${units_under_management} BETWEEN 1000 AND 1199 THEN "21" WHEN ${units_under_management} BETWEEN 1200 AND 1499 THEN "22" WHEN ${units_under_management} BETWEEN 1500 AND 1999 THEN "23" WHEN ${units_under_management} BETWEEN 2000 AND 2999 THEN "24" WHEN ${units_under_management} BETWEEN 3000 AND 4999 THEN "25" WHEN ${units_under_management} BETWEEN 5000 AND 7999 THEN "26" WHEN ${units_under_management} BETWEEN 8000 AND 14999 THEN "27" WHEN ${units_under_management} BETWEEN 15000 AND 19999 THEN "28" WHEN ${units_under_management} BETWEEN 20000 AND 34999 THEN "29"  WHEN ${units_under_management} >= 35000 THEN "30" ELSE NULL END;;
    hidden: yes
  }

  dimension: units_under_management_normalized_group {
    type: string
    sql: CASE WHEN ${units_under_management} < 50 THEN "<50" WHEN ${units_under_management} BETWEEN 50 AND 54 THEN "45-54" WHEN ${units_under_management} BETWEEN 55 AND 69 THEN "55-69" WHEN ${units_under_management} BETWEEN 70 AND 84 THEN "70-84" WHEN ${units_under_management} BETWEEN 85 AND 99 THEN "85-99" WHEN ${units_under_management} BETWEEN 100 AND 114 THEN "100-114" WHEN ${units_under_management} BETWEEN 115 AND 124 THEN "115-124" WHEN ${units_under_management} BETWEEN 125 AND 149 THEN "125-149" WHEN ${units_under_management} BETWEEN 150 AND 174 THEN "150-174" WHEN ${units_under_management} BETWEEN 175 AND 199 THEN "175-199" WHEN ${units_under_management} BETWEEN 200 AND 249 THEN "200-249" WHEN ${units_under_management} BETWEEN 250 AND 299 THEN "250-299" WHEN ${units_under_management} BETWEEN 300 AND 349 THEN "300-349" WHEN ${units_under_management} BETWEEN 350 AND 399 THEN "350-399" WHEN ${units_under_management} BETWEEN 400 AND 449 THEN "400-449" WHEN ${units_under_management} BETWEEN 450 AND 499 THEN "450-499" WHEN ${units_under_management} BETWEEN 500 AND 549 THEN "500-549" WHEN ${units_under_management} BETWEEN 550 AND 649 THEN "550-649" WHEN ${units_under_management} BETWEEN 650 AND 799 THEN "650-799" WHEN ${units_under_management} BETWEEN 800 AND 999 THEN "800-999" WHEN ${units_under_management} BETWEEN 1000 AND 1199 THEN "1,000-1,199" WHEN ${units_under_management} BETWEEN 1200 AND 1499 THEN "1,200-1,499" WHEN ${units_under_management} BETWEEN 1500 AND 1999 THEN "1,500-1,999" WHEN ${units_under_management} BETWEEN 2000 AND 2999 THEN "2,000-2,999" WHEN ${units_under_management} BETWEEN 3000 AND 4999 THEN "3,000-4,999" WHEN ${units_under_management} BETWEEN 5000 AND 7999 THEN "5,000-7,999" WHEN ${units_under_management} BETWEEN 8000 AND 14999 THEN "8,000-14,999" WHEN ${units_under_management} BETWEEN 15000 AND 19999 THEN "15,000-19,999" WHEN ${units_under_management} BETWEEN 20000 AND 34999 THEN "20,000-34,999" WHEN ${units_under_management} >= 35000 THEN "35,000+" ELSE NULL END;;
    order_by_field: units_under_management_normalized_group_ordering
    description: "Units under management split into 30 relatively equal groups by number of Management Companies"
    group_label: "TUUM"
  }

  measure: total_units_under_management {
    label: "Units"
    type: sum
    sql: ${TABLE}.units_under_management ;;
    group_label: "TUUM"
  }

  measure: total_properties_under_management {
    label: "Properties"
    type: sum
    sql: ${TABLE}.properties_under_management ;;
    group_label: "TUUM"
  }

  #measure: avg_units_under_management {
  #  type: average
  #  sql: ${units_under_management} ;;

  #}
  #
  #measure: median_units_under_management {
  #  type: median
  #  sql: ${units_under_management} ;;

  #}

}
