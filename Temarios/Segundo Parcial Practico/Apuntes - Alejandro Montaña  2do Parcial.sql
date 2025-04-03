create database techCorp;

USE techCorp;




CREATE TABLE departamento(
    idDepto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

create table empleado(
	idEmpleado INT auto_increment primary key,
    docEmpleado VARCHAR(30) not null,
    nomEmpleado VARCHAR(40) not null,
    edadEmpleado VARCHAR(20) not null,
    idDeptoFK INT,
	añoContrato date not null,
    salarioEmpleado decimal(8, 2) not null,
    idCargoFK VARCHAR(40),
    FOREIGN KEY (idDeptoFK) REFERENCES departamento(idDepto) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idCargoFK) REFERENCES cargo(idCargo) ON DELETE CASCADE ON UPDATE CASCADE
);
###############################    MAS EJEMPLOS SOBRE LLAVES FORANEAS   ######################################
create table usuario(
	idUsuario INT auto_increment Primary Key,
    noDocUsuario VARCHAR (20) not null,
    idTipoDocFK INT,
    nombreUsuario VARCHAR(30) not null,
    apellidoUsuario VARCHAR (30) not null,
    idGeneroFK INT,
    fechaNacUsuario date not null,
    emailUsuario VARCHAR (50) not null,
    passwordUsuario VARCHAR (100) not null,
    fotoUsuario blob null,
    idJornadaFK INT,
    idTipoMiembroFK INT,
    idCursoFK INT,
    estadoU boolean not null,
    
	-- Asignacion de llaves foraneas
    FOREIGN KEY (idTipoDocFK) REFERENCES tipoDocumento(idTipoDoc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idGeneroFK) REFERENCES genero(idGenero) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idJornadaFK) REFERENCES jornada(idJornada) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idTipoMiembroFK) REFERENCES tipoMiembro(idTipoMiembro) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idCursoFK) REFERENCES curso(idCurso) ON DELETE CASCADE ON UPDATE CASCADE
);


##DIAGRAMA ER SE ABRE CON CTRL + R

create table cargo(
	idCargo VARCHAR(40) primary key,
    nombreCargo VARCHAR (40) not null,
    rangoCargo VARCHAR(40) not null,
	descripcionCargo VARCHAR(40)
);

select * from departamento;

INSERT INTO departamento VALUES ("", "IT"), ("","Ventas"), ("","Logistica"), ("","Marketing"), ("","Recursos Humanos");
INSERT INTO cargo VALUES
("10","Desarrollador de Software","1","Desarrollador de Software Junior"),(11,"Desarrollador de Software","2","Desarrollador de Software Senior"),
("20","Analista de Datos","1","Analista de Datos Junior"),("21","Analista de Datos","2","Analista de Datos Senior"),
("30","Analista de Mercado","1","Analista de Mercado Junior"),("31","Analista de Mercado","2","Analista de Mercado Senior"),
("40","Jefe de Distribución","1","Jefe de Distribucion Junior"),("41","Jefe de Distribución","2","Jefe de Distribucion Senior"),
("50","Gerente de Logistica","1","Gerente de Logistica Junior"),("51","Gerente de Logistica","2","Gerente de Logistica Senior"),
("60","Director de Marketing","1","Director de Marketing Junior"),("61","Director de Marketing","2","Director de Marketing Senior"),
("70","Gerente de Recursos Humanos","1","Gerente de Recursos Humanos Junior"),("71","Gerente de Recursos Humanos","2","Gerente de Recursos Humanos Senior");


INSERT INTO empleado(idEmpleado,docEmpleado,nomEmpleado,edadEmpleado,idDeptoFK,añoContrato,salarioEmpleado,idCargoFK) VALUES ("","103456437","Fernando Hernandez","20 Años",1, "2024-05-12" ,"2850,50",10),
("","104563454","Andres Saenz","25 Años",2, "2022-08-19" ,"4000,50",20), ("","486904367","Laura Fernandez","40 Años",3, "2017-05-12" ,"13500,50",31), 
("","106789546","Sofia Benitez","20 Años",3, "2025-01-15" ,"2200,50",30), ("","115645890","Sebastian Diaz","24 Años",3, "2022-05-12" ,"7500,50", 31),
("", "305678934", "Luis Ramirez", "30 Años", 1, "2020-02-28", "3200.00",40), ("", "901234567", "Raul Fernandez", "40 Años",4, "2015-07-20", "10500.80", 41),
("", "678905432", "Elena Suarez", "35 Años", 2, "2018-04-30", "6100.45",21);

select * from empleado;
/* 1.   Lista de empleados: Obtén los nombres, edades y salarios de todos los empleados de TechCorp.*/
select nomEmpleado, edadEmpleado, salarioEmpleado from empleado;

/*2. Altos ingresos: ¿Quiénes son los empleados que ganan más de $4,000?*/
select idEmpleado, nomEmpleado, salarioEmpleado from empleado where salarioEmpleado > "4000.00";

/*3. Fuerza de ventas: Extrae la lista de empleados que trabajan en el departamento de Ventas.*/
select idEmpleado, nomEmpleado, deparEmpleado from empleado where deparEmpleado = "Ventas";

/* 4. Rango de edad: Encuentra a los empleados que tienen entre 30 y 40 años. */
select idEmpleado, nomEmpleado, edadEmpleado from empleado where edadEmpleado >= "30 Años" and edadEmpleado <= "40 Años";


/* 5. Nuevas contrataciones: ¿Quiénes han sido contratados después del año 2020? */
select idEmpleado, nomEmpleado, añoContrato from empleado where añoContrato >= "2020-01-01" ;

/* 6. Distribución de empleados: ¿Cuántos empleados hay en cada departamento? */
select COUNT(deparEmpleado) as "Empleados de Ventas" from empleado where deparEmpleado = "Ventas";
select COUNT(deparEmpleado) as "Empleados de Information Technologhy" from empleado where deparEmpleado = "Information Technologhy";

/* 7. Análisis salarial: ¿Cuál es el salario promedio en la empresa? */
select AVG(salarioEmpleado ) as "Salario Promedio" from empleado;


/* 8. Nombres selectivos: Muestra los empleados cuyos nombres comienzan con "A" o "C"*/
select idEmpleado, docEmpleado, nomEmpleado as "Nombres por A" from empleado where nomEmpleado like "A%" or nomEmpleado like "C%";


/* 9. Departamentos específicos: Encuentra a los empleados que no pertenecen al departamento de IT. */
select idEmpleado, nomEmpleado, docEmpleado, deparEmpleado from empleado where deparEmpleado<>"Information Technologhy";


/* 10. El mejor pagado: ¿Quién es el empleado con el salario más alto?*/
select idEmpleado, nomEmpleado, docEmpleado, salarioEmpleado from empleado where salarioEmpleado = (select max(salarioEmpleado) from empleado);


/*Sentencias agregadas - */


/*Consultar rangos    between  ... and  */
select * from empleado where idEmpleado between 1 and 5;

/*consultar un valor que este dentro de una lista de valores   in*/
select * from empleado where deparEmpleado in ("Ventas");



/*si un campo es nulo is null¨*/
select * from empleado where nomEmpleado is null;


select * from empleado order by salarioEmpleado ;

/*Hay algun departamento nulo*/
select * from empleado where deparEmpleado is null;



/*año de antiguedad*/
select *, ("2025-03-15"- añoContrato) as "anios contratados" from empleado ;

SELECT nomEmpleado, añoContrato, timestampdiff(day, añoContrato, curdate()) as "Tiempo trabajado" from empleado;



/*Mejores 3 salarios */
select * from empleado order by salarioEmpleado desc limit 3;



/* Bono por llevar mas de 5 años trabajando  */
select nomEmpleado, salarioEmpleado, timestampdiff(year, añoContrato, curdate()) as "años trabajados", salario*0.1 as "Bono" from empleado where (timestampdiff(year, añoContrato, curdate()))>5;


/*Empleados con mayor salarioque la media del salario */

select count(*) from empleado where salarioEmpleado >(select avg(salarioEmpleado) from empleado);


/*Departamentos, conteo de ellos*/
select * from empleado group by nomEmpleado desc;

/*Empleados que gannen mas y lleven mas de 5 años trabajando*/
select nomEmpleado, salarioEmpleado, timestampdiff(year, añoContrato, curdate()) as "años trabajados" from empleado where timestampdiff(year, añoContrato, curdate())> (select max(timestampdiff(year, añoContrato, curdate())) as "mayor años" from empleado)
and salarioEmpleado >= (select max(salarioEmpleado) from empleado) order by salarioEmpleado desc limit 5;




/* -------------------------- HAVING -------------------------- */

select deparEmpleado, count(*) from empleado group by deparEmpleado having count(*) >=5;






/*-------------------- MODIFICACION --------------------*/

/*sintaxis   update   nombreTAbla   set campol = "valor de remplazo"   where   llaveprimaria = "valor"*/
select * from empleado;
update empleado set nomEmpleado = "Gabriel" where idEmpleado = 1;


/*sentencia delete  "siempre debe llevar una clausula where"*/
/*sintaxis   delete   from   nombreTabla   where   condicion*/









/* -------------------------- MULTICONSULTA --------------------------

consultas que permiten manipular datos sobre mas de una tabla*/
/*el join permite hacer consultas multitabla, y en este hay varios tipos como:
Filas = registros
Columnas = campos

inner join: Devuelve las filas que coincidan en varias tablas (Interseccion)
left join: Devuelve las filas de la tabla izquierda y las que coincidan con las de la izquierda.
right join: Devuelve las filas de la tabla derecha y las que coincidan con las de la derecha.
full join: Devuelve todas las filas de las tablas.

Estructura:   

select   nombreCampo1deTabla1, nombreCampo2detabla2, from   tabla1  inner join  tabla2   on   tabla1.nombreColumnaTabla1 = tabla2.nombreColumnaTabla2
inner join tabla3 on tabla1.nombreColumnaTabla1 = tabla3.nombreColumnaTabla3  */







/*Muestre los nombres de los empleado y los nombresde los departamentos a los que pertenecer*/
select nomEmpleado as "Nombre Empleado", nombre as "Departamento" from   empleado  inner join  departamento on   empleado.idDeptoFK = departamento.idDepto;


/*1. Hacer una consulta de todos los cargos que tengan un rango especifico*/
select idCargo, nombreCargo, rangoCargo, descripcionCargo from cargo where rangoCargo = 1;


/* 2. Mostrar en pantalla los empleados que tengan un cargo especifico*/
select nomEmpleado as "Nombre Empleado", nombreCargo as "Nombre Cargo" from empleado inner join cargo on empleado.idCargoFK = cargo.idCargo;

/* 3. Mostrar todos los empleados que tengan una antiguedad de mas de 3 años y a que departamento pertenecen, que cargo y salario ganan*/
select
nomEmpleado as "Nombre Empleado",
departamento.nombre as "Departamento",
cargo.nombreCargo as "Cargo Empleado",
salarioEmpleado as "Salario Empleado",
timestampdiff(year,añoContrato, curdate()) as "Años de Antiguedad" 	
from empleado
inner join departamento on empleado.idDeptoFK = departamento.idDepto 
inner join cargo on empleado.idCargoFK = cargo.idCargo 
where timestampdiff(year, añoContrato, curdate()) >= 3;

/* 4. Mostrar toda la informacion del empleado, fecha en la que se contrato, departamento al que pertenece, años de antiguedad en la empresa, cargo que tiene actualmente y el rango del cargo que tiene. */
select 
idEmpleado as "ID Empleado",
nomEmpleado as "Nombre Empleado",
añoContrato as "Año Contrato del Empleado",
departamento.nombre as "Nombre Departamento",
timestampdiff(year, añoContrato, curdate()) as "Años de Antiguedad",
cargo.nombreCargo as "Cargo Empleado",
cargo.rangoCargo as "Rango de Cargo"
from empleado
inner join departamento on empleado.idDeptoFK = departamento.idDepto
inner join cargo on empleado.idCargoFK = cargo.idCargo
order by idEmpleado asc;


/* 5. Mostrar todos los departamentos que no tengan empleados asignados.*/
select * from departamento left join empleado on departamento.idDepto = empleado.idDeptoFK where empleado.idEmpleado is null;

/* 6. Mostrar todos los cargos que no tengan empleados asignados*/
select 
idCargo as "Id Cargo",
nombreCargo as "Nombre del Cargo",
rangoCargo as "Rango del Cargo"
from cargo left join empleado on cargo.idCargo = empleado.idCargoFK where empleado.idCargoFK is null;






/* EJERCICIOS DE PRACTICA */

/*1️ Lista todos los empleados con su nombre, edad y salario, ordenados por salario de mayor a menor.**/

select * from empleado 
group by salarioEmpleado desc;


/*2️ Muestra el nombre de los empleados y el departamento al que pertenecen.*/
select 
nomEmpleado as "Nombre del Empleado",
departamento.nombre as "Departamento"
from empleado
inner join departamento on empleado.idDeptoFK = departamento.idDepto;

/* 3.Encuentra los empleados que tienen un salario superior a 5,000. */
select 
nomEmpleado as "Nombre del Empleado",
salarioEmpleado as "Salario del Empleado"
from empleado
where salarioEmpleado >= 5000;

/*4️. Obtén los empleados contratados en el año 2022.*/
select 
nomEmpleado as "Nombre del Empleado",
añoContrato as "Año de Contrato",
timestampdiff(year, añoContrato, curdate())
from empleado
where añoContrato between "2022-01-01" and "2022-12-31";

/* 5️. Cuenta cuántos empleados hay en cada departamento.*/

select *, count(empleado.idEmpleado) from departamento left join empleado on departamento.idDepto = empleado.idDeptoFK
group by departamento.nombre;



/*Eliminacion
#delete from   nombreTabla   where   conficion
*/

delete from producto where codigoProducto = 11;
describe producto;
delete from producto;





/* -------------------------- PROCEDIMIENTOS ALMACENADOS --------------------------

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


/*--------------------------EJEMPLO 2--------------------------*/
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



### EJEMPLOS



-- Consultas
#1.  Consulta que muestre el nombre de cada concejo, que tenga asignado un cargo con el nombre del cargo, con su estado.
select nomConcejo as "Concejo", nomCargo "Nombre Cargo", estadoC as "Estado del Cargo" from  cargo inner join concejo on cargo.idConcejoFK = concejo.idConcejo;

#2. Realice una consulta que muestre el nomvre de cada concejo, el nombre del cargo al que pertenece y estado actual del mismo.

select nomConcejo as "Concejo", nomCargo "Nombre Cargo", estadoC as "Estado del Cargo" from  concejo left join cargo on concejo.idConcejo = cargo.idConcejoFK ;

#3. Realice una consulta que muestre cada usuario con su jornada, tipo de miembro y curso
select idUsuario as "Id del Usuario", nombreUsuario as "Nombre Usuario", apellidoUsuario as "Apellido Usuario", idTipoMiembro as "Tipo de Miembro", idCurso as "Curso", idJornada as "Jornada" from usuario
inner join tipoMiembro on usuario.idTipoMiembroFK = tipoMiembro.idTipoMiembro
inner join curso on usuario.idCursoFK = curso.idCurso
inner join jornada on usuario.idJornadaFK = jornada.idJornada;

#4. Agregue el campo a la tabla estudiante llamada profesión.
alter table tipoMiembro add column profesion varchar(40);
select * from tipoMiembro;


############## JOINS ###########################
#5. Realice una consulta que muestre la cantidad de votos obtenidos por cada candidato en las votaciones registradas. 
SELECT 
    postulacion_candidato.idPostCandidato AS "Id del Candidato",
    usuario.nombreUsuario AS "Nombre del Candidato",
    usuario.apellidoUsuario AS "Apellido del Candidato",
    cargo.nomCargo AS "Cargo",
    COUNT(votacion.idVotacion) AS "Cantidad de Votos"
FROM 
    postulacion_candidato
INNER JOIN usuario ON postulacion_candidato.idUsuarioFK = usuario.idUsuario
INNER JOIN cargo ON postulacion_candidato.idCargoFK = cargo.idCargo
LEFT JOIN votacion ON postulacion_candidato.idPostCandidato = votacion.idPostCandidatoFK
GROUP BY 
    postulacion_candidato.idPostCandidato, 
    usuario.nombreUsuario, 
    usuario.apellidoUsuario, 
    cargo.nomCargo;


/* 2. Mostrar en pantalla los empleados que tengan un cargo especifico*/
select nomEmpleado as "Nombre Empleado", nombreCargo as "Nombre Cargo" from empleado inner join cargo on empleado.idCargoFK = cargo.idCargo;

/* 3. Mostrar todos los empleados que tengan una antiguedad de mas de 3 años y a que departamento pertenecen, que cargo y salario ganan*/
select
nomEmpleado as "Nombre Empleado",
departamento.nombre as "Departamento",
cargo.nombreCargo as "Cargo Empleado",
salarioEmpleado as "Salario Empleado",
timestampdiff(year,añoContrato, curdate()) as "Años de Antiguedad" 	
from empleado
inner join departamento on empleado.idDeptoFK = departamento.idDepto 
inner join cargo on empleado.idCargoFK = cargo.idCargo 
where timestampdiff(year, añoContrato, curdate()) >= 3;

/* 4. Mostrar toda la informacion del empleado, fecha en la que se contrato, departamento al que pertenece, años de antiguedad en la empresa, cargo que tiene actualmente y el rango del cargo que tiene. */
select 
idEmpleado as "ID Empleado",
nomEmpleado as "Nombre Empleado",
añoContrato as "Año Contrato del Empleado",
departamento.nombre as "Nombre Departamento",
timestampdiff(year, añoContrato, curdate()) as "Años de Antiguedad",
cargo.nombreCargo as "Cargo Empleado",
cargo.rangoCargo as "Rango de Cargo"
from empleado
inner join departamento on empleado.idDeptoFK = departamento.idDepto
inner join cargo on empleado.idCargoFK = cargo.idCargo
order by idEmpleado asc;


/* 5. Mostrar todos los departamentos que no tengan empleados asignados.*/
select * from departamento left join empleado on departamento.idDepto = empleado.idDeptoFK where empleado.idEmpleado is null;

/* 6. Mostrar todos los cargos que no tengan empleados asignados*/
select 
idCargo as "Id Cargo",
nombreCargo as "Nombre del Cargo",
rangoCargo as "Rango del Cargo"
from cargo left join empleado on cargo.idCargo = empleado.idCargoFK where empleado.idCargoFK is null


#PROCEDIMIENTOS ALMACENADOS
-- 1.
#6. Implemente tres procedimientos almacenados, tres vistas y dos subconsultas
DELIMITER //
CREATE PROCEDURE ObtenerVotosPorCandidato(IN idEleccionParam INT, IN idCandidatoParam INT)
BEGIN
    SELECT 
        postulacion_candidato.idPostCandidato AS "Id del Candidato",
        usuario.nombreUsuario AS "Nombre del Candidato",
        usuario.apellidoUsuario AS "Apellido del Candidato",
        cargo.nomCargo AS "Cargo",
        COUNT(votacion.idVotacion) AS "Cantidad de Votos"
    FROM 
        postulacion_candidato
    INNER JOIN usuario ON postulacion_candidato.idUsuarioFK = usuario.idUsuario
    INNER JOIN cargo ON postulacion_candidato.idCargoFK = cargo.idCargo
    LEFT JOIN votacion ON postulacion_candidato.idPostCandidato = votacion.idPostCandidatoFK
    WHERE 
        postulacion_candidato.idEleccionFK = idEleccionParam
        AND postulacion_candidato.idPostCandidato = idCandidatoParam
    GROUP BY 
        postulacion_candidato.idPostCandidato, 
        usuario.nombreUsuario, 
        usuario.apellidoUsuario, 
        cargo.nomCargo;
END //
DELIMITER ;


-- 2.
DELIMITER //
CREATE PROCEDURE ObtenerUsuariosPorCurso(IN idCursoParam INT)
BEGIN
    SELECT 
        idUsuario AS "Id del Usuario", 
        nombreUsuario AS "Nombre del Usuario", 
        apellidoUsuario AS "Apellido del Usuario"
    FROM usuario
    WHERE idCursoFK = idCursoParam;
END //
DELIMITER ;


-- 3.
DELIMITER //
CREATE PROCEDURE ObtenerCandidatosPorEleccion(IN idEleccionParam INT)
BEGIN
    SELECT 
        postulacion_candidato.idPostCandidato AS "Id del Candidato",
        usuario.nombreUsuario AS "Nombre del Candidato",
        usuario.apellidoUsuario AS "Apellido del Candidato",
        cargo.nomCargo AS "Cargo"
    FROM 
        postulacion_candidato
    INNER JOIN usuario ON postulacion_candidato.idUsuarioFK = usuario.idUsuario
    INNER JOIN cargo ON postulacion_candidato.idCargoFK = cargo.idCargo
    WHERE postulacion_candidato.idEleccionFK = idEleccionParam;
END //
DELIMITER ;

#VISTAS
-- 1.
CREATE VIEW VistaVotosPorCandidato AS
SELECT 
    postulacion_candidato.idPostCandidato AS "Id del Candidato",
    usuario.nombreUsuario AS "Nombre del Candidato",
    usuario.apellidoUsuario AS "Apellido del Candidato",
    cargo.nomCargo AS "Cargo",
    COUNT(votacion.idVotacion) AS "Cantidad de Votos",
    eleccion.fechaEleccion AS "Fecha de la Elección"
FROM 
    postulacion_candidato
INNER JOIN usuario ON postulacion_candidato.idUsuarioFK = usuario.idUsuario
INNER JOIN cargo ON postulacion_candidato.idCargoFK = cargo.idCargo
INNER JOIN eleccion ON postulacion_candidato.idEleccionFK = eleccion.idEleccion
LEFT JOIN votacion ON postulacion_candidato.idPostCandidato = votacion.idPostCandidatoFK
GROUP BY 
    postulacion_candidato.idPostCandidato, 
    usuario.nombreUsuario, 
    usuario.apellidoUsuario, 
    cargo.nomCargo, 
    eleccion.fechaEleccion;

-- 2.
CREATE VIEW VistaUsuariosPorCursoYJornada AS
SELECT 
    idUsuario AS "Id del Usuario", 
    nombreUsuario AS "Nombre del Usuario", 
    apellidoUsuario AS "Apellido del Usuario", 
    curso.numCurso AS "Curso", 
    jornada.nomJornada AS "Jornada"
FROM 
    usuario
INNER JOIN curso ON usuario.idCursoFK = curso.idCurso
INNER JOIN jornada ON usuario.idJornadaFK = jornada.idJornada;


# SUBCONSULTAS 
#1.
SELECT 
    postulacion_candidato.idPostCandidato AS "Id del Candidato",
    usuario.nombreUsuario AS "Nombre del Candidato",
    usuario.apellidoUsuario AS "Apellido del Candidato",
    cargo.nomCargo AS "Cargo",
    COUNT(votacion.idVotacion) AS "Cantidad de Votos"
FROM 
    postulacion_candidato
INNER JOIN usuario ON postulacion_candidato.idUsuarioFK = usuario.idUsuario
INNER JOIN cargo ON postulacion_candidato.idCargoFK = cargo.idCargo
LEFT JOIN votacion ON postulacion_candidato.idPostCandidato = votacion.idPostCandidatoFK
GROUP BY 
    postulacion_candidato.idPostCandidato, 
    usuario.nombreUsuario, 
    usuario.apellidoUsuario, 
    cargo.nomCargo
HAVING 
    COUNT(votacion.idVotacion) = (SELECT MAX(COUNT(votacion.idVotacion)) FROM votacion WHERE votacion.idPostCandidatoFK = postulacion_candidato.idPostCandidato);

#2.
SELECT 
    usuario.nombreUsuario AS "Nombre del Usuario", 
    usuario.apellidoUsuario AS "Apellido del Usuario"
FROM 
    usuario
WHERE 
    idUsuario IN (SELECT idUsuarioFK FROM votacion GROUP BY idUsuarioFK HAVING COUNT(idVotacion) > 1);




