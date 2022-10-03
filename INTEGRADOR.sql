select * from partido;
select * from equipo;
select * from jugador;
select * from estadistica;
-- Teniendo el máximo de asistencias por partido, muestre cuantas veces se logró dicho máximo. Este resultado nos dará la posición del candado (1, 2, 3 o 4)
select count(Asistencias_por_partido) from estadistica
where Asistencias_por_partido=(select max(Asistencias_por_partido) from estadistica);
-- Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición sea centro o esté comprendida en otras posiciones.
select sum(peso) from jugador j, equipo e
where e.conferencia='East' and j.nombre_equipo=e.nombre and j.posicion like '%C%';
-- Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero de jugadores que tiene el equipo Heat.
select count(Asistencias_por_partido) from estadistica e
where Asistencias_por_partido>(select count(*) from jugador where nombre_equipo='Heat' );
-- La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.
select count(temporada) from partido
where temporada like '%99%';
-- La posición del código será igual a la cantidad de jugadores que proceden de Michigan y forman  parte de equipos de la conferencia oeste.
-- Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a 195, y a eso le vamos a sumar 0.9945.
select ((count(j.nombre)/(select count(nombre)from jugador where peso>=195))+0.9945) from jugador j, equipo e
where j.procedencia='Michigan' AND e.nombre=j.nombre_equipo AND e.conferencia='West';

-- Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de sumar: 
-- el promedio de puntos por partido, el conteo de asistencias por partido, y la suma de
-- tapones por partido. Además, este resultado debe ser, donde la división sea central.
SELECT floor((AVG(Puntos_por_partido) + count(Asistencias_por_partido) + SUM(Tapones_por_partido))) AS SUMA_TOTAL FROM estadistica e, equipo eq, jugador j
where e.jugador=j.codigo and j.nombre_equipo=eq.nombre and eq.division='Central' ; 

-- Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01. Este resultado debe ser redondeado. Nota: el resultado debe estar redondeado
select round(e.Tapones_por_partido) from estadistica e, jugador j
where e.jugador=j.codigo and j.nombre='Corey Maggette' and e.Temporada='00/01';
-- Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por partido de todos los jugadores de procedencia argentina.
select floor(sum(e.Puntos_por_partido)) from estadistica e, jugador j
where e.jugador=j.codigo and j.procedencia='Argentina';