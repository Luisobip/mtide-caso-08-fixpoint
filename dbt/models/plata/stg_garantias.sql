-- PLATA · catálogo de garantía y coste medio por tipo de reparación.
select
    tipo_reparacion,
    garantia_dias::integer as garantia_dias,
    coste_medio_eur::double as coste_medio_eur
from {{ source('bronce', 'garantias') }}
