{{ config(materialized='incremental', unique_key='original_rudder_id') }}

{% if not is_incremental() %}

    {% set sql_statements = dbt_utils.get_column_values(table=ref('queries'), column='sql_to_run') %}

    select
        row_number() over (order by 1 desc) as rudder_id,
        row_number() over (order by 1 desc) as original_rudder_id,
        edge_a,
        edge_a_label,
        edge_b,
        edge_b_label,
        now() as edge_timestamp
    from (
        {{ ' union '.join(sql_statements) }}
    ) s
    where
        lower(edge_a) not in {{ var('id-denylist') }}
        and lower(edge_b) not in {{ var('id-denylist') }}

{% else %}

    select
        least(f.first_row_id, f2.first_row_id, g.first_row_id, g2.first_row_id) as rudder_id,
        o.original_rudder_id,
        o.edge_a,
        o.edge_a_label,
        o.edge_b,
        o.edge_b_label,
        now() as edge_timestamp
    from
        {{ this }} o
        {% for i in (('f', 'a', 'a'), ('f2', 'b', 'a'), ('g', 'b', 'b'), ('g2', 'a', 'b')) %}
            left outer join (
                select
                    edge_{{ i[1] }},
                    min(rudder_id) as first_row_id
                from
                    {{ this }}
                group by
                    1
            ) {{ i[0] }}
                on o.edge_{{ i[2] }} = {{ i[0] }}.edge_{{ i[1] }}
    {% endfor %}

{% endif %}
