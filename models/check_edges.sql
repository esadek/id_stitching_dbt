select
    count(*)
from
    {{ ref('id_graph') }},
    (
        select
            distinct case when a.rudder_id < b.rudder_id then a.rudder_id else b.rudder_id end as first_rudder_id,
            a.edge_a as edge
        from
            {{ ref('id_graph') }} a
        inner join
            {{ ref('id_graph') }} b
                on a.edge_a = b.edge_b
        where
            a.rudder_id <> b.rudder_id
    ) ea
where
    (
        id_graph.edge_a = ea.edge
        or id_graph.edge_b = ea.edge
    )
    and id_graph.rudder_id <> ea.first_rudder_id
