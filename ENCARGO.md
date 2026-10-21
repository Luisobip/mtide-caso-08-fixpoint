# Caso 08 · FixPoint — el encargo

> Negocio y datos **ficticios**, creados para la asignatura. Es tu mismo caso de la J3.

## Qué ha pasado desde la J3

En la J3 limpiaste el parte en un cuaderno y contestaste tres preguntas. FixPoint quiere su parte de reparaciones cargado solo, y con el registro de tickets del taller saber **qué reparaciones vuelven en garantía** y cuánto le cuestan.

Ahora conviertes aquel cuaderno en un **lakehouse** de verdad, en tu propio repositorio, y publicas un **portal** que
cuenta lo que has hecho. Cómo preparar el repositorio y el ciclo de trabajo de cada bloque: [README.md](README.md).

## Lo que tienes al empezar

- En bronce, el parte de la J3: `lakehouse/bronce/parte/fecha_carga=2026-03-01/`.
- En `dbt/models/plata/stg_parte.sql`, la limpieza que hiciste en la J3, con unos tests básicos (`_plata.yml`, `dbt/tests/`).
- `dbt build` en verde. La capa oro, vacía: la construyes tú.
- En `paginas/`, las cuatro páginas del portal que escribirás, cada una con un guion de lo que debe contar.

**Bronce no se toca nunca**: todo arreglo va en plata.

---

## Bloque 1 · La remesa nueva · rama `remesa`

1. `python herramientas/sistema_simulado.py remesa`: llega una entrega nueva del parte en `bronce/parte/fecha_carga=2026-03-11/` (unos diez días más de reparaciones).
2. `dbt build --project-dir dbt --profiles-dir dbt`. El coste de las piezas de la remesa viene de una hoja de cálculo «bonita». `dbt build` ni siquiera llega a los tests.
3. Arregla `dbt/models/plata/stg_parte.sql` hasta que `dbt build` quede en verde y el problema esté resuelto (no siempre hay un test que lo grite: a veces tienes que escribirlo tú). Deja un comentario en el SQL: **qué** venía mal y **por qué** lo arreglas así.
4. Escribe `paginas/1-remesa.md`.
5. Pull request en tu repositorio, Actions en verde y lo fusionas.

## Bloque 2 · El oro · rama `oro`

Crea en `dbt/models/oro/` estos modelos, **con estos nombres exactos** (el portal y la jornada de Visualización los leen así):

| Modelo | Qué tiene |
|---|---|
| `dim_tecnico` | una fila por cada valor distinto de `tecnico` |
| `dim_puesto` | una fila por cada valor distinto de `puesto` |
| `dim_tipo_reparacion` | una fila por cada valor distinto de `tipo_reparacion` |
| `fact_reparaciones` | una reparación por fila: `resguardo`, `fecha`, `tecnico`, `puesto`, `tipo_reparacion`, `minutos`, `piezas_eur`, `importe_eur`, `con_incidencia` |
| `pregunta_1` | ¿Qué **tipo de reparación** deja menos ingreso por hora de trabajo? Una fila por `tipo_reparacion`, con `tipo_reparacion` en la primera columna y `ingreso_hora` (€/hora), de menor a mayor |
| `pregunta_2` | ¿Qué **técnico** gasta más en piezas por hora de trabajo? Una fila por `tecnico`, con `tecnico` en la primera columna y `piezas_hora` (€ de piezas por hora), de mayor a menor |
| `pregunta_3` | ¿Qué **puesto de trabajo** acumula más incidencias por cada 100 horas? Una fila por `puesto`, con `puesto` en la primera columna y `incidencias_100h` (incidencias por 100 h), de mayor a menor |

En un `_oro.yml`, sus tests: en las dimensiones, `unique` y `not_null`; en el hecho, `unique` en `resguardo` y `relationships` con cada dimensión.

Escribe `paginas/2-oro.md`: tu estrella y las tres respuestas. Con la remesa nueva (un 25 % más de datos), ¿siguen saliendo las mismas que en la J3? Pull request, verde, fusionas.

## Bloque 3 · Fuentes nuevas · rama `fuentes`

1. `python herramientas/sistema_simulado.py fuentes`: llegan estos ficheros a bronce y quedan declarados en `dbt/models/plata/_fuentes.yml`.

| Fichero | Qué es | Columnas |
|---|---|---|
| `bronce/garantias/garantias.csv` | días de garantía y coste medio de cada tipo de reparación | tipo_reparacion, garantia_dias, coste_medio_eur |
| `bronce/eventos/eventos_taller_2026-03-13.json` | El sistema del taller exporta un registro con la `apertura`, el `cierre` y, si el cliente vuelve, la `reapertura` de cada ticket. | evento_id, tipo (apertura / cierre / reapertura), ts, ticket, imei, tipo_reparacion |

2. **El giro.** Cuando la conexión falla, la tienda **reenvía la apertura con otro `evento_id`**: mismo ticket, mismo tipo, misma hora. No son duplicados exactos, así que un `unique` de `evento_id` no los ve.
3. Modelos de plata: `stg_garantias` y `stg_eventos` (el registro lo lees con `source('bronce', 'eventos')`).
4. **Test protagonista.** **Cada ticket se abre una sola vez.** Escribe un test singular que devuelva los tickets con más de una `apertura`. Rojo con los datos tal cual; verde cuando sepas qué es un duplicado de verdad.
5. **Pregunta 4** (`dbt/models/oro/pregunta_4.sql`): ¿Qué tipo de reparación **se reabre más** en garantía y cuánto cuestan esas reaperturas?
6. Escribe `paginas/3-fuentes.md`. Pull request, verde, fusionas.

## Bloque 4 · El memo · rama `memo`

Escribe `paginas/memo.md`: el memo para la dirección de FixPoint, con las cuatro respuestas citadas con marcas. La comprobación exige que existan `pregunta_1` a `pregunta_4`. Repasa el portal entero antes de fusionar.

---

## Lo que se entrega

- Tu repositorio en tu cuenta, con los cuatro pull requests fusionados y la última ejecución de `main` en verde.
- Tu portal publicado, con sus cuatro páginas escritas, y tu `dbt-docs`.
- La presentación oral (5 minutos): con tu portal en pantalla, el problema de calidad, tu test protagonista, las cuatro respuestas y tu recomendación.
