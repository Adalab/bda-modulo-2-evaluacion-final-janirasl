USE sakila;
-- 1 selecciona todos los nombres de las peliculas sin que aparezcan duplicados.
-- tabla que necesito; films, sin duplicados= distict,
 
SELECT title -- 1000 results
FROM film;
-- query final.
SELECT DISTINCT  title -- 1000 results no habia duplicados.
FROM film;

-- 2 muestra los nombres de todas las peliculas que tengan una clasificacion de "pg-13"
-- tabla que necesito films, columna rating filtramos! 

SELECT * FROM film;
-- query final.
SELECT title
FROM film
WHERE rating ="pg-13"; -- 222 results-- 

-- 3 encuentra el titulo y la descripcion de todas las peliculas que contengan la palabra amazing en su descripcion--
-- info en la tabla film-- quiere titutlo y descripcion y en descripcion filtrar por amazing! like

SELECT * FROM film;
-- query final-
SELECT title,description -- 48 results.
from film
WHERE description LIKE "%amazing%";

-- 4 encuentra el titulo de todas las peliculas que tengan una duracion mayor a 120 minutos--
-- tabla peliculasn duracion<120  filtrar con where length

SELECT * FROM film;

SELECT title
FROM film
WHERE length>120; -- 457 results--

-- 5 recupera los nombres de los actores
-- tabla 	que necesitamos// actor // nombre//

SELECT * FROM actor;
SELECT first_name,last_name
FROM actor; -- 200 actores// recupera? tendre que recuperar de algun sitio o sera igual que encuentra

-- 6. encuentra el nombre y apellido de los actores que tengan " gibson" en su apellido.

 SELECT first_name,last_name
FROM actor
WHERE last_name = "gibson"; -- solo 1?

SELECT COUNT(*)
FROM actor
WHERE last_name = "gibson"; -- compruebo que si 

-- 7 encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
-- tabla actors.//ENTRE = BETWEEN 
 SELECT * FROM actor; -- 200 RESULTS // 200 ACTORES
 
 SELECT actor_id,first_name,last_name
 FROM actor
 WHERE actor_id BETWEEN '10' AND '20'; -- filtramos a 10 resultados con el nombre completo de los actores que estan en esa franja.
 
 -- 8 encuentra el titulo de las peliculas en la tabla film que no sea ni r ni pg-13 en cuanto a asu clasificacion.
 -- tabla implicada film-- NOT IN!! // rating//
 
 SELECT *FROM film; -- 1000 RESULTS!!
 SELECT title 
 FROM film
 WHERE rating NOT IN ('R','PG-13');  -- 582 RESULTS!!  -- OJO NOT IN VA EN PARENTESIS!
 
 -- 9 encuentra la cantidad total de peliculas en cada clasificacion de la tabla film y muestra la clasificacion junto con el recuento.
 -- tabla films// total de peliculas en cada clasificacion// COUNT CONTAR TOTAL
 SELECT * FROM film;
 SELECT rating, COUNT(*)
 FROM film
 GROUP BY rating; -- devuelve 5 resultados cada clasificacion con el numero de peliculas de cada!
 
 -- 10 encuentra la cantidad total de peliculas alquiladas por cada cliente y muestra el id del cliente, 
 -- su nombre y apellido junto con la cantidad de peliculas alquiladas.
 
 -- tablas implicadas: rental, y customers//join// queremos de la tabla clientes id,nombre y apellido y caqntidad peliculas rental!
-- customer id.// count // de cada cliente agrupamos? group by //
 
 SELECT * FROM rental;
 SELECT * FROM customer;
 
 SELECT c.customer_id, -- 
        c.first_name,
        c.last_name,
        COUNT(r.rental_id)
  FROM customer AS c
  INNER JOIN rental AS r
      ON c. customer_id = r.customer_id -- salen todos los id repetidos vamos a agrupar!// 1000 reuslts
     GROUP BY c.customer_id, -- en el group by tenemos que poner las mismas columnas que en el select!! menos la funcuion de agregacion que no van en group by!
        c.first_name,
        c.last_name; -- 599 results ahora me sale organizado cuantas veces cada cliente ha alquilado peliculas!
   
  -- 11 encuentra la cantidad total de peliculas alquiladas por categoria y muestra el ID del cliente
  -- su nombre y apellido junto con la cantidad de peliculas alquiladas.
  
  -- tablas implicadas: total peliculas alquiladas y categoria // rental y films, category,film_category, inventary, customer // 4 joins?3 //
  -- #buscar patron de conexion de todas//total = count// y todo agrupadito mejor no? group by de peliculas alquiladas?
  -- #TENGO QUE MOSTRAR EL nombre de la categoria osea name y contar rental_id 
  
  SELECT * from rental; -- aqui une inventory_id Y customer_id  el rental_id( contar este)-- este al select
  SELECT* from film; -- aqui necesitamos el nombre de las pelis (title)
 SELECT * from inventory; -- esta solo la necesito para unir con rental 
 SELECT * from category; -- aqui necesito el category_id y name  o solo name en verdad 
SELECT * FROM film_category; -- esta tabla puente que conecta el category_id con categoria y film_id con film.
-- de rental inventory_id  a inventory,  conecto film_id a film_id de la tabla film ahora de la tabla film me conecto a film_category por el film_id y de film_category me conecto a category por el category_id.boooom!!!

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
    GROUP BY c.name; -- muestra 16 results  que coincide con la cantidad de generos que hay  y en el rental id las veces que ha sido alquilada esa categoria.
    
    -- compruebo que hay 16 generos
     
 SELECT category_id , name
 FROM category; -- 16 con  todos los generos.

 
 
 
 

-- 12-- encuentra el promedio de duracion de las peloculas para cada clasificacion de la tabla film y muestra la clasificacion junto con el promedio de duracion.
-- tabla film// promedio de duracion avg // clasidicacion rating

SELECT * FROM film;
SELECT rating, AVG(length) -- seleccionamos la clasificacion y el promedio para ver ambas
FROM film
GROUP BY rating; 

-- 13 encuentra el nombre y apellido de los actores que aparecen en la pelicula con title "indian love"
-- tablas nombre y apellidos tabla actor // pelicula tabla film title indian love// inner join // ojo que para que conecten esta intermedio film actor.2 joins

SELECT a.first_name,a.last_name
  FROM actor AS a
  INNER JOIN film_actor AS fa
      ON a.actor_id = fa.actor_id
  INNER JOIN film AS f
       ON fa.film_id = f.film_id
          WHERE title="indian love"; -- 10 actores?-- 
          
          -- voy a comprobar que no me fio-- 
          SELECT film_id,title
          FROM film
          WHERE title ="indian love";  -- el film id es 458.
          
		SELECT *
        FROM film_actor
        WHERE film_id = "458"; -- me devuelve 10 pues si estaba bien!
        
        -- 14 muestra el titulo de todas las peliculas que contengan "dog" o "cat" en su descripcion.
        -- tabla films // or//like
        
        SELECT title,description
        FROM film
        WHERE description LIKE '%dog%' OR description LIKE '%cat%'; -- 167 results
        
        -- 15 hay algun actor o actriz que no aparezca en ninguna pelicula en la tabla film_actor?
        -- tablas involucradas actor y film actor // join? // actores que no esten en esta tabla! not in //
        
        SELECT first_name,last_name
        FROM actor
        WHERE actor_id NOT IN (
                               SELECT actor_id
                               FROM film_actor -- 1000 results// aqui muestra todas las veces que el actor actuo en peliculas
                               ); -- me sale vacia, es correcto no hay ningun actor que no haya hecho ninguna pelicula.
        -- voy a comprobar--                       
	SELECT COUNT(*)
    FROM actor; -- hay 200
    
    SELECT COUNT(DISTINCT actor_id) -- aqui actores unicos filtrados.
    FROM film_actor;-- igual 200
    
    -- 16 encuentra el titulo de todas las peliculas que fueron lanzadas entre el año 2005 y 2010.
    -- ENTRE BETWEEN // solo una tabla
    
	 SELECT * FROM film;
     
     SELECT title
     FROM film
     WHERE release_year BETWEEN 2005 AND 2010; -- 1000 RESULT!! muchos no? -- esta bien!
     
     SELECT DISTINCT release_year
     FROM film; -- a todas las peliculas son del 2006
     
     -- 17 encuentra el titulo de todas las peliculas que son de la misma categoria que "family"
        -- tabla film, tabla category Y tabla film_category // 2 joins//
        
        SELECT * FROM film;
        SELECT * FROM category; -- category_id es la 9 family
        
        SELECT f.title, c.name
        FROM film AS f
		INNER JOIN film_category as fc
		     ON f.film_id = fc.film_id
	    INNER JOIN category AS c
             ON fc.category_id =c.category_id WHERE c.name ='family'; -- 69 peliculas del genero family!
             
        -- 18 muestra el nombre y apellido de los actores que aparecen en mas de 10 peliculas.
     -- tablas relacionadas actors// film actor la que conecta ambas  // 1joins y agrupar luego filtro  >10 = group by + having // queremos nombre y apellido de la tabla actors.
     SELECT * from actor; -- 200 actores de aqui cojo first_name, last_name
     SELECT * FROM film_actor; -- contaremos el film id para ver los actores que aparecen en cada peli despues agruparemos y despues filtraremos por los que salgan en mas  de 10. ready!
     USE sakila;
     
     SELECT a.actor_id, a.first_name,a.last_name, COUNT(fa.film_id)  -- en este count calculamos las pelis que tiene cada actor todas
     FROM actor AS a
	INNER JOIN film_actor AS fa
        ON a.actor_id = fa.actor_id
        GROUP BY a.actor_id,a.first_name,a.last_name, a.actor_id -- agrupamos por el id de los actores 
        HAVING  COUNT(fa.film_id)>10;-- aqui filtramos por los actores que tienen mas de 10 pelis!//200 results los 200 actores han hecho mas de 10 peliculas? a pues si en la columna count todos son mayores de 10
       
     
       
       -- 19 encuentra el titulo de todas las peliculas que son "R" y tienen una duracion mayor a 2 horas en la tabla film.
       -- tabla involucrada film filtramos porque sean r y sean mayor a 120 min.
       SELECT * FROM film;
       SELECT title
       FROM film
       WHERE length >120 AND rating ='r'; -- 90 results este easy!
       
       -- 20  encuentra las categorias de peliculas que tienen un promedio de duracion superior a 120 minutos 
       --  y muestra el nombre de la categoria junto con el promedio de duracion.
       
      -- tablas que necesito: peliculas y categorias  y film category que es a que hace de puente // seran 2 joins // hacer el promedio de lenght// agrupar por nombre category  y luego filtrar por las que superen el promedio de 120!
          SELECT * from film; -- aqui queremos el length hacer el promedio 
          
          SELECT c.name,AVG(f.length)
          FROM film AS f
          INNER JOIN film_category AS fc
             ON F.film_id = fc.film_id
          INNER JOIN category AS c
             ON fc.category_id = c.category_id
             GROUP BY c.name -- la compruebo sin el having para ver todos los promedios y si esta bien aqui 16 results.
             HAVING avg(f.length)>120; -- solo 4 results duran mas de 120 min me cuadra porque para una peli es larguisimo.
             
             -- 21   encuentra los actores que han actuado en la menos 5 peliculas 
             --    y muestra el nombre del actor junto con la cantidad de peliculas en las que han actuado.
             -- este es casi como el 18// copio casi el codigo de este la diferencia es que aqui te pide en vez de 10 pelis en al menos 5 hay que contar al 5 tambien
          
           SELECT a.actor_id, a.first_name,a.last_name, COUNT(fa.film_id)  -- en este count calculamos las pelis que tiene cada actor todas
     FROM actor AS a
	INNER JOIN film_actor AS fa
        ON a.actor_id = fa.actor_id
        GROUP BY a.actor_id,a.first_name,a.last_name -- agrupamos por el id de los actores 
        HAVING  COUNT(fa.film_id)>=5; -- 200 results ya comprobe arriba que todos los actores habian hecho mas de 10 pelis  // esta pregunta no tiene mucho sentido
    
         -- 22 encuentra el titulo de todas las peliculas que fueron alquiladas por mas de 5 dias.utiliza una subconsulta para encontrar los rental_ids
         -- con una duracion superior a 5 dias y luego selecciona las peliculas correspondientes.
         
         -- // ojo tambien necesitamos film para el titulo asique join! y su tabla puente
         
         SELECT * FROM rental; -- necesitamos el return_date y last_update y necesitamos el rental id >5   
         SELECT * FROM inventory;--  esta es la que une inventory_id con rental y film_id con film
         SELECT * FROM film; -- aqui el title necesitamos !
         
         SELECT rental_id
         FROM rental
         WHERE datediff(return_date,rental_date)>5; -- tenemos la primera parte datediff es para calcular los dias de diferencia des una fecha a otra # tip de grupo· LA PARTE DE LA SUBCONSULTA FUNCIONA!
         
         SELECT f.title
         FROM film AS f
         INNER JOIN inventory AS i
             ON f.film_id = i.film_id
         INNER JOIN rental AS r
             ON i.inventory_id = r.inventory_id
                   WHERE r.rental_id IN (SELECT rental_id
                                               FROM rental
                                                   WHERE datediff(return_date,rental_date)>5
                                                   ); -- ME SALEN 1000 RESULTS  Y MUCHOS REPETIDOS!!!  VOY A FILTRAR MAS  POR PELIS
                                                   
         
         SELECT DISTINCT f.title
         FROM film AS f
         INNER JOIN inventory AS i
             ON f.film_id = i.film_id
         INNER JOIN rental AS r
             ON i.inventory_id = r.inventory_id
                   WHERE r.rental_id IN (SELECT rental_id
                                               FROM rental
                                                   WHERE datediff(return_date,rental_date)>5
                                                   ); -- 955 RESULTS NO CAMBIA MUCHO EL RESULTADO PERO POR LO MENOS NO SE REPITEN LAS PELIS!
                                                   
   -- 23 encuentra el nombre y apellido de los actores que no han actuado en ninguna pelicula de la categoria "horror". utiliza una subconsulta
      -- para encontrar los actores que han actuado en peliculas de la categoria " horror" y luego excluyelos de la lista actores.
      
      -- tablas comprometidas actors,film_actor, category, category film // 2 joins y subconsulta de actores que salen en category horror. LUEGO EXCLUYE NOT IN?
      SELECT * FROM category;
      SELECT * FROM film_category;
      SELECT * FROM film_actor;
      
      SELECT a.first_name, a.last_name
          FROM actor AS a;
          
      SELECT fa.actor_id
      FROM film_actor AS fa 
      INNER JOIN film_category AS fc
          ON fa.film_id = fc.film_id
      INNER JOIN category AS C
          ON fc.category_id = c.category_id
          WHERE C.NAME= 'horror'; -- 317 actores actuaron en pelis de terror pero habia 200 actores? estan repetidos
          
          SELECT DISTINCT fa.actor_id
      FROM film_actor AS fa 
      INNER JOIN film_category AS fc
          ON fa.film_id = fc.film_id
      INNER JOIN category AS C
          ON fc.category_id = c.category_id
          WHERE C.NAME= 'horror'; -- 156 RESULTS AHORA SI 
          
         SELECT a.first_name, a.last_name
          FROM actor AS a
          WHERE a.actor_id NOT IN (    SELECT DISTINCT fa.actor_id
                                         FROM film_actor AS fa 
                                      INNER JOIN film_category AS fc
                                             ON fa.film_id = fc.film_id
                                      INNER JOIN category AS C
                                             ON fc.category_id = c.category_id
                                               WHERE C.NAME= 'horror' -- AHORA SI encaja perfecto 44 actores no participaron en pelis de horror es justo la diferencvia de lo que comprobe arriba
                                               );
        -- 24 encuentra el titulo de las peliculas que son comedias y tienen una duracion mayor a 180 minutos en la tabla film.
         -- tablas comprometidas category, film y la puente esto ya lo use antes cojo los joins del 20// 2 joins aqui dos condiciones where comedy and > 180
      SELECT f.title
      FROM film AS f
          INNER JOIN film_category AS fc
             ON F.film_id = fc.film_id
          INNER JOIN category AS c
             ON fc.category_id = c.category_id
             WHERE c.name='comedy' AND f.length>180; -- 3 pelis  de comedia superan los 180 min!
             
      
         
     
                          
        
          

