-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
select nombre from producto;
-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
select nombre, precio from producto;
-- 3. Lista todas las columnas de la tabla producto.
select * from producto;
-- 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
select nombre, round(precio) as PRECIO_REDONDEADO from producto;
-- 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
select * from fabricante;
-- ---------
select p.codigo, p.nombre, p.precio, p.codigo_fabricante, f.nombre 
from producto p, fabricante f
where f.codigo=p.codigo_fabricante
order by p.codigo;
-- 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
select codigo_fabricante from producto
group by codigo_fabricante;
-- 7. Lista los nombres de los fabricantes ordenados de forma ascendente.
select nombre from fabricante
order by nombre ;
-- 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
-- https://www.lawebdelprogramador.com/foros/SQL/32816-Ordenar-por-dos-campos-a-la-vez.html
select nombre,precio from producto
order by nombre asc, precio desc;
-- 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
select * from fabricante limit 5;
-- 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select nombre, precio from producto 
order by precio asc
limit 1;
-- 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select nombre, precio from producto 
order by precio desc
limit 1;
-- 12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
select nombre from producto
where precio<=120;
-- 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
select nombre,precio from producto 
where precio between 60 and 200;
-- 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
select * from producto
where codigo_fabricante in (1,3,5);
-- 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
select * from producto
where nombre like '%Portátil%';

-- ---------------------------------Consultas Multitabla------------------------------
-- 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
select p.codigo as CODIGO_PRODUCTO, p.nombre as NOMBRE_PRODUCTO, p.codigo_fabricante as CODIGO_FABRICANTE, f.nombre AS NOMBRE_FABRICANTE
from producto p, fabricante f
where f.codigo=p.codigo_fabricante;
-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
select p.codigo as CODIGO_PRODUCTO, p.nombre as NOMBRE_PRODUCTO, p.codigo_fabricante as CODIGO_FABRICANTE, f.nombre AS NOMBRE_FABRICANTE
from producto p, fabricante f
where f.codigo=p.codigo_fabricante
order by f.nombre;
-- 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select  p.nombre as NOMBRE_PRODUCTO, p.precio as PRECIO_PRODUCTO, f.nombre AS NOMBRE_FABRICANTE
from producto p, fabricante f
where f.codigo=p.codigo_fabricante 
order by precio asc
limit 1;

-- 4. Devuelve una lista de todos los productos del fabricante Lenovo.
select p.codigo as CODIGO_PRODUCTO, p.nombre as NOMBRE_PRODUCTO,p.precio as PRECIO_PRODUCTO, p.codigo_fabricante as CODIGO_FABRICANTE, f.nombre AS NOMBRE_FABRICANTE
from producto p, fabricante f
where f.codigo=p.codigo_fabricante and f.nombre='Lenovo';
-- 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
select p.codigo as CODIGO_PRODUCTO, p.nombre as NOMBRE_PRODUCTO,p.precio as PRECIO_PRODUCTO, p.codigo_fabricante as CODIGO_FABRICANTE, f.nombre AS NOMBRE_FABRICANTE
from producto p, fabricante f
where f.codigo=p.codigo_fabricante and f.nombre='Crucial' and p.precio>200;
-- 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
select p.codigo as CODIGO_PRODUCTO, p.nombre as NOMBRE_PRODUCTO,p.precio as PRECIO_PRODUCTO, p.codigo_fabricante as CODIGO_FABRICANTE, f.nombre AS NOMBRE_FABRICANTE
from producto p, fabricante f
where f.codigo=p.codigo_fabricante and f.nombre in ('Asus','Hewlett-Packard');
-- 7.Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180. 
-- Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
/*https://www.lawebdelprogramador.com/foros/SQL/32816-Ordenar-por-dos-campos-a-la-vez.html*/
select p.nombre, p.precio, f.nombre
from producto p, fabricante f
where p.precio>=180 and p.codigo_fabricante=f.codigo
order by p.precio desc, p.nombre asc;
select * from producto;

-- Consultas Multitabla
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
-- 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos
-- fabricantes que no tienen productos asociados.
SELECT * FROM fabricante f
left outer join producto p
	on f.codigo=p.codigo_fabricante;
    
    -- --->-- Retorna los fabricants que fabricantes que tienen asociado un producto
/*select * from fabricante f
right outer join producto p
on p.codigo_fabricante=f.codigo;*/

-- 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado. 
select * from fabricante f
where not exists(select codigo_fabricante from producto p
				where f.codigo=p.codigo_fabricante);
  /*
  SELECT * FROM fabricante f WHERE NOT EXISTS (SELECT p.codigo_fabricante FROM producto p WHERE p.codigo_fabricante = f.codigo);
otra forma(no tan buena por lo que dijeron):
SELECT * FROM fabricante f LEFT JOIN producto p ON p.codigo_fabricante = f.codigo WHERE p.codigo_fabricante IS NOT NULL;

  */          
                    
-- Subconsultas (En la cláusula WHERE) Con operadores básicos de comparación
--  1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
select * from producto p
where exists(select f.codigo from fabricante f
				where f.codigo=p.codigo_fabricante and f.nombre='Lenovo');
	/*select * from producto where codigo_de_fabricante=(select codigo from fabricante where fabricante='Lenovo');*/
--  2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
select * from producto p
where p.precio=(select p.precio from producto p,fabricante f
				where f.codigo=p.codigo_fabricante and f.nombre='Lenovo'
                order by precio desc
				limit 1);
--  3. Lista el nombre del producto más caro del fabricante Lenovo.
select p.nombre as NOMBRE_DEL_PRODUCTO_LENOVO_MÁS_CARO from producto p, fabricante f
where p.codigo_fabricante=f.codigo and f.nombre='Lenovo'
order by p.precio desc limit 1 ;
--  4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.

select * from producto p, fabricante f
where p.codigo_fabricante=f.codigo and f.nombre='Asus' and p.precio>(SELECT AVG(p.precio) from producto p, fabricante f
																	where p.codigo_fabricante=f.codigo and f.nombre='Asus');

-- Subconsultas con IN y NOT IN
--  1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
select codigo,nombre as NOMBRE_FABRICANTE_CON_PRODUCTOS from fabricante 
where codigo in (select codigo_fabricante from producto) ;
/*SELECT f.nombre FROM fabricante f WHERE f.nombre IN (SELECT f.nombre FROM fabricante f INNER JOIN producto p WHERE p.codigo_fabricante = f.codigo);
*/

-- 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN). Consulté :https://thedevelopmentstages.com/como-utilizar-el-operador-not-in-en-sentencias-sql/
select codigo,nombre as NOMBRE_FABRICANTE_CON_PRODUCTOS from fabricante 
where codigo not in (select codigo_fabricante from producto) group by nombre;

-- Subconsultas (En la cláusula HAVING)
-- 1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
select f.nombre , count(*) as CANTIDAD_DE_PRODUCTOS_IGUALES_A_LENOVO from fabricante f, producto p
where f.codigo=p.codigo_fabricante
group by f.nombre
having count(*)=(select count(*) from producto p, fabricante f
				where f.codigo=p.codigo_fabricante and f.nombre='Lenovo') and f.nombre<>'Lenovo'; -- and f.nombre<>'Lenovo' (para queno salga el campo lenovo)

-- OTRA SOLUCIÓN (Pablo Pizarro)
select f.nombre from fabricante f where f.codigo in(select p.codigo_fabricante 
from producto p
group by p.codigo_fabricante 
having count(p.codigo_fabricante)=(
select count(*) from producto 
where codigo_fabricante=(
select codigo 
from fabricante 
where nombre="Lenovo"))and p.codigo_fabricante<>(select codigo from fabricante where nombre="Lenovo"));

