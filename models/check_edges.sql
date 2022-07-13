select
    count(*)
from
    {{ ref('edges') }},
    (
        select
            distinct case when a.rudder_id < b.rudder_id then a.rudder_id else b.rudder_id end as first_rudder_id,
            a.edge_a as edge
        from
            {{ ref('edges') }} a
        inner join
            {{ ref('edges') }} b
                on a.edge_a = b.edge_b
        where
            a.rudder_id <> b.rudder_id
    ) ea
where
    (
        edges.edge_a = ea.edge
        or edges.edge_b = ea.edge
    )
    and edges.rudder_id <> ea.first_rudder_id
