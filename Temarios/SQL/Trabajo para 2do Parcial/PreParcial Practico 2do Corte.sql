create database biblioteca_onlineBD;

use biblioteca_onlineBD;


create table clientes(
	idCliente INT auto_increment Primary Key,
    nombreCliente VARCHAR (20) not null,
    apellidoCliente VARCHAR (20) not null
);

create table libros(
	idLibro int primary key,
	nombreLibro varchar (15) not null,
	cantidadLibro int not null,
	precioLibro float
);

create table pedidos(
	idPedido int auto_increment Primary Key,
    idLibroFK INT,
    idClienteFK INT, 
	fechaPedido date not null,
	FOREIGN KEY (idLibroFK) REFERENCES libros(idLibro) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idClienteFK) REFERENCES clientes(idCliente) ON DELETE CASCADE ON UPDATE CASCADE
);


create table pedidos_libros(
	idPedidos_libros int auto_increment primary key,
    idLibroFK INT,
    idPedidoFK INT,
    cantidad_pedido_libros int not null,
	FOREIGN KEY (idLibroFK) REFERENCES libros(idLibro) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idPedidoFK) REFERENCES pedidos(idPedido) ON DELETE CASCADE ON UPDATE CASCADE
);




-- Inserciones
#Clientes
INSERT INTO clientes (nombreCliente, apellidoCliente) VALUES
('Carlos', 'Gomez'),
('Laura', 'Martínez'),
('José', 'Pérez'),
('Ana', 'Rodríguez'),
('Luis', 'Hernández');

#Libros
INSERT INTO libros (idLibro, nombreLibro, cantidadLibro, precioLibro) VALUES
(1, 'Cien Años de Soledad', 4 , 19.99),
(2, 'El Quijote',5 , 24.50),
(3, '1984',7 , 15.75),
(4, 'La Sombra del Viento', 1, 22.30),
(5, 'El Alquimista', 5, 18.90);



#Pedidos
INSERT INTO pedidos (idLibroFK, idClienteFK, fechaPedido) VALUES
(1, 1, '2025-03-25'),
(2, 3, '2025-03-26'),
(3, 2, '2025-03-27'),
(4, 4, '2025-03-28'),
(5, 5, '2025-03-29');


#1. Actualizar el stock de los libros una vez que se realice el pedido


DELIMITER $$

CREATE PROCEDURE realizar_pedido (
    IN id_cliente INT,
    IN id_libro INT,
    IN cantidad INT
)
BEGIN
    DECLARE id_pedido INT;
    
    -- Insertar el pedido en la tabla pedidos
    INSERT INTO pedidos (idClienteFK, fechaPedido) 
    VALUES (id_cliente, CURDATE());
    
    -- Obtener el id del pedido recién insertado
    SET id_pedido = LAST_INSERT_ID();
    
    -- Insertar la relación entre el pedido y el libro en la tabla pedidos_libros
    INSERT INTO pedidos_libros (idLibroFK, idPedidoFK, cantidad_pedido_libros) 
    VALUES (id_libro, id_pedido, cantidad);
    
    -- Actualizar el stock del libro en la tabla libros
    UPDATE libros
    SET cantidadLibro = cantidadLibro - cantidad
    WHERE idLibro = id_libro;
    
END$$

DELIMITER ;


-- Realizar un pedido con id_cliente = 1, id_libro = 2 y cantidad = 3
CALL realizar_pedido(1, 2, 3);

select * from libros