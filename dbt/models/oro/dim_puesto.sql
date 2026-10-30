select distinct puesto
from {{ ref('stg_parte') }}