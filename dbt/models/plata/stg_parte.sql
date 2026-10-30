-- PLATA · el parte diario limpio: la limpieza que hiciste en la J3, ahora como modelo dbt.
-- Cada entrega del parte es una carpeta fecha_carga=… en bronce: aquí se leen todas juntas.
with bruto as (
    select *, parse_filename(filename) as archivo
    from {{ source('bronce', 'parte') }}
),
sin_dup as (
    -- una fila por resguardo
    select * from bruto
    qualify row_number() over (partition by resguardo order by fecha_carga desc) = 1
),
mediana_tipo_reparacion as (
    select tipo_reparacion, median(minutos::integer) as minutos_mediana
    from sin_dup
    where minutos::integer between 1 and 480
    group by tipo_reparacion
)
select
    s.resguardo,
    s.fecha::date                                              as fecha,
    upper(trim(s.tecnico))                                         as tecnico,
    s.puesto,
    s.tipo_reparacion,
    case when s.minutos::integer between 1 and 480 then s.minutos::integer
         else round(m.minutos_mediana)::integer end               as minutos,
    not (s.minutos::integer between 1 and 480)                   as minutos_corregido,
    try_cast( -- Could not convert string '22,81 €' to DOUBLE when casting from source column piezas_eur
        replace(replace(trim(s.piezas_eur), ' €', ''), ',', '.') as double
    ) as piezas_eur,
    s.importe_eur::double                                      as importe_eur,
    s.incidencia,
    s.archivo,
    s.fecha_carga
from sin_dup s
join mediana_tipo_reparacion m using (tipo_reparacion)