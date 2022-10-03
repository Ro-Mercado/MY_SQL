-- 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
select * from jugador
order by nombre;
-- 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, ordenados por nombre alfabéticamente.
select nombre as NOOMBRE_JUGADOR_PIVOT_Y_PESO_MAYOR_A_200 from jugador
where posicion='C' and peso>200
order by nombre;
-- 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
SELECT nombre from equipo
order by nombre;
-- 4. Mostrar el nombre de los equipos del este (East).
select nombre as NOMBRE_EQUIPOS_DEL_ESTE from equipo
WHERE conferencia='East';
-- 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
select nombre as NOMBRE_EQUIPO_CON_C from equipo
where nombre like 'C%';
-- 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
select nombre_equipo, nombre from jugador
order by nombre_equipo;
-- 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
select * from jugador
where nombre_equipo='Raptors'
order by nombre;
-- 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
select e.temporada as TEMPORADA, e.puntos_por_partido as PUNTOS_POR_PARTIDO_DE_PAU_GASOL from estadistica e, jugador j
where j.nombre='Pau Gasol' and j.codigo=e.jugador;
-- 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
select e.temporada as TEMPORADA, e.puntos_por_partido as PUNTOS_POR_PARTIDO_DE_PAU_GASOL from estadistica e, jugador j
where j.nombre='Pau Gasol' and j.codigo=e.jugador and e.temporada='04/05';
-- 10. Mostrar el número de puntos de cada jugador en toda su carrera.
select j.nombre, sum(e.puntos_por_partido) as PUNTOS_TOTALES from estadistica e, jugador j
where j.codigo=e.jugador
group by j.nombre
order by j.nombre;
-- 11. Mostrar el número de jugadores de cada equipo.
select e.nombre, count(*) from equipo e, jugador j
where e.nombre=j.nombre_equipo
group by e.nombre
order by nombre;
-- 12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
select j.nombre as JUGADOR_CON_MÁS_PUNTOS, sum(e.puntos_por_partido) as PUNTOS_TOTALES from estadistica e, jugador j
where j.codigo=e.jugador
group by j.nombre
order by sum(e.puntos_por_partido) desc limit 1 ;
-- 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
select j.nombre as NOMBRE_JUGADOR_MÁS_ALTO, e.conferencia, e.division from jugador j, equipo e
where  e.nombre=j.nombre_equipo
group by j.nombre
order by j.altura desc limit 1;
-- 14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
select AVG(p.puntos_local+p.puntos_visitante), e.nombre
from partido p, equipo e
where e.division='Pacific' and (e.nombre=p.equipo_local OR e.nombre=p.equipo_visitante)
group by e.nombre;

SELECT e.nombre, AVG(p.puntos_local+p.puntos_visitante)"Puntos promedio por partido como Local", SUM(p.puntos_local), sum(p.puntos_visitante) , count(p.puntos_local), count(p.puntos_visitante) FROM equipo e 
INNER JOIN partido p 
ON p.equipo_local = e.nombre or p.equipo_visitante=e.nombre
WHERE e.division= "Pacific" 
GROUP BY e.nombre;
/*SOLUCION RENZO -> SELECT e.nombre, AVG(p.puntos_local) "Puntos promedio por partido como Local" FROM equipo e INNER JOIN partido p ON p.equipo_local = e.nombre WHERE e.division= "Pacific" GROUP BY e.nombre;

SELECT e.nombre, AVG(p.puntos_visitante) "Puntos promedio por partido como Visitante" FROM equipo e INNER JOIN partido p ON p.equipo_visitante = e.nombre WHERE e.division= "Pacific" GROUP BY e.nombre;
*/
select* from partido ;
-- 15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
select equipo_local, equipo_visitante, MAX(ABS(puntos_local-puntos_visitante)) as DIFERENCIA -- ABS() Valor absoluto 
from partido;
-- 16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.

-- 17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.

-- 18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null.
