# Memo para la dirección de FixPoint

## Qué hemos visto

1. El tipo de reparación con menos ingreso por hora es **{{ pregunta_1.tipo_reparacion[0] }}** ({{ pregunta_1.ingreso_hora[0] }} €/h).
2. El técnico que más gasta en piezas por hora es **{{ pregunta_2.tecnico[0] }}** ({{ pregunta_2.piezas_hora[0] }} €/h).
3. El puesto con más incidencias por 100 horas es **{{ pregunta_3.puesto[0] }}** ({{ pregunta_3.incidencias_100h[0] }}).
4. El tipo que más vuelve en garantía es **{{ pregunta_4.tipo_reparacion[0] }}**, con {{ pregunta_4.reaperturas[0] }} reaperturas y un coste estimado de {{ pregunta_4.coste_reaperturas_eur[0] }} €.

## Qué recomendamos

- Revisar el proceso y el precio de **{{ pregunta_4.tipo_reparacion[0] }}**: concentra las reaperturas y {{ pregunta_4.coste_reaperturas_eur[0] }} € de coste medio acumulado.
- Mirar el puesto **{{ pregunta_3.puesto[0] }}** (formación, ergonomía o mix de trabajos): lidera incidencias por hora.
- Contrastar el consumo de piezas de **{{ pregunta_2.tecnico[0] }}** con el resto del equipo.

## Qué no sabemos todavía

- Si cada reapertura del registro cae dentro de los `garantia_dias` del catálogo (el fichero no trae la fecha de la reparación original).
- Si el coste real de la pieza coincide con `coste_medio_eur` o varía por modelo de móvil.
- En la remesa nueva, `piezas_eur` llegó como texto (`22,81 €`); asumimos que tras normalizar en plata el valor es el correcto.

## Cómo se ha hecho

Bronce guarda el parte y las fuentes tal cual. En plata se tipa el parte (incluido el formato europeo de `piezas_eur`) y se deduplican las aperturas reenviadas del taller. El test `ticket_una_apertura` vigila desde ahora que cada ticket se abra una sola vez. El oro resume dimensiones, hecho y las cuatro preguntas de negocio.
