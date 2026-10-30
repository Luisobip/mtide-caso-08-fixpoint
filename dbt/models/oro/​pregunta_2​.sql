with gasto_por_tecnico as (
	select
		tecnico,
		sum(piezas_eur) as piezas_eur,
		sum(minutos) / 60.0 as horas_trabajo
	from {{ ref('fact_reparaciones') }}
	group by tecnico
)

select
	tecnico,
	piezas_eur / nullif(horas_trabajo, 0) as piezas_hora
from gasto_por_tecnico
order by piezas_hora desc
