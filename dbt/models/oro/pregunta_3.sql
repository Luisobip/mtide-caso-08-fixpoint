with agregados as (
	select
		puesto,
		sum(incidencias) as incidencias,
		sum(horas) as horas
	from {{ ref('incidencias') }}
	where puesto is not null
	group by puesto
)

select
	puesto,
	incidencias * 100.0 / nullif(horas, 0) as incidencias_100h
from agregados
where horas > 0
order by incidencias_100h desc
