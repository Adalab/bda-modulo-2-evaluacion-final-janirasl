USE sakila;
-- 1 selecciona todos los nombres de las peliculas sin que aparezcan duplicados.

SELECT DISTINCT  title
FROM film; -- 1000 resultados.

-- 2 muestra los nombres de todas las peliculas que tengan una clasificacion de "pg-13"
SELECT title
FROM film
WHERE rating ="pg-13"; -- 223 peliculas estan en esa clasificacion.

-- 3 encuentra el titulo y la descripcion de todas las peliculas que contengan la palabra amazing en su descripcion--
SELECT title,description   -- 48 results.
from film
WHERE description LIKE "%amazing%";

-- 4 encuentra el titulo de todas las peliculas que tengan una duracion mayor a 120 minutos--
SELECT title
FROM film
WHERE length>120; -- 457 results.

-- 5 recupera los nombres de los actores
SELECT * FROM actor;
SELECT first_name,last_name
FROM actor; -- devuelve el nombre y apellidos de los 200 actores( aqui inclui la columna apellido por si hay actores con el mismo nombre)

-- 6. encuentra el nombre y apellido de los actores que tengan " gibson" en su apellido.
SELECT first_name,last_name
FROM actor
WHERE last_name = "gibson"; -- solo 1 actor tiene gibson en su apellido.

-- 7  encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
 SELECT actor_id,first_name,last_name
 FROM actor
 WHERE actor_id BETWEEN '10' AND '20'; -- muestra los 10 actores que estan en la franje con id entre 10 y 20.
 
-- 8 encuentra el titulo de las peliculas en la tabla film que no sea ni r ni pg-13 en cuanto a asu clasificacion.
 SELECT title 
 FROM film
 WHERE rating NOT IN ('R','PG-13'); -- hay 582 peliculas que no entran dentro de estas clasificaciones.
 
-- 9 encuentra la cantidad total de peliculas en cada clasificacion de la tabla film y muestra la clasificacion junto con el recuento.
 SELECT rating, COUNT(*)
 FROM film
 GROUP BY rating; -- aqui nos devuelve de todas las peliculas la clasificacion en la que estan. en total suman 1000 
 
 -- 10 encuentra la cantidad total de peliculas alquiladas por cada cliente y muestra el id del cliente, 
 -- su nombre y apellido junto con la cantidad de peliculas alquiladas.
 SELECT c.customer_id, -- 
        c.first_name,
        c.last_name,
        COUNT(r.rental_id)
  FROM customer AS c
  INNER JOIN rental AS r
      ON c. customer_id = r.customer_id 
     GROUP BY c.customer_id, 
        c.first_name, -- aqui nos muestra la cantidad total de peliculas alquiladas por cada cliente, 599 results
        c.last_name; 
         -- 11 encuentra la cantidad total de peliculas alquiladas por categoria y muestra el nombre de la categoria junto con el recuento de alquileres.
         -- * EL DESARROLLO TOTAL DE ESTE EJERCICIO ESTA EXPLICADO PASO A PASO EN EL QUERIE DE DESARROLLO.// 
          SELECT C.name,COUNT(r.rental_id)
FROM rental AS r
INNER JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
INNER JOIN  film AS f   
	ON i.film_id = f.film_id
INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id
INNER JOIN category AS c
    ON fc.category_id = c.category_id
    GROUP BY c.name; -- nos muestra de de todas las categorias las veces que se han alquilado / 16 resultados
    
    -- 12-- encuentra el promedio de duracion de las peloculas para cada clasificacion de la tabla film y muestra la clasificacion junto con el promedio de duracion.
    SELECT rating, AVG(length) -- seleccionamos la clasificacion y el promedio para ver ambas
     FROM film
     GROUP BY rating; -- nos indica el promedio de cada clasificacion en este caso 5 resultados equivalente a las 5 clasificaciones que hay.
     
     -- 13 encuentra el nombre y apellido de los actores que aparecen en la pelicula con title "indian love"
     SELECT a.first_name,a.last_name
  FROM actor AS a
  INNER JOIN film_actor AS fa
      ON a.actor_id = fa.actor_id
  INNER JOIN film AS f
       ON fa.film_id = f.film_id
          WHERE title="indian love"; -- fueron 10 actores los que protagonizaron indian love.
          
	-- 14 muestra el titulo de todas las peliculas que contengan "dog" o "cat" en su descripcion.
      SELECT title,description
        FROM film
        WHERE description LIKE '%dog%' OR description LIKE '%cat%'; -- hay 167 peliculas que contienen dog o cat en su descripcion.
        
	-- 15 hay algun actor o actriz que no aparezca en ninguna pelicula en la tabla film_actor?
     SELECT first_name,last_name -- personalmente este ejercicio el enunciado es como que me creaba sola la subconsulta.
        FROM actor
        WHERE actor_id NOT IN (
                               SELECT actor_id
                               FROM film_actor
                               ); -- sale vacio porque en este caso no hay ningun actor o actriz que no aparezca en ninguna pelicula.
                               
     -- 16 encuentra el titulo de todas las peliculas que fueron lanzadas entre el año 2005 y 2010. 
     SELECT title
     FROM film
     WHERE release_year BETWEEN 2005 AND 2010; -- salen las 1000 ya que todas son de 2006.
     
       -- 17 encuentra el titulo de todas las peliculas que son de la misma categoria que "family"
             SELECT f.title, c.name
        FROM film AS f
		INNER JOIN film_category as fc
		     ON f.film_id = fc.film_id
	    INNER JOIN category AS c
             ON fc.category_id =c.category_id WHERE c.name ='family';-- hay 69 peliculas que son de genero familia.
             
		-- 18 muestra el nombre y apellido de los actores que aparecen en mas de 10 peliculas.
          SELECT a.actor_id, a.first_name,a.last_name, COUNT(fa.film_id)  -- en este count calculamos las pelis que tiene cada actor todas
     FROM actor AS a
	INNER JOIN film_actor AS fa
        ON a.actor_id = fa.actor_id
        GROUP BY a.actor_id,a.first_name,a.last_name, a.actor_id -- agrupamos por el id de los actores 
        HAVING  COUNT(fa.film_id)>10;-- aqui filtramos por los actores que tienen mas de 10 pelis!//200 results los 200 actores han hecho mas de 10 peliculas? a pues si en la columna count todos son mayores de 10
       
  -- 19 encuentra el titulo de todas las peliculas que son "R" y tienen una duracion mayor a 2 horas en la tabla film.
  SELECT title
       FROM film
       WHERE length >120 AND rating ='r';  -- hay 90 peliculas que son casificadas "r" y tienen una duracion mayor a 2 horas.
       
        -- 20  encuentra las categorias de peliculas que tienen un promedio de duracion superior a 120 minutos 
         --  y muestra el nombre de la categoria junto con el promedio de duracion.
          SELECT c.name,AVG(f.length)
          FROM film AS f
          INNER JOIN film_category AS fc
             ON F.film_id = fc.film_id
          INNER JOIN category AS c
             ON fc.category_id = c.category_id
             GROUP BY c.name -- la compruebo sin el having para ver todos los promedios y si esta bien aqui 16 results.
             HAVING avg(f.length)>120;
             
                -- 21   encuentra los actores que han actuado en al  menos 5 peliculas y muestra el nombre del actor junto con la cantidad de peliculas en las que han actuado.
                
                 SELECT a.actor_id, a.first_name,a.last_name, COUNT(fa.film_id)  -- en este count calculamos las pelis que tiene cada actor todas
     FROM actor AS a
	INNER JOIN film_actor AS fa
        ON a.actor_id = fa.actor_id
        GROUP BY a.actor_id,a.first_name,a.last_name -- agrupamos por el id de los actores 
        HAVING  COUNT(fa.film_id)>=5;-- 200 resultados todos los actores han actuado en 5 o mas peliculas.
                
     -- 22 encuentra el titulo de todas las peliculas que fueron alquiladas por mas de 5 dias.utiliza una subconsulta para encontrar los rental_ids
         -- con una duracion superior a 5 dias y luego selecciona las peliculas correspondientes.
               SELECT DISTINCT f.title
         FROM film AS f
         INNER JOIN inventory AS i
             ON f.film_id = i.film_id
         INNER JOIN rental AS r
             ON i.inventory_id = r.inventory_id
                   WHERE r.rental_id IN (SELECT rental_id
                                               FROM rental
                                                   WHERE datediff(return_date,rental_date)>5
                                                   ); -- 955 veces fueron alquilados estos titulos por mas de 5 dias.
 
 -- 23 encuentra el nombre y apellido de los actores que no han actuado en ninguna pelicula de la categoria "horror". utiliza una subconsulta
      -- para encontrar los actores que han actuado en peliculas de la categoria " horror" y luego excluyelos de la lista actores.
      
      SELECT a.first_name, a.last_name -- primero realize ambas querys por separado,  esta explicado y detallado el transcurso de este ejercicio en el documento de desarrollo.
          FROM actor AS a
          WHERE a.actor_id NOT IN (    SELECT DISTINCT fa.actor_id
                                         FROM film_actor AS fa 
                                      INNER JOIN film_category AS fc
                                             ON fa.film_id = fc.film_id
                                      INNER JOIN category AS C
                                             ON fc.category_id = c.category_id
                                               WHERE C.NAME= 'horror' -- 44 actores no han actuado en la categorria de horror.
                                               );
      -- 24 encuentra el titulo de las peliculas que son comedias y tienen una duracion mayor a 180 minutos en la tabla film.
       SELECT f.title
      FROM film AS f
          INNER JOIN film_category AS fc
             ON F.film_id = fc.film_id
          INNER JOIN category AS c
             ON fc.category_id = c.category_id
             WHERE c.name='comedy' AND f.length>180; -- solo 4 peliculas de comedia tienen una duracion mayor a 180 minutos.
                               