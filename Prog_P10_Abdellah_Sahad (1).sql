-- Crear la base de datos
drop database if exists tienda_online;
create database tienda_online;
 
-- Usar la base de datos
use tienda_online;
 
-- Tabla de clientes
create table clientes (
    id int auto_increment primary key,
    nombre varchar(100),
    email varchar(100),
    direccion varchar(255),
    dni varchar(9)
);
 
 
-- Tabla de productos
create table productos (
    id int auto_increment primary key,
    nombre varchar(100),
    descripcion text,
    precio decimal(10, 2)
);
 
-- Tabla de pedidos
create table pedidos (
    id int auto_increment primary key,
    cliente_id int,
    fecha_pedido timestamp default current_timestamp,
    foreign key (cliente_id) references clientes(id)
);
 
-- Tabla de detalles de pedido
create table detalles_pedido (
    id int auto_increment primary key,
    pedido_id int,
    producto_id int,
    cantidad int,
    precio_unitario decimal(10, 2),
    foreign key (pedido_id) references pedidos(id),
    foreign key (producto_id) references productos(id)
);
 
select*from clientes;
select * from pedidos;
select*from detalles_pedido;
 
SELECT p.* FROM pedidos p JOIN clientes c ON p.cliente_id = c.id WHERE c.dni = '12345678A';