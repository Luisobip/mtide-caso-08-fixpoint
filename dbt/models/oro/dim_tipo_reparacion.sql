select distinct tipo_reparacion
from {{ ref('stg_parte') }}