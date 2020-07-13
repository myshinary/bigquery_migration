view: properties_billed_on_unit_type {
  derived_table: {
    sql:
    SELECT o.id, bp.billed_on, ct.unit_type
    FROM `happyco-internal-systems.hub__property_provisioning.orders` o
    LEFT JOIN
    (SELECT properties_plan_id, billed_on
    FROM
    (SELECT *, MAX(revision) OVER (PARTITION BY properties_plan_id) as last_revision
    FROM `happyco-internal-systems.hub__orders.properties_billing_profiles`) x
    WHERE revision = last_revision) bp
    ON o.plan_id = bp.properties_plan_id
    LEFT JOIN
    (SELECT properties_plan_id, unit_type
    FROM
    (SELECT *, MAX(revision) OVER (PARTITION BY properties_plan_id) as last_revision
    FROM `happyco-internal-systems.hub__orders.properties_contract_terms_revisions`) x
    WHERE revision = last_revision) ct
    ON o.plan_id = ct.properties_plan_id ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: billed_on {
    type: string
    sql: ${TABLE}.billed_on ;;
    hidden: yes
  }

  dimension: unit_type {
    type: string
    sql: ${TABLE}.unit_type ;;
    hidden: yes
  }
}
