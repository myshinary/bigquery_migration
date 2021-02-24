view: contacts_property_managers {
  derived_table: {
    sql:
    SELECT id, associated_entity_id, name, email
      FROM `happyco-internal-systems.hub__aln_data.contacts`
      WHERE job_title = 'Manager'
    ;;
  }

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: associated_entity_id {
    type: string
    sql: ${TABLE}.associated_entity_id ;;
    hidden: yes
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    hidden: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    hidden: yes
  }
}
