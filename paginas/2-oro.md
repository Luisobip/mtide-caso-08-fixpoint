# 2 · El oro

La estrella del lakehouse es `fact_reparaciones`: una fila por reparación (`resguardo`), con fecha, técnico, puesto, tipo, minutos, piezas, importe e incidencia. Tiene {{ fact_reparaciones.filas }} filas y se apoya en tres dimensiones: `dim_tecnico`, `dim_puesto` y `dim_tipo_reparacion`.

**Pregunta 1.** El tipo de reparación con menos ingreso por hora de trabajo es **{{ pregunta_1.tipo_reparacion[0] }}**, con {{ pregunta_1.ingreso_hora[0] }} €/hora.

**Pregunta 2.** El técnico que más gasta en piezas por hora es **{{ pregunta_2.tecnico[0] }}**, con {{ pregunta_2.piezas_hora[0] }} € de piezas por hora.

**Pregunta 3.** El puesto con más incidencias por cada 100 horas es **{{ pregunta_3.puesto[0] }}**, con {{ pregunta_3.incidencias_100h[0] }} incidencias/100 h.

Con la remesa nueva (~25 % más de datos) las tres preguntas se recalculan sobre las {{ fact_reparaciones.filas }} reparaciones. El ranking puede moverse un poco, pero la lógica de negocio es la misma: ingreso/hora por tipo, piezas/hora por técnico e incidencias/100 h por puesto, ahora con ambas entregas del parte.
