drop database if exists delivery;
create database delivery;
use delivery;

CREATE TABLE Restaurantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(255)
);

CREATE TABLE Platos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(8, 2),
    restaurante_id INT,
    FOREIGN KEY (restaurante_id) REFERENCES Restaurantes(id)
);

CREATE TABLE Ingredientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Platos_Ingredientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plato_id INT,
    ingrediente_id INT,
    eliminado BOOLEAN DEFAULT false,
    FOREIGN KEY (plato_id) REFERENCES Platos(id),
    FOREIGN KEY (ingrediente_id) REFERENCES Ingredientes(id)
);

CREATE TABLE Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plato_id INT,
    cantidad INT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (plato_id) REFERENCES Platos(id)
);

CREATE TABLE Pedidos_Ingredientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plato_id INT,
    ingrediente_id INT,
    FOREIGN KEY (plato_id) REFERENCES Platos(id),
    FOREIGN KEY (ingrediente_id) REFERENCES Ingredientes(id)
);
CREATE TABLE Pedidos_Platos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    plato_id INT,
    comentario VARCHAR(255),
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
    FOREIGN KEY (plato_id) REFERENCES Platos(id)
);

-- Insertar datos de ejemplo para restaurantes
INSERT INTO Restaurantes (nombre, direccion) VALUES
('La Cuchara Feliz', 'Calle de la Alegría, 123'),
('El Rincón del Sabor', 'Avenida del Gusto, 456'),
('Sabores del Mundo', 'Plaza de la Gastronomía, 789'),
('La Parrilla Dorada', 'Paseo de los Sabores, 101'),
('El Jardín Secreto', 'Carrera del Sabor, 222');

-- Insertar datos de ejemplo para platos
INSERT INTO Platos (nombre, precio, restaurante_id) VALUES
('Paella Valenciana', 15.99, 1),
('Sushi Variado', 20.99, 1),
('Pizza Margarita', 10.99, 1),
('Tacos al Pastor', 12.99, 1),
('Pasta Alfredo', 14.99, 1),

('Ensalada de Mariscos', 18.99, 2),
('Ceviche Peruano', 21.99, 2),
('Lomo Saltado', 16.99, 2),
('Ají de Gallina', 13.99, 2),
('Arroz Chaufa', 15.99, 2),

('Risotto de Champiñones', 17.99, 3),
('Tortellini de Carne', 22.99, 3),
('Lasagna Bolognesa', 12.99, 3),
('Spaghetti Carbonara', 14.99, 3),
('Pizza Margarita', 16.99, 3),

('Asado Argentino', 20.99, 4),
('Milanesa Napolitana', 23.99, 4),
('Empanadas Criollas', 14.99, 4),
('Choripán', 16.99, 4),
('Matambre a la Pizza', 18.99, 4),

('Sándwich de Pollo', 15.99, 5),
('Hamburguesa Clásica', 20.99, 5),
('Wrap de Vegetales', 10.99, 5),
('Ensalada César', 12.99, 5),
('Sopa de Tomate', 14.99, 5);

-- Insertar ingredientes
INSERT INTO Ingredientes (nombre) VALUES 
('Arroz'),
('Pollo'),
('Langostinos'),
('Salmón'),
('Queso Mozarella'),
('Tomate'),
('Salsa de tomate'),
('Masa de pizza'),
('Cilantro'),
('Limón'),
('Cebolla'),
('Carne de cerdo'),
('Piña'),
('Queso Parmesano'),
('Salsa de queso'),
('Crema'),
('Champiñones'),
('Aceitunas'),
('Jalapenios'),
('Lechuga'),
('Pimiento'),
('Zanahoria'),
('Pepino'),
('Aguacate'),
('Cebolla morada'),
('Aceite de oliva'),
('Vinagre balsámico'),
('Jamón serrano'),
('Huevo'),
('Aceite vegetal'),
('Salsa de soja'),
('Jengibre'),
('Wasabi'),
('Alga nori'),
('Queso cheddar'),
('Tocino'),
('Carne molida'),
('Espinacas'),
('Albahaca');

-- asociacion de los platos con sus ingredientes.
-- Paella Valenciana
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(1, 1),  -- Arroz
(1, 6),  -- Tomate
(1, 9),  -- Limón
(1, 10), -- Cebolla
(1, 11); -- Carne de cerdo

-- Sushi Variado
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(2, 3),  -- Langostinos
(2, 4),  -- Salmón
(2, 9),  -- Limón
(2, 14), -- Queso Parmesano
(2, 17); -- Cebolla

-- Pizza Margarita
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(3, 3),  -- Langostinos
(3, 4),  -- Salmón
(3, 8),  -- Masa de pizza
(3, 11), -- Carne de cerdo
(3, 15); -- Crema

-- Tacos al Pastor
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(4, 6),  -- Tomate
(4, 9),  -- Limón
(4, 11), -- Carne de cerdo
(4, 12), -- Piña
(4, 16); -- Crema

-- Pasta Alfredo
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(5, 2),  -- Pollo
(5, 5),  -- Queso Mozarella
(5, 6),  -- Tomate
(5, 10), -- Cebolla
(5, 15); -- Crema

-- Ensalada de Mariscos
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(6, 1),  -- Arroz
(6, 3),  -- Langostinos
(6, 4),  -- Salmón
(6, 5),  -- Queso Mozarella
(6, 6),  -- Tomate
(6, 11), -- Carne de cerdo
(6, 12); -- Piña

-- Ceviche Peruano
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(7, 2),  -- Pollo
(7, 3),  -- Langostinos
(7, 4),  -- Salmón
(7, 7),  -- Salsa de tomate
(7, 9),  -- Limón
(7, 10), -- Cebolla
(7, 13);-- Queso Parmesano

-- Lomo Saltado
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(8, 11), -- Carne de cerdo
(8, 12), -- Piña
(8, 16), -- Crema
(8, 17), -- Cebolla
(8, 18); -- Aceitunas

-- Ají de Gallina
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(9, 3),  -- Langostinos
(9, 5),  -- Queso Mozarella
(9, 8),  -- Masa de pizza
(9, 9),  -- Limón
(9, 14); -- Queso Parmesano

-- Arroz Chaufa
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(10, 1), -- Arroz
(10, 2), -- Pollo
(10, 3), -- Langostinos
(10, 4), -- Salmón
(10, 5); -- Queso Mozarella

-- Risotto de Champiñones
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(11, 6),  -- Tomate
(11, 8),  -- Masa de pizza
(11, 10), -- Cebolla
(11, 12), -- Piña
(11, 16); -- Crema

-- Tortellini de Carne
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(12, 1),  -- Arroz
(12, 2),  -- Pollo
(12, 3),  -- Langostinos
(12, 5),  -- Queso Mozarella
(12, 6),  -- Tomate
(12, 7); -- Salsa de tomate

-- Lasagna Bolognesa
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(13, 3),  -- Langostinos
(13, 4),  -- Salmón
(13, 9),  -- Limón
(13, 11), -- Carne de cerdo
(13, 14), -- Queso Parmesano
(13, 16); -- Crema

-- Spaghetti Carbonara
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(14, 1),  -- Arroz
(14, 2),  -- Pollo
(14, 5),  -- Queso Mozarella
(14, 6),  -- Tomate
(14, 9); -- Limón

-- Pizza Margarita
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(15, 3),  -- Langostinos
(15, 4),  -- Salmón
(15, 8),  -- Masa de pizza
(15, 10), -- Cebolla
(15, 14); -- Queso Parmesano

-- Asado Argentino
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(16, 2),  -- Pollo
(16, 5),  -- Queso Mozarella
(16, 6),  -- Tomate
(16, 8),  -- Masa de pizza
(16, 11); -- Carne de cerdo

-- Milanesa Napolitana
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(17, 2),  -- Pollo
(17, 3),  -- Langostinos
(17, 4),  -- Salmón
(17, 5),  -- Queso Mozarella
(17, 6); -- Tomate

-- Empanadas Criollas
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(18, 3),  -- Langostinos
(18, 4),  -- Salmón
(18, 6),  -- Tomate
(18, 7),  -- Salsa de tomate
(18, 8); -- Masa de pizza

-- Choripán
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(19, 6),  -- Tomate
(19, 8),  -- Masa de pizza
(19, 10),  -- Cebolla
(19, 11),  -- Carne de cerdo
(19, 16); -- Crema

-- Matambre a la Pizza
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(20, 6),  -- Tomate
(20, 7),  -- Salsa de tomate
(20, 8),  -- Masa de pizza
(20, 10), -- Cebolla
(20, 16); -- Crema

-- Sándwich de Pollo
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(21, 2),  -- Pollo
(21, 5),  -- Queso Mozarella
(21, 6),  -- Tomate
(21, 8),  -- Masa de pizza
(21, 9); -- Limón

-- Hamburguesa Clásica
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(22, 2),  -- Pollo
(22, 5),  -- Queso Mozarella
(22, 6),  -- Tomate
(22, 7),  -- Salsa de tomate
(22, 9); -- Limón

-- Wrap de Vegetales
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(23, 6),  -- Tomate
(23, 7),  -- Salsa de tomate
(23, 8),  -- Masa de pizza
(23, 9),  -- Limón
(23, 10); -- Cebolla

-- Ensalada César
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(24, 1),  -- Arroz
(24, 6),  -- Tomate
(24, 9),  -- Limón
(24, 10), -- Cebolla
(24, 11); -- Carne de cerdo

-- Sopa de Tomate
INSERT INTO Platos_Ingredientes (plato_id, ingrediente_id) VALUES 
(25, 1),  -- Arroz
(25, 6),  -- Tomate
(25, 7),  -- Salsa de tomate
(25, 9),  -- Limón
(25, 10); -- Cebolla


