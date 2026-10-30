select
	tipo_reparacion,
	sum(importe_eur) / nullif(sum(minutos) / 60.0, 0) as ingreso_hora
from {{ ref('fact_reparaciones') }}
group by tipo_reparacion
order by ingreso_hora asc
