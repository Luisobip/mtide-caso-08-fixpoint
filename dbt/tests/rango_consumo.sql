-- piezas_eur tiene que estar en un rango creíble para este negocio (6.865 a 256.6).
select resguardo, piezas_eur from {{ ref('stg_parte') }}
where piezas_eur not between 6.865 and 256.6
