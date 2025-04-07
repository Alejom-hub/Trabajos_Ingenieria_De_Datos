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
CALL realizar_pedido(1, 1, 1);
CALL realizar_pedido(2, 2, 2);
CALL realizar_pedido(2, 2, 1);
CALL realizar_pedido(3, 2, 1);
CALL realizar_pedido(3, 3, 1);
CALL realizar_pedido(1, 3, 2);
CALL realizar_pedido(4, 3, 2);
CALL realizar_pedido(2, 3, 2);
CALL realizar_pedido(1, 4, 2);
CALL realizar_pedido(3, 4, 2);
CALL realizar_pedido(1, 5, 2);
CALL realizar_pedido(1, 5, 2);


select * from pedidos_libros;

#listar los pedidos hechos por un cliente específico y obtener detalles de los libros comprados
select * from clientes join pedidos on clientes.idCliente = pedidos.idClienteFK
join pedidos_libros on pedidos.idPedido = pedidos_libros.idPedidoFK
join libros on pedidos_libros.idLibroFK = libros.idLibro
where idCliente = 1;



#Consultar el cliente que ha realizado el mayor número de pedidos. 
select clientes.nombreCliente, count(pedidos.idPedido) as total_pedidos
from clientes
join pedidos on clientes.idCliente = pedidos.idClienteFK 
group by clientes.idCliente
order by total_pedidos desc limit 1;


#Crear un procedimiento almacenado que permita registrar un nuevo pedido, actualizando la tabla de pedidos y reduciendo el stock del libro correspondiente
DELIMITER $$
CREATE PROCEDURE registrar_pedido (
    IN id_cliente INT,
    IN id_libro INT,
    IN cantidad INT
)
BEGIN
    -- Insertar el pedido en la tabla pedidos
    INSERT INTO pedidos (idClienteFK, fechaPedido) 
    VALUES (id_cliente, CURDATE());
    
    -- Insertar la relación entre el pedido y el libro en la tabla pedidos_libros
    INSERT INTO pedidos_libros (idLibroFK, idPedidoFK, cantidad_pedido_libros) 
    VALUES (id_libro, LAST_INSERT_ID(), cantidad);
    
    -- Actualizar el stock del libro en la tabla libros
    UPDATE libros
    SET cantidadLibro = cantidadLibro - cantidad
    WHERE idLibro = id_libro AND cantidadLibro >= cantidad;

    -- Verificar si hubo una actualización exitosa
    IF ROW_COUNT() = 0 THEN
        -- Si no se actualizó el stock (por falta de cantidad disponible), cancelar el pedido
        ROLLBACK;
        SELECT 'Error: No hay suficiente stock disponible' AS mensaje;
    ELSE
        -- Confirmación de éxito
        COMMIT;
        SELECT 'Pedido registrado con éxito' AS mensaje;
    END IF;
END$$

DELIMITER ;

CALL registrar_pedido(1, 1, 3);


#Selecciona los libros cuyo precio sea mayor a $20.00
select * from libros where precioLibro > 20.00;


#Selecciona los pedidos realizados después del 1 de octubre de 2024.
select * from pedidos
join clientes on pedidos.idClienteFK = clientes.idCliente
join pedidos_libros on pedidos.idPedido = pedidos_libros.idPedidoFK
join libros on pedidos_libros.idLibroFK = libros.idLibro
where pedidos.fechaPedido > "2024-10-01";

select * from pedidos where fechaPedido > "2024-10-01";

#Selecciona todos los libros ordenados por su precio de mayor a menor
select * from libros order by precioLibro desc;

#Obtén el total de clientes registrados en la tabla clientes. 
select count(idCliente) as total_clientes from clientes;

#Obtén el total de unidades vendidas en la tabla pedidos.
SELECT 
    SUM(pedidos_libros.cantidad_pedido_libros) AS total_unidades_vendidas
FROM 
    pedidos_libros;
    


# Muestra el número de pedidos realizados por cada cliente
SELECT 
    clientes.nombreCliente,
    clientes.apellidoCliente,
    COUNT(pedidos.idPedido) AS numero_de_pedidos
FROM 
    clientes
JOIN 
    pedidos ON clientes.idCliente = pedidos.idClienteFK
GROUP BY 
    clientes.idCliente
ORDER BY 
    numero_de_pedidos DESC;



#Muestra el nombre del cliente, el título del libro y la cantidad de cada pedido.
SELECT 
    clientes.nombreCliente,
    clientes.apellidoCliente,
    libros.nombreLibro,
    pedidos_libros.cantidad_pedido_libros
FROM 
    clientes
JOIN 
    pedidos ON clientes.idCliente = pedidos.idClienteFK
JOIN 
    pedidos_libros ON pedidos.idPedido = pedidos_libros.idPedidoFK
JOIN 
    libros ON pedidos_libros.idLibroFK = libros.idLibro;
    


#Muestra los títulos de los libros y la cantidad total vendida de cada uno.
    
SELECT 
    libros.nombreLibro,
    SUM(pedidos_libros.cantidad_pedido_libros) AS cantidad_total_vendida
FROM 
    libros
JOIN 
    pedidos_libros ON libros.idLibro = pedidos_libros.idLibroFK
GROUP BY 
    libros.idLibro;
