view: in_house_maintenance {
  derived_table: {
    sql:
      SELECT DISTINCT corporate_entity_id as id
FROM `happyco-internal-systems.hub__aln_data.contacts`
WHERE LOWER(job_title) LIKE '%maintenance%'
      ;;
  }

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: yes
  }

}
