select
    rudder_id,
    edge,
    string_agg(edge_label, ', ') as labels
from (
    select
        rudder_id,
        edge_a as edge,
        edge_a_label as edge_label
    from
        {{ ref('edges') }}
    union
    select
        rudder_id,
        edge_b as edge,
        edge_b_label as edge_label
    from
        {{ ref('edges') }}
) c
group by
    rudder_id,
    edge
order by
    rudder_id