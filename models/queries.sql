with columns as (
    select
        table_catalog || '.' || table_schema || '.' || table_name as tn,
        column_name as cn
    from
        {{ source('information_schema', 'columns') }}
    where
        lower(column_name) in {{ var('id-columns') }}
)

select
    'select distinct lower(' || a.cn || ') as edge_a, lower(''' || a.cn  || ''') as edge_a_label, lower(' || b.cn || ') as edge_b, lower(''' || b.cn  || ''') as edge_b_label from ' ||  a.tn || ' where coalesce(' || a.cn ||  ', '''') <> '''' and coalesce(' || b.cn ||  ', '''') <> ''''' as sql_to_run
from
    columns a
inner join
    columns b 
        on a.tn = b.tn
        and a.cn > b.cn
