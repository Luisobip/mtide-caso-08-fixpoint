with agregados as (
	select
		puesto,
		sum(case when con_incidencia then 1 else 0 end) as incidencias,
		sum(minutos) / 60.0 as horas
	from {{ ref('fact_reparaciones') }}
	where puesto is not null
	group by puesto
)

select
	puesto,
	incidencias * 100.0 / nullif(horas, 0) as incidencias_100h
from agregados
where horas > 0
order by incidencias_100h desc
