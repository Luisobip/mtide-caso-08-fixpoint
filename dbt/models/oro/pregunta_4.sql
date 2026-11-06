-- ¿Qué tipo de reparación se reabre más en garantía y cuánto cuestan esas reaperturas?
with reaperturas as (
    select
        tipo_reparacion,
        count(*) as reaperturas
    from {{ ref('stg_eventos') }}
    where tipo = 'reapertura'
    group by tipo_reparacion
)
select
    r.tipo_reparacion,
    r.reaperturas,
    r.reaperturas * g.coste_medio_eur as coste_reaperturas_eur
from reaperturas r
join {{ ref('stg_garantias') }} g using (tipo_reparacion)
order by r.reaperturas desc, coste_reaperturas_eur desc
