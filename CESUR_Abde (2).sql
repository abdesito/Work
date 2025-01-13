DROP DATABASE IF EXISTS pruebilla;

CREATE DATABASE pruebilla;

USE pruebilla;

-- Crear tabla clientes con el nuevo atributo direccion
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    Apellido VARCHAR(100),
    edad INT,
    direccion VARCHAR(255) -- Direccion incluye calle, piso y codigo postal
);

-- Insertar registros de clientes con direccion
INSERT INTO clientes (nombre, Apellido, edad, direccion) 
VALUES 
    ('Abdellah', 'Sahad', 19, 'Calle Principal 123, Piso 2, CP 28001'),
    ('Lucía', 'Martínez', 27, 'Avenida Libertad 45, Piso 4, CP 46020'),
    ('Lucas', 'Hernández', 35, 'Calle del Sol 78, Bajo, CP 41010');

-- Consultar todos los clientes
SELECT * FROM clientes;

-- Crear tabla productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200),
    stock INT,
    precio DECIMAL(8,2)
);

-- Insertar registros de productos
INSERT INTO productos (nombre, stock, precio) 
VALUES 
    ('Pulsera de acero', 9, 20.99),
    ('Collar de plata', 15, 45.50),
    ('Anillo de oro', 5, 120.00);

-- Consultar todos los productos
SELECT * FROM productos;

CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único de la venta
    cliente_id INT, -- ID del cliente que realiza la compra
    producto_id INT, -- ID del producto comprado
    cantidad INT, -- Cantidad comprada
    precio DECIMAL(8,2), -- Precio unitario en el momento de la venta
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de la venta
    FOREIGN KEY (cliente_id) REFERENCES clientes(id), -- Relación con la tabla clientes
    FOREIGN KEY (producto_id) REFERENCES productos(id) -- Relación con la tabla productos
);

select * from ventas;


CREATE TABLE detalles_venta (
    id INT AUTO_INCREMENT PRIMARY KEY,         
    venta_id INT,                              
    producto_id INT,                           
    cantidad INT,                              
    precio DECIMAL(8,2),              
    total DECIMAL(8,2),                      
    FOREIGN KEY (venta_id) REFERENCES ventas(id),     
    FOREIGN KEY (producto_id) REFERENCES productos(id)  
);
show tables;

ALTER TABLE ventas
ADD iva DOUBLE,
ADD total DOUBLE;

UPDATE productos SET stock = stock + 10 WHERE id = 1; -- Pulsera de acero
UPDATE productos SET stock = stock + 10 WHERE id = 2; -- Collar de plata
UPDATE productos SET stock = stock + 10 WHERE id = 3; -- Anillo de oro


INSERT INTO productos (nombre, stock, precio) 
VALUES 
    ('Pendientes de oro', 10, 80.00),
    ('Pelota Jabulani', 12, 50.00),
    ('Airpods', 8, 200.00);

