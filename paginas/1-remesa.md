
# 1 · La remesa nueva

Llegó una entrega nueva del parte con fecha de carga `2026-03-11`: unos diez días más de reparaciones en `bronce/parte/fecha_carga=2026-03-11/`.

En esa remesa, `piezas_eur` venía con formato de hoja de cálculo «bonita»: valores como `22,81 €` (coma decimal y símbolo de euro). La primera entrega usaba números limpios (`21.79`), así que el cast a `DOUBLE` en plata reventaba solo con las filas nuevas.

Lo descubrí al lanzar `dbt build`: el modelo `stg_parte` ni llegaba a construirse. El mensaje era `Conversion Error: Could not convert string '22,81 €' to DOUBLE when casting from source column piezas_eur`. No hubo un test en rojo porque el fallo era de tipado al materializar. Confirmé en bronce, filtrando por `fecha_carga`, que todas las filas de la remesa nueva traían ese formato.

Lo arreglé en `stg_parte.sql` (plata): quité el sufijo ` €`, cambié la coma por punto y convertí con `try_cast`. El arreglo va en plata y no en bronce porque bronce es la prueba de lo que se recibió; la limpieza y tipado son trabajo del lakehouse.

Tras el arreglo, `dbt build` queda en verde y plata tiene ahora {{ stg_parte.filas }} reparaciones, sin perder ninguna (`filas_conservadas` y `rango_consumo` pasan).
