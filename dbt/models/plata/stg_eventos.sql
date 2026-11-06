-- PLATA · registro de tickets del taller.
-- Giro: si falla la conexión, la tienda reenvía la apertura con otro evento_id
-- (mismo ticket, mismo tipo, misma hora). No son duplicados exactos: unique(evento_id)
-- no los ve. Nos quedamos con una sola apertura por ticket+ts.
with bruto as (
    select
        evento_id,
        tipo,
        cast(ts as timestamp) as ts,
        ticket,
        imei,
        tipo_reparacion
    from {{ source('bronce', 'eventos') }}
),
dedup as (
    select *
    from bruto
    qualify row_number() over (
        partition by ticket, tipo, ts
        order by evento_id
    ) = 1
)
select
    evento_id,
    tipo,
    ts,
    ticket,
    imei,
    tipo_reparacion
from dedup
