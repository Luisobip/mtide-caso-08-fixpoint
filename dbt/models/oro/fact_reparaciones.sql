{{ config(materialized='table') }}

select
	resguardo,
	cast(fecha as date) as fecha,
	tecnico,
	puesto,
	tipo_reparacion,
	cast(minutos as integer) as minutos,
	cast(piezas_eur as numeric(12, 2)) as piezas_eur,
	cast(importe_eur as numeric(12, 2)) as importe_eur,
	incidencia is not null as con_incidencia
from {{ ref('stg_parte') }}
