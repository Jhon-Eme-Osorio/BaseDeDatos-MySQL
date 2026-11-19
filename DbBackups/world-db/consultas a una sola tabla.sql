/* La sentencia u orden siguiente pone en uso la base de datos o esquema
world, para realizar consultas a sus tablas */
use world;

-- Comentario a nivel de linea.
-- La sintaxis de la sentencia de SQL mas pequeña que se puede ejecutar
-- por ejemplo, para recuperar todos los registros de la tabla country.
SELECT 
    *
FROM
    country;

table country;

-- recuperar el campo region de la tabla country

SELECT 
    Region
FROM
    country;

-- No es necesario la palabra as para establecer un alias actualmente

SELECT 
    Region LaRegion
FROM
    contry;

-- como hacer para que un alias lleve espacio en blanco entre media "La Region"
-- encerrando la el alias entre backticks, que es un tipo de comillas que en el teclado
-- esta a la derecha de la tecla P 

SELECT 
    Region `La Region`
FROM
    country;

-- se puede recuperar varios ccampos separados por comas

SELECT 
    Region, SurfaceArea, Population, IndepYear
FROM
    country;
    
-- Uso de la clausula distinct, por ejemplo para ver cuantass regiones diferentes existen en la tabla

select distinct Region
from country 
order by Region asc;

-- para limitar la cantida de registros devueltos por la consulta se utiliza la clausula LIMIT

select distinct Region
from country 
order by Region asc
limit 3;

-- ejercicio recuperar el pais (name) que tiene el mayor poblacion (population)
-- solucion con las clausulas estudiadas hasta el presente
select Name, Population from country order by Population desc limit 1;

-- solucion optima correcta Si?
select Name, Population 
from country 
where population = (SELECT MAX(population) from country);

-- la clausula where 
-- ejercicio recuperar los paises que tienen una poblacion superior a los 10 millones de habitantes

select *
from country
where Population > 10000000
order by Population asc;

-- a la consulta anterior agregarle la condicion de que el pais haya obtenido la independencia

select *
from country
where Population > 10000000 and IndepYear is not null
order by Population asc;

-- a la consulta anterior agregarle la condicion de que el pais no haya obtenido la independencia

select *
from country
where Population > 10000000 and IndepYear is null
order by Population asc;

-- en la consulta anteriro agregar la condicion de que la region sea del caribe

select *
from country
where Population > 10000000 and IndepYear is null or Region = "Caribbean"
order by Population asc;

/* uso del operador like, para busqueda exactas se usa el operador de asignacion = pero para busquedas mas 
relajadas se utiliza el operador
like

a modo de ejemplo recuperar todos los paises donde el campo continente 
contenga la palabra America */

select Name `Pais`, Continent
from country
where Continent like '%America%';

-- recuperar todos los paises donde el continente la primera letra sea la letra A

select Name `el pais`, Continent
from country
where Continent like 'A%'
