/*Sentencias de DDL*/
/*Creacion de base de datos*/
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
create table Cliente1(
cedulaCliente int primary key ,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int,
FOREIGN KEY (idMascotaFK) REFERENCES Mascota(idMascota) ON DELETE CASCADE ON UPDATE CASCADE
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

/*Registros*/

insert into Mascota values (1,"Lucas", "M", "Golden Retriever", 2), (2,"Firulais", "M", "Labrador", 1);

insert into Cliente values ("1011032223","Rolando","Hernandez", "calle 7b #54 -56", "3005662366", 1), ("552360152","Mariana","Fernandez", "calle 8b #74 -23", "3105562236", 2);

insert into Vacuna values (1,"Rabia", 3, "Rabia"), (2,"Parvovirus", 2, "Fiebre y supresión inmunologicas" );

insert into producto values (1, "Amoxicilina", "Amoxaren" , 35000, "1011032223"), (2, "Posaconazol", "Clamoxyl" , 55000, "552360152");



select m.*, c.nombreCliente, p.nombreProduto
from Mascota m
join cliente c on m.idMascota=c.idMascotaFK
join producto p on p.cedulaClienteFK = c.cedulaCliente;





/*Eliminacion
#delete from   nombreTabla   where   conficion
*/

delete from producto where codigoProducto = 11;
describe producto;
delete from producto;




/*Procedimientos almacenados
Stored PRocedure conjunto de instrucciones de SQL que se almacenan en y estos se puede ejecutar muchas veces
*/
/*Encapsular logica de negocos en una base de datos, el procedimiento se conecta directamente a la base de datso y es mas seguro que hacer directamente una sentencia

SINTAXIS:

DELIMITER//
CREATE PROCEDURE nombreProcedimiento(parametros:   Entrada  IN,  Salida  OUT)

BEGIN
------Instrucciones

END

// DELIMITER

*/


select * from Mascota;
/*Creación Procedimiento Almacenado*/
DELIMITER //
CREATE PROCEDURE InsertarMascota(in idMascota int, nombreMascota varchar(15), generoMascota varchar(15), razaMascota varchar(15), cantidad int)
BEGIN
	insert into mascota values (idMascota, nombreMascota, 
    generoMascota, razaMascota, cantidad);

END //
DELIMITER ;
 /*Ecucuin el procedimiento
 Sintaxis:
 
 call   nombreProcedimiento (valores)
 */

call InsertarMascota(3, "Macarena", "H", "Criollo", 3);


select * from producto;


DELIMITER //
CREATE PROCEDURE ConsultarPrecio(out precio float)
BEGIN
	select count(*) into precio from producto;
    

END //
DELIMITER ;


CALL ConsultarPrecio(@resultado);
 select @resultado;
 
 
 
-- crear un procedimiento para insertar registros en tabla débil
-- crear procedimiento consultar las vacunas que se le ha aplicado a una mascota
-- y que enfermedad esta atacando
 
-- crear un procedimiento para insertar registros en tabla débil
DELIMITER //
CREATE PROCEDURE Insertar_Mascota_Vacuna(in codigoVacunaFK int, idMascotaFK int, enfermedad varchar(15))
BEGIN
	insert into mascota_vacuna values (codigoVacunaFK, idMascotaFK, enfermedad);
    

END //
DELIMITER ;

CALL Insertar_Mascota_Vacuna(1, 1, "Hepatitis");


-- crear procedimiento consultar las vacunas que se le ha aplicado a una mascota y que enfermedad esta atacando

DELIMITER //
CREATE PROCEDURE ConsultarVacunas(in idMascotaConsulta int)
BEGIN
	select vacuna.nombreVacuna, mascota_vacuna.enfermedad from mascota_vacuna
    join vacuna on mascota_vacuna.codigoVacunaFK  = vacuna.codigoVacuna
    join mascota on mascota_vacuna.idMascotaFK  = mascota.idMascota;
END //
DELIMITER ;

CALL ConsultarVacunas(1);
 
 
 
 


/*    Vista Views  
 Es una consulta que se almacena en la base
 de datos que genera una tabla virtual. 
 ESTAS NO PUEDEN MODIFICAR DATOS PORQUE SON CONSULTAS.
 Una vista va a mejorar la seguridad en las bases  de datos, porque no se pueden hacer cambios.
 
 
 SINTAXIS:
  /* 
  
  create view    nombreVista  as  
  select    valoresConsultar   from  nombreTabla   where   condiciones;
 
 
 PARA SU EJECUCION:
 SELECT * FROM    nombreVista
 
  */
  

/*MODIFICAR UNA  VISTA

alter view   nombreVista   as 
select    valoresConsultar   from  nombreTabla   where   condiciones;
*/


/*ELIMINAR UNA VISTA

drop view  nombreVista;
*/




create view vistaCliente as 
select * from cliente where cedulaCliente = "1011032223";

SELECT * FROM vistaCliente;

create view vistaClienteTel as 
select * from cliente where telefono between 4 and 7;


alter view   vistaClienteTel   as 
select * from cliente where telefono like "%4%"
and telefono like "%6%" and telefono like "%7%";


SELECT * FROM vistaClienteTel;





/* DISPARADORES O TRIGGERS   (desencadenador)
 
  TIPOS:
  
  - before insert
  - before update
  - before delete
	Estos se ejecutan antes de la operación


 - after insert
 - after update
 - after delete
	Estos se ejecuta despues de la operacion.

SINTAXIS:

DELIMITER //
CREATE   Trigger   NombreTrigger   
AFTER / BEFORE   INSERT ON   nombreTabla
FOR EACH row

BEGIN  
--- Instrucciones SQL


END //
DELIMITER;

*/


/*Crear un Trigger para registrar en una tabla consolidado cada vez que se inserte una mascota*/

CREATE table   consolidado(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);




DELIMITER //
CREATE   Trigger   registrarConsolidadoMascost
AFTER INSERT ON  mascota
FOR EACH row

BEGIN  
	INSERT INTO consolidado values (NEW.idMascota, new.nombreMascota, new.generoMascota, new.razaMascota, new.cantidad);
END //
DELIMITER  ;

select * from mascota;

insert into Mascota values (3,"Haniano", "F", "Criollo", 5);



CREATE table   consolidadoCliente2(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int,
FOREIGN KEY (idMascotaFK) REFERENCES Mascota(idMascota) ON DELETE CASCADE ON UPDATE CASCADE
);

DELIMITER //
CREATE   Trigger   registrarEliminado
AFTER delete ON  cliente1
FOR EACH row

BEGIN  
	INSERT INTO consolidadoCliente2 values (old.cedulaCliente, old.nombreCliente, old.apellidoCliente, old.direccionCliente, old.telefono, old.idMascotaFK);
END //
DELIMITER  ;


delete from Cliente where cedulaCliente  = 1011032223
