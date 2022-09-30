-- 1. Obtener los datos completos de los empleados.
select * from empleado;
-- 2. Obtener los datos completos de los departamentos.
select * from departamento;
-- 3. Listar el nombre de los departamentos.
select nombre_depto from departamento;
--  4. Obtener el nombre y salario de todos los empleados.
select nombre,salario from empleado;
-- 5. Listar todas las comisiones.
select comision from empleado;
-- 6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
select * from empleado where cargo = 'Secretaria';
-- 7. Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
select * from empleado 
where cargo = 'Vendedor'
order by nombre;
-- 8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
select salario,nombre, cargo from empleado
order by salario;
-- 9. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
select nombre, cargo from empleado;
-- 10. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
select salario , comision from empleado
where id_depto = 2000
order by comision;
-- 11. Obtener el valor total a pagar que resulta de sumar el salario y la comisión de los
-- empleados del departamento 3000 una bonificación de 500, en orden alfabético del empleado.
-- sentencia aparte( LOS QUE PERTENECEN AL DPTO 3000)
SELECT nombre, salario, comision from empleado
where id_depto=3000;
-- ------------------------------------
select nombre NOMBRE,SUM(salario+comision+500) PAGAR from empleado
where id_depto = 3000
group by salario, comision
Order by nombre;
-- 12. Muestra los empleados cuyo nombre empiece con la letra J.
select nombre NOMBRE from empleado
where nombre like 'J%'
order by nombre;
-- 13.  Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos empleados que tienen comisión superior a 1000.
select nombre NOMBRE, salario SALARIO, comision COMISION, SUM(salario+comision) SALARIO_TOTAL FROM empleado
where comision >1000
group by nombre,salario, comision;
-- 14. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
select nombre NOMBRE, salario SALARIO, comision COMISION, SUM(salario+comision) SALARIO_TOTAL FROM empleado
where comision=0
group by nombre,salario, comision;
-- 15. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
select nombre NOMBRE, salario SALARIO, comision COMISION, SUM(salario+comision) SALARIO_TOTAL FROM empleado
where comision>salario
group by nombre,salario, comision;
-- 16. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
select nombre NOMBRE, salario SALARIO, comision COMISION FROM empleado
where comision<=(salario*0.3);
-- 17. Hallar los empleados cuyo nombre no contiene la cadena “MA”
select nombre NOMBRE from empleado
where nombre not like'%ma%';
-- ------------------------------------------- DEPARTAMENTOS--------------------------------
-- 18. Obtener los nombres de los departamentos que sean “Ventas” ,“Investigación” y ‘Mantenimiento.
SELECT nombre_depto NOMBRE_DEPARTAMENTOS from departamento
where nombre_depto = 'VENTAS' or nombre_depto ='INVESTIGACIÓN' or nombre_depto ='MANTENIMIENTO';
-- 19. Ahora obtener los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni ‘Mantenimiento.
SELECT nombre_depto NOMBRE_DEPARTAMENTOS from departamento
where nombre_depto <> 'VENTAS' and nombre_depto <>'INVESTIGACIÓN' and nombre_depto <>'MANTENIMIENTO'
group by nombre_depto;
-- 20. Mostrar el salario más alto de la empresa.
select nombre, max(salario) from empleado;

-- 21. Mostrar el nombre del último empleado de la lista por orden alfabético.
select max(nombre) ULTIMO_EMPLEADO from empleado;
--  (NO  HACE FALTA) order by nombre;
-- 22. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
SELECT nombre NOM_MAX, max(salario) SALARIO_MÁS_ALTO, min(salario) SALARIO_MÁS_BAJO, (max(salario)-min(salario) ) DIFERENCIA_SALARIOS
 from empleado;
 -- where salario=(select min(salario) from empleado);
 
-- 23. Hallar el salario promedio por departamento. (sum(e.salario)/count(*))= AVG(e.salario)
select d.nombre_depto,  AVG(e.salario) SALARIO_PROMEDIO
from departamento d, empleado e
where d.id_depto = e.id_depto
group by d.nombre_depto;

-- Consultas con HAVING
-- 24. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
select d.nombre_depto NOMBRE_DEPARTAMENTO, count(*) CANTIDAD_EMPLEADOS
from departamento d, empleado e
where d.id_depto = e.id_depto
group by d.nombre_depto
having count(*)>3;

-- 25. Mostrar el código y nombre de cada jefe, junto al número de empleados que dirige. Solo los que tengan más de dos empleados (2 incluido).
SELECT nombre, cod_jefe,count(cod_jefe) as 'Numero de Empleados'
	FROM empleado
	GROUP BY cod_jefe 
	HAVING count(cod_jefe)>=2;

/*SELECT d.codigo_director, e.nombre NOMBRE_JEFE, d.nombre_depto NOMBRE_DEPARTAMENTO, count(*) CANTIDAD_EMPLEADOS
from departamento d, empleado e
where d.codigo_director = e.cod_jefe
and e.nombre like 'Jefe%'
group by e.nombre
having count(*)>=2;*/

-- 26. Hallar los departamentos que no tienen empleados
select d.nombre_depto, count(cod_jefe)
from empleado , departamento d
GROUP BY cod_jefe
HAVING count(cod_jefe)=0;

-- Consulta con Subconsulta
-- 27. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento.
select e.nombre, e.salario, e.comision, e.cargo, e.id_depto, d.nombre_depto, d.ciudad, d.codigo_director from empleado e, departamento d
where salario>=( select AVG(salario) from empleado ) and e.id_depto=d.id_depto
order by  e.id_depto;
