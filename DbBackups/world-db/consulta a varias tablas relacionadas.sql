use empresa;
-- recuperar todos los empleados y su numeros de telefono

select emp.nombre, emp.primerapellido, emp.segundoApellido, tel.numero
from empleados emp
inner join telefono tel on emp.id = tel.empleado_id;

-- recuperar los empleados tengan o no telefono

select emp.nombre, emp.primerapellido, emp.segundoApellido, tel.numero
from empleados emp
left join telefono tel on emp.id = tel.empleado_id;

table empleados;

use world;

-- recupere los paises y el idioma que sea oficial

select pais.Name, lang.Language, lang.IsOfficial
from country pais
inner join countrylanguage  lang on pais.Code = lang.CountryCode
where lang.IsOfficial = 'T';

-- recupere la ciudad mas poblada y el nombre del pais donde se encuentra dicha ciudad

select c.Name, pais.Name
from country pais
inner join city c on pais.Code = c.CountryCode
order by c.Population desc
limit 1;

select c.Name, pais.Name
from city c
inner join country pais on c.CountryCode = pais.Code
where c.Population = (select max(c.Population) from city);
-- modificar la consulta del ejercicio 1 para que solamente
-- se muestran resultados para españa y todos los idiomas no solo oficiales

select pais.Name, lang.Language, lang.IsOfficial
from country pais
inner join countrylanguage  lang on pais.Code = lang.CountryCode
where pais.Code = 'ESP';







table countrylanguage;
