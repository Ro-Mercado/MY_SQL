-- EXPLICACION ORDER BY https://www.lawebdelprogramador.com/foros/SQL/32816-Ordenar-por-dos-campos-a-la-vez.html
/*
ORDENAR POR DOS CAMPOS A LA VEZ
Publicado por proferay (1 intervención) el 22/09/2017 16:23:26
La pregunta es antigua pero por si alguien desemboca acá, respondo.

Yo tenía que hacer lo mismo. Ordenar por una columna en forma Ascendente pero que a la vez, la otra columna quedara en forma Descendente.

Ejemplo de Sentencia SQL:

SELECT * FROM tabla1 WHERE condicion/es ORDER BY Columna1, Columna2

Estructura de la tabla1:
id
Columna1
Columna2
Columna3

Datos(5 registros de ejemplo):
id - Columna1 - Columna2 - Columna3
1 - 33333333 - ZZZZZZZZZ - Cualquier
2 - 55555555 - BBBBBBBB - dato que
3 - 99999999 - AAAAAAAAA - no tenga
4 - 55500000 - 4CCCCCC - relacion
5 - 55500000 - 3CCCCCC - con un orden
6 - 55500000 - 2CCCCCC - determinado

Ejemplo 1:
SELECT * FROM tabla1 WHERE condicion/es ORDER BY Columna1 ASC, Columna2 ASC;

Resultado:
id - Columna1 - Columna2 - Columna3
1 - 33333333 - ZZZZZZZZZ - Cualquier
6 - 55500000 - 2CCCCCC - determinado
5 - 55500000 - 3CCCCCC - con un orden
4 - 55500000 - 4CCCCCC - relacion
2 - 55555555 - BBBBBBBB - dato que
3 - 99999999 - AAAAAAAAA - no tenga

Ejemplo 2:
SELECT * FROM tabla1 WHERE condicion/es ORDER BY Columna1 DESC, Columna2 ASC;

Resultado:
id - Columna1 - Columna2 - Columna3
3 - 99999999 - AAAAAAAAA - no tenga
2 - 55555555 - BBBBBBBB - dato que
6 - 55500000 - 2CCCCCC - determinado
5 - 55500000 - 3CCCCCC - con un orden
4 - 55500000 - 4CCCCCC - relacion
1 - 33333333 - ZZZZZZZZZ - Cualquier

Ejemplo 3:
SELECT * FROM tabla1 WHERE condicion/es ORDER BY Columna1 DESC, Columna2 DESC;

Resultado:
id - Columna1 - Columna2 - Columna3
3 - 99999999 - AAAAAAAAA - no tenga
2 - 55555555 - BBBBBBBB - dato que
4 - 55500000 - 4CCCCCC - relacion
5 - 55500000 - 3CCCCCC - con un orden
6 - 55500000 - 2CCCCCC - determinado
1 - 33333333 - ZZZZZZZZZ - Cualquier

Notese el orden en que se indica la ordenación: Siempre se ordenará primero la columna1 del ejemplo, y luego, en los casos en que la columna1 tenga registros repetidos, ordenará según lo solicitado la información de la columna2.

Si quisiéramos hacerlo a la inversa (que primero ordene la columna2 y luego la columna1, entonces la sentencia debería ser así:

Ejemplo:
SELECT * FROM tabla1 WHERE condicion/es ORDER BY Columna2 ASC, Columna1 ASC;

Y el resultado, en este caso, sería:
id - Columna1 - Columna2 - Columna3
3 - 99999999 - AAAAAAAAA - no tenga
2 - 55555555 - BBBBBBBB - dato que
6 - 55500000 - 2CCCCCC - determinado
5 - 55500000 - 3CCCCCC - con un orden
4 - 55500000 - 4CCCCCC - relacion
1 - 33333333 - ZZZZZZZZZ - Cualquier

Dado que en el ejemplo, la columna2 posee todos datos diferentes entre sí, la columna 1 no se ordena en forma Ascendente (como se solicitó) porque indicamos que primero ordene por la columna2.

Al ordenar por la columna2, encuentra un solo registro con "AAAAAAAAA" que en columna1 contiene "99999999". No puede ordenar ese único dato.

Pero modifiquemos los datos de la columna2 de esta manera:

id - Columna1 - Columna2 - Columna3
1 - 33333333 - AAAAAAAAA - Cualquier
2 - 55555555 - BBBBBBBB - dato que
3 - 99999999 - AAAAAAAAA - no tenga
4 - 55500000 - BBBBBBBB - relacion
5 - 55500000 - AAAAAAAAA - con un orden
6 - 55500000 - BBBBBBBB - determinado

y el resultado de la sentencia:
SELECT * FROM tabla1 WHERE condicion/es ORDER BY Columna2 ASC, Columna1 ASC;

Sería:
id - Columna1 - Columna2 - Columna3
1 - 33333333 - AAAAAAAAA - Cualquier
3 - 99999999 - AAAAAAAAA - no tenga
5 - 55500000 - AAAAAAAAA - con un orden
4 - 55500000 - BBBBBBBB - relacion
6 - 55500000 - BBBBBBBB - determinado
2 - 55555555 - BBBBBBBB - dato que
*/
-- EJERCICIO 2 EXTRA: 
/*-- WHERE DATE_FORMAT(fecha_pago, "%Y") = 2008*/
-- CONSULTAS MULTITABLA COMPOSIION INTERNA (4)
/*select cl.nombre_cliente, emp.nombre, o.ciudad from cliente cl, empleado emp, oficina o, pago p
where 
cl.codigo_cliente=p.codigo_cliente
and cl.codigo_empleado_rep_ventas=emp.codigo_empleado
and emp.codigo_oficina=o.codigo_oficina
group by cl.nombre_cliente;

select cl.nombre_cliente, emp.nombre, o.ciudad from cliente cl, empleado emp, oficina o 
where exists (
	select cliente.codigo_cliente from cliente
    inner join pago on cliente.codigo_cliente=pago.codigo_cliente)
and cl.codigo_empleado_rep_ventas=emp.codigo_empleado
and emp.codigo_oficina=o.codigo_oficina
group by cl.nombre_cliente;


*/