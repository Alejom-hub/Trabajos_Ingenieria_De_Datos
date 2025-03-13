create database TiendaMascota;
/*Habilitar la base de datos*/
use TiendaMascota;
/*Creacion de tablas*/
create table Mascota(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);
create table Cliente(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);
create table Producto(
codigoProducto int primary key,
nombreProducto varchar (15),
marca varchar (15),
precio float,
cedulaClienteFK int
);
create table Vacuna(
codigoVacuna int primary key,
nombreVacuna varchar (15),
dosisVacuna int (10),
enfermedad varchar (15)
);
create table Mascota_Vacuna(
codigoVacunaFK int,
idMascotaFK int,
enfermedad varchar (15)
);
/*crear las relaciones*/
alter table Cliente
add constraint FClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);

alter table Mascota_Vacuna
add constraint FKMV
foreign key (idMascotaFK)
references Mascota(idMascota );

alter table Mascota_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);


/*Insertar valores*/
/* Insert    into      nombreTabla   (van los campos cmmo se creo en la tabla, msmos nombres) values(valor1, valor2, valor3, "valor4") */

insert into mascota (idMascota, nombreMascota, generoMascota, razaMascota, cantidad)
values(1, "Rush", "Macho", "Criollo", 1);

insert into mascota values(2, "Macarena", "Hembra", "Criollo", 1);


/*Consulta general  Sintaxis:   SELECT  * from nombreTabla   */

SELECT * from mascota;
insert into mascota values(4, "Robalo", "Macho", "Pastor Aleman", 1);
insert into mascota values(5, "Rolo", "Macho", "Pug", 3);
insert into mascota values(6, "Alo", "Hembra", "Husky", 4);
insert into mascota values(7, "Libra", "Hembra", "Cocker", 1);
insert into mascota values(8, "Alem", "Hembra", "Bulldog", 4);
insert into mascota values(9, "Pollo", "Macho", "Labrador", 1);
insert into mascota values(10, "Simba", "Macho", "Chihuaua", 2);
insert into mascota values(11, "Sancho", "Macho", "Rottweiler", 1);

SELECT * from Producto;
insert into Producto (codigoProducto, nombreProducto, marca, precio, cedulaClienteFK) values 
(1, "bozal", "toys dog", 20000, 10123523), (2, "Pelota", "toys dog", 2500, 17892033),
 (3, "Peluche", "toys dog", 10000, 10146523), (4, "Galleta", "toys dog", 35000, 17891226);



SELECT * from Cliente;
insert into Cliente (cedulaCliente, nombreCliente, apellidoCliente, direccionCliente, telefono, idMascotaFK) 
values (10123523, "Juliana", "Moreno", "calle 1 #82 b 43", 3005030444, 1), (17892033, "Mariana", "Moreno", "carrera 5 # 89 c 45", 3024435543, 2),
(10146523, "Daniel", "Diaz", "calle 20 #65 b 43", 3105673046, 3), (17891226, "Julian", "Lozano", "calle 67 #22 a 33", 3224030544, 5);


SELECT * from Vacuna;
insert into Vacuna (idMascota, nombreMascota, generoMascota, razaMascota, cantidad);
insert into Vacuna
