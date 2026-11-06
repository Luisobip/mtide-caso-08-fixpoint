-- Test protagonista: cada ticket se abre una sola vez.
-- Devuelve los tickets con más de una apertura (incumplen la regla).
select
    ticket,
    count(*) as n_aperturas
from {{ ref('stg_eventos') }}
where tipo = 'apertura'
group by ticket
having count(*) > 1
