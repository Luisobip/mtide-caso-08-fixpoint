# 3 · Fuentes nuevas

Han llegado dos piezas a bronce: el catálogo `garantias` (días de garantía y coste medio por tipo) y el registro de eventos del taller (`eventos_taller_2026-03-13.json`). En plata quedan {{ stg_eventos.filas }} eventos limpios. Las garantías sirven para valorar el coste de las vueltas; el registro cuenta la vida de cada ticket (apertura → cierre → reapertura).

**El giro.** Cuando falla la conexión, la tienda reenvía la `apertura` con otro `evento_id`, pero el mismo ticket, tipo y hora. Un `unique` sobre `evento_id` no los detecta. En `stg_eventos` me quedo con una sola fila por `ticket + tipo + ts` (`row_number`).

**Test protagonista.** Regla: *cada ticket se abre una sola vez*. El test singular `ticket_una_apertura` lista los tickets con más de una apertura. Con el registro tal cual devolvía **4** filas (rojo). Tras deduplicar en plata, no devuelve ninguna (verde).

**Pregunta 4.** El tipo que más se reabre en garantía es **{{ pregunta_4.tipo_reparacion[0] }}**, con {{ pregunta_4.reaperturas[0] }} reaperturas y un coste estimado de {{ pregunta_4.coste_reaperturas_eur[0] }} € (reaperturas × coste medio del catálogo). Sin tener en cuenta el giro, las 14 reaperturas y este ranking no cambian, pero el ciclo de vida del ticket no sería fiable: habría 4 tickets con dos aperturas y el test protagonista seguiría en rojo.
