-- P.9. Abdellah Sahad.
use recetas;

-- 1. Crea un procedimiento que
-- al introducir un id receta, te devuelva los ingredientes de la receta.
drop procedure if exists ObtenerIngredientesDeReceta;

delimiter //

create procedure ObtenerIngredientesDeReceta(
    in idRecetaParam int
)
begin
    select i.nombre, i.tipoIngrediente
    from ingredientes i
    inner join receta_ingredientes ri on i.idingredientes = ri.idingredientes
    where ri.idreceta = idRecetaParam;
end //

delimiter ;

call ObtenerIngredientesDeReceta(4);

-- 2. Crea un procedimiento almacenado que tome como entrada un patrón
-- y te devuelva los cocineros cuyo nombre o apellido coincide con el patrón.

drop procedure if exists BuscarCocinerosPorPatron;
delimiter //
 create procedure BuscarCocinerosPorPatron()
begin
    select nombre, apellido1, apellido2
    from cocinero
   where nombre like'%A%C%' or apellido1 like '%A%C%' or apellido2 like '%A%C%';
end //
delimiter ;

call BuscarCocinerosPorPatron();

-- 3. Crea un procedimiento almacenado que, al introducir un ingrediente,
-- te devuelva una cadena de caracteres con todas las recetas que incluyen ese ingrediente.

DROP PROCEDURE IF EXISTS BuscarRecetasPorIngrediente;
DELIMITER //
CREATE PROCEDURE BuscarRecetasPorIngrediente(
    IN ingrediente_nombre VARCHAR(50)
)
BEGIN
    SELECT r.nombre, r.instrucciones
    FROM receta r
    JOIN receta_ingredientes ri ON r.idreceta = ri.idreceta
    JOIN ingredientes i ON ri.idingredientes = i.idingredientes
    WHERE i.nombre = ingrediente_nombre;
END //
DELIMITER ;


CALL BuscarRecetasPorIngrediente('tomate');

-- 4. Crea una función que,
-- al introducir un id ingrediente, te devuelva el cocinero que más lo emplea.
drop function if exists CocineroQueMasEmplea;
use recetas;
delimiter //

create function CocineroQueMasEmplea(id_ingrediente int) returns int deterministic
begin
    declare id_cocinero_in int;
    select receta.idcocinero into id_cocinero_in
    from receta_ingredientes inner join receta using(idreceta)
    where idingredientes = id_ingrediente
    group by receta.idcocinero
    order by count(*) desc
    limit 1;
    return id_cocinero_in;
end//

delimiter ;
select * from receta_ingredientes;

select CocineroQueMasEmplea(2); 

-- 5. Crea una función que, al introducir un id cocinero, 
-- devuelva la valoración media de las recetas de ese cocinero.

drop function if exists ValoracionMediaCocinero;

delimiter //

create function ValoracionMediaCocinero(id_cocinero INT) returns decimal(5, 2) reads SQL data
begin
    declare valoracion_media decimal(5, 2);
    
    SELECT AVG(v.puntuacion) INTO valoracion_media
    FROM valoracion v
    JOIN receta r ON v.idreceta = r.idreceta
    WHERE r.idcocinero = id_cocinero;
    
    return valoracion_media;
end//

delimiter ;


select ValoracionMediaCocinero(1);

-- 6. Crea una función que devuelva la categoría más empleada.

drop function if exists CategoriaMasEmpleada;

DELIMITER //

create function CategoriaMasEmpleada() returns varchar(50) reads SQL data
begin
    declare categoria_empleada varchar(50);
    
   
    SELECT c.nombre INTO categoria_empleada
    FROM categoria c
    LEFT JOIN receta r ON c.idcategoria = r.idcategoria
    GROUP BY c.idcategoria
    ORDER BY COUNT(*) DESC
    limit 1;
    
    return categoria_empleada;
end//

delimiter ;
select CategoriaMasEmpleada();

-- 7. Crea un trigger que, al añadir una nueva valoración,
-- se actualice un campo llamado puntuaciónreceta en receta.

-- Eliminar la columna 'puntuacion' si existe
alter table valoracion drop column puntuacion;

-- Agregar la columna 'puntuacion' correctamente
alter table valoracion add column puntuacion decimal(4,2);

-- Eliminar el trigger si existe
drop trigger if exists actualizar_puntuacion_despues_insert;

-- Delimitador personalizado para el trigger
delimiter //

-- Crear el trigger para actualizar la puntuación de la receta después de insertar una nueva valoración
create trigger actualizar_puntuacion_despues_insert after insert on valoracion for each row
begin     
    update receta     
    set puntuacion = (
        select avg(puntuacion)
        from valoracion
        where idreceta = new.idreceta
    )
    where idreceta = new.idreceta; 
end;
//

-- Restaurar el delimitador predeterminado
delimiter ;

-- Ahora inserta valores de prueba en la tabla 'valoracion'
insert into valoracion (idreceta, puntuacion) values (1, 4), (1, 5),(1,2);

select * from receta where idreceta = 1;


-- Crea una transacción para añadir una receta con unos ingredientes aleatorios. 
-- Iniciar la transacción

start transaction;

insert into receta (nombre, instrucciones, idcocinero, idcategoria) 
values ('Nombre de la Receta', 'Instrucciones de la receta', 1, 1);

set @id_receta = LAST_INSERT_ID();

insert into receta_ingredientes (idreceta, idingredientes)  
select @id_receta, idingredientes from ingredientes order by rand() limit 5;


commit;
-- Revertir la transacción si hay algún error
-- ROLLBACK;


