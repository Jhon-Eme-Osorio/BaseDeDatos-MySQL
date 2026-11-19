/*Las funciones de agregado, tambien llamadas operaciones de agregado,
agrupan registros para obtener un resultado*/

/* que es uuna variable ? 
es un identificador es un nombre que se le asigna a una ubicacion
en la memoria RAM del equipo y que en principio solamente puede almacenar un valor de un tipo de datos concreto por ejemplo
un entero Int, una cadenaa caracteres Varchar

Que es una funcion?

en los inicios de la programacion tambien llamada Rutina o Subritina, es un conjunto
de setencia o intrucciones de un lenguaje de programacion (basic,ensamblador, Fortran,
Pascal, FoxPro, Java,Python, etc,que se declara una sola vez
ya sea en el propio programa o en una biblioteca(library) aparte y se le da
un nombre y posteriormente puede ser invocada o llamada todas lla veces que hagan falta desdde
cualquier parte del programa que estemos desaarrollando

*/

use world;

-- Contar el total de paises que hay en la tabla country

select count(*) `Total de Paises`
from country;

-- contar cuantos paises hay por region

select Region, count(*) `Total de Paises`
from country
group by Region
order by `Total de Paises` desc;

-- de la consulta anterior mostrar solamente los resultados para la regiones que tienen mas
-- de 10 paises

select Region, count(*) `Total de Paises`
from country
group by Region
having `Total de Paises` > 10
order by `Total de Paises` desc;

/*en una sentencia de sql donde se utilice funciones de agregado count, max(), min(), avg(),sum(), etc. los campos
que no esten afectados por una funcion de agregado hay que incluirlos en la clausula gorup by
y si no se utilizan funcioes de agregado o se agrupa la clausula where y having se pueden uttilizar indistintamnete es decir
son intercambiables, pero si se agrupa para filtrar antes de group by se utliza la clausula where,
y para operar los registros agurpados se utiliza la clausula having */
-- de la consulta anterior excluir los paises que todavia no han obtenido su independencia

select Region, count(*) `Total de Paises`
from country
where IndepYear is not null
group by Region
having `Total de Paises` > 10
order by `Total de Paises` desc;

-- ejercicio #1 del miercoles 18 noviembre

-- recuperar el total de habitantes que hay por continente y region
-- excluir del resultado aquellos paises que tengan una poblacion inferior de 1 millon de 
-- habitantes o que no haya obtenido su independencia todavia 
-- mostrar el resultado por el total de poblacion, mostrando las regiones que tienen menos habitantes
-- primero y solo mostrar registros con mas de 5 millones de habitantes

select Region, Continent, sum(Population) `total habitantes`
from country
where Population > 1000000 and IndepYear is not null
group by Region, Continent
having sum(Population) > 5000000
order by `total habitantes` asc;

 



-- sentencias sql auxiliares

table country;
