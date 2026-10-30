select distinct tecnico
from {{ ref('stg_parte') }}