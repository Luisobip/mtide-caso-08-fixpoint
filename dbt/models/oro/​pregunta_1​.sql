select
	tipo_reparacion,
	sum(ingreso) / nullif(sum(horas_trabajo), 0) as ingreso_hora
from {{ ref('stg_parte') }}
group by tipo_reparacion
order by ingreso_hora asc
