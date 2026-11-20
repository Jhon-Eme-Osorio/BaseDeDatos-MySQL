use world;

/* recuperar el pais y la poblacion del pais que tiene mas habitantes, consulta
que ya habiamos implementado, pero de una forma nada eficiente order by limit; */

select Name `Pais`, Population `Poblacion`
from country
where Population = (select max(Population) from country);

-- recupere la ciudad mas poblada y el nombre del pais donde se encuentra dicha ciudad


select c.name `ciudad`, pais.name `Pais`, c.Population
from city c
inner join country pais  on  c.CountryCode = pais.Code
where c.Population =(select max(Population) from city);


select Name `ciudad`, Population `poblacion`
from city
where Population = (select max(Population) from city);

use jardineria;

/* tipos de subconsultas:

1- sub consultas de fila: devuleven multiples columnas (campos) y una sola fila
2- subconsulta de tabla: devuleven una o varias columnas y entre cero y varias filas
3- subconsulta escalares: devuelven una columna y una fila (una celda), es decir un valor */

/* subconsultas en la clausula where*/
/*
suponga que queremos conocer el nombre del producto que tiene mayor precio

una de las posibles soluciones seria realizar una primera consulta, que es la subconsulta, para recuperar el precio maximo
*/

select nombre, precio_venta
from producto
where precio_venta =(select max(precio_venta) from producto);

use tienda;

/* subconsultas en la clausula where*/
/*
suponga que queremos conocer el nombre del producto que tiene mayor precio

una de las posibles soluciones seria realizar una primera consulta, que es la subconsulta, para recuperar el precio maximo*/

select nombre, precio
from producto
where precio =(select max(precio) from producto);

select nombre,precio
from producto;

/* subconsulta en la clausula having*/

-- recuperar un listado con todos los fabricantes que tienen el mismo numero de productos que el 
-- fabricante asus;

select fabricante.nombre, count(*) `cantida de productos`
from fabricante
inner join producto on fabricante.id= producto.id_fabricante
group by fabricante.nombre
having `cantida de productos` = 
(select count(producto.id_fabricante) from fabricante inner join producto on fabricante.id = producto.id_fabricante and fabricante.nombre = 'Asus'  );

-- eliminar del listado anterior al fabicante asus

select fabricante.nombre, count(*) `cantida de productos`
from fabricante
inner join producto on fabricante.id= producto.id_fabricante
and fabricante.nombre != 'Asus'
group by fabricante.nombre
having `cantida de productos` = 
(select count(producto.id_fabricante) from fabricante inner join producto on fabricante.id = producto.id_fabricante and fabricante.nombre = 'Asus'  );

/* subconsulta en la clausula from
recuperar el listado de todos los productos que tienen un precio mayor o igual al precio promedio de todos
los productos del mismo fabricante
*/

select producto.*
from producto inner join (
select id_fabricante, avg(precio) precioPromedio from producto group by id_fabricante) t on producto.id_fabricante = t.id_fabricante
and producto.precio >= precioPromedio
order by precio desc;

/* Por sugerencia y cortesia de Elias, la consulta anterior es mejor implementarla utilizando NATURAL JOIN, en 
lugar de INNER JOIN, porque el NATURAL JOIN es perfecto cuando hay campos en las dos tablas que tiene el mismo 
nombre, y nos evita utilizar la clausula ON USING */

/* Uso de la clausula USING */

select producto.*
from producto join (
	select id_fabricante, avg(precio) precioPromedio
    from producto
    group by id_fabricante) t using(id_fabricante) 
    where producto.precio >= precioPromedio
    order by precio desc;
    
/* Uso de NATURAL JOIN */

select producto.*
from producto natural join (
	select id_fabricante, avg(precio) precioPromedio
    from producto
    group by id_fabricante) t 
    where producto.precio >= precioPromedio
    order by precio desc;
    
/* OPERADORES QUE PODEMOS UTILIZAR EN LAS SUBCONSULTAS 

 1. Operadores basicos de comparacion (>, >=, <, <=, !=, <>, =) 
 2. Predicados (Predicate (Condicion que se evalua) ANY (SOME) y ALL 
 3- Predicados IN y NOT IN 
 4- Predicado EXISTS y NOT EXISTS */
 
 /* Los Operadores basicos de comparacion se utilizan cuando queremos comparar una expresion
 con el valor que devuelve una subconsulta */
 
 /* Subconsulta para el usuo de los operadores basicos de comparacion:
 
 recuperar todos los productos que tienen un precio mayor o igual al producto mas caro del 
 fabricante asus */

select *
from producto p 
where p.precio >= (select max(p.precio) from producto p inner join fabricante fabri on p.id_fabricante = fabri.id and fabri.nombre = 'Asus');

-- la consulta anteriro la podemos reescribir utilizando clausula using
/* en este caso no se puede usar la clausula using presupone que en ambas tablas
 exista el mismo campo en este caso el campo id_fabricante tambien debe aparecer con el mismo nombre en 
la tabla fabricante*/

/*ejemplo del operador any
recuperar el nombre de los fabricantes que tienen productos asociados*/

select f.nombre
from fabricante f
where f.id = any (select id_fabricante  from producto);

/*recuperar los fabricantes que no tienen producto*/

select nombre
from fabricante
where id != all (select id_fabricante from producto);

/* uso de los operadores in*/
/* tener encuenta lo siguiente es in es equivalente a = any, pero not in no es equivalente a != any
pero si a != all */

/* recuperar un listado de los clientes que no han realizado ningun pedido, utilizando los operadores in y not in*/

select *
from cliente
where codigo_cliente  not in (select codigo_cliente from pedido );

/*recuperar el nombre del cliente con sus pedidos y el nombre del representante de ventas*/

SELECT 
    cli.nombre_cliente, ped.codigo_pedido, emp.nombre
FROM
    cliente cli
        natural JOIN
    pedido ped
        INNER JOIN
    empleado emp ON emp.codigo_empleado = cli.codigo_empleado_rep_ventas;

/* uso de los operadores exits y not exists
   este tipo de operadores se implementa con subconsultas correlacionadas, es decir subconsultas que hacen
   referencia a una o varias tablas de la consulta que la contienen o cualquier consulta mas exterior*/
   
-- a modo de ejmplo devolver un listado de los clientes que no han realizado ningun pedido

select *
from cliente
where not exists (select codigo_cliente from pedido where cliente.codigo_cliente = pedido.codigo_cliente);

/*en la consulta anteriros, concretamente en la subconsulta inicialmente en la select expecificamos el campo codigo cliente,
  pero finalmente cambiamos por * y el resultado es el mismo*/
  
  /* a modo de ejmplo recuperar un listado de todos los productos que tienen un precio mayor o igual
     a la media de todos los productos de su mismo fabricante para la solucion debes usar la base de datos tienda*/

select *
from producto p
where p.precio  >= (select avg(p2.precio) from producto p2  where p2.id_fabricante = p.id_fabricante);




