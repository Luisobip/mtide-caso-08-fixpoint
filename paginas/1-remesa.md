<!-- pendiente: borra esta línea cuando empieces a escribir la página -->

# 1 · La remesa nueva

> Qué llegó: la entrega del parte con fecha de carga 2026-03-11.
> ¿Qué venía mal?
> Error de conversión en la linea 36 por los simbolos "€" y ",", solucionado estandarizando el formato a xx.xx
> Cómo lo descubriste: qué test se puso rojo y qué decía.
> al hacer build salía  Conversion Error: Could not convert string '22,81 €' to DOUBLE when casting from source column piezas_eur. Mirando las filas conservadas parecía sospechoso tener un valor en plata que en bronce
> Cómo lo arreglaste en plata, y por qué ahí y no en bronce.
> normalizando el formato con un replace y trim de piezas_eur
> Cierra con una cifra automática, por ejemplo: «plata tiene ahora 656 reparaciones, sin perder ninguna».
