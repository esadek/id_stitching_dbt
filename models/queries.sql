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
    'select distinct ' || a.cn || '::text as edge_a, ''' || a.cn  || ''' as edge_a_label, ' || b.cn || '::text as edge_b, ''' || b.cn  || ''' as edge_b_label from ' ||  a.tn || ' where coalesce(' || a.cn ||  ', '''') <> '''' and coalesce(' || b.cn ||  ', '''') <> ''''' as sql_to_run
from
    columns a
inner join
    columns b 
        on a.tn = b.tn
        and a.cn > b.cn
