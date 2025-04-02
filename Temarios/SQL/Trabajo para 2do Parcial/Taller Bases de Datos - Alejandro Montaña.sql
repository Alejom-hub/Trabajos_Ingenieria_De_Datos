create database votaciones2503816;

use votaciones2503816;


create table genero(
	idGenero INT auto_increment Primary Key,
    nomGenero VARCHAR (40) not null,
    estadoG boolean not null
);

create table jornada(
	idJornada INT auto_increment Primary Key,
    nomJornada VARCHAR (40) not null,
    estadoJ boolean not null
);

create table tipoDocumento(
	idTipoDoc INT auto_increment Primary Key,
    nomTipoDoc VARCHAR (40) not null,
    estadoTD boolean not null
);


create table tipoMiembro(
	idTipoMiembro INT auto_increment Primary Key,
    nomTipoMiembro VARCHAR (40) not null,
    estadoTM boolean not null
);

create table curso(
	idCurso INT auto_increment Primary Key,
    numCurso VARCHAR (10) not null,
    estadoCU boolean not null
);

create table concejo(
	idConcejo INT auto_increment Primary Key,
    nomConcejo VARCHAR (40) not null,
    estadoCO boolean not null
);

create table cargo(
	idCargo INT auto_increment Primary Key,
    nomCargo VARCHAR (40) not null,
    idConcejoFK INT,
    estadoC boolean not null,
    FOREIGN KEY (idConcejoFK) REFERENCES concejo(idConcejo) ON DELETE CASCADE ON UPDATE CASCADE
);

create table eleccion(
	idEleccion INT auto_increment Primary Key,
    fechaEleccion date not null,
    anioEleccion year not null,
    estadoEL boolean not null
);

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



create table postulacion_candidato(
	idPostCandidato INT auto_increment Primary Key,
    idUsuarioFK INT,
    idEleccionFK INT,
    idCargoFK INT,
    propuestas VARCHAR (200) not null,
    totalVotos INT not null,
    estadoCan boolean not null,
    -- Asignacion de llaves foraneas
    FOREIGN KEY (idUsuarioFK) REFERENCES usuario(idUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idEleccionFK) REFERENCES eleccion(idEleccion) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idCargoFK) REFERENCES cargo(idCargo) ON DELETE CASCADE ON UPDATE CASCADE
    
);

create table votacion(
	idVotacion INT auto_increment Primary Key,
    horaVotacion time not null,
    idUsuarioFK INT,
    idPostCandidatoFK INT,
    estadoV boolean not null,
    
    -- Asignacion de llaves foraneas
    FOREIGN KEY (idUsuarioFK) REFERENCES usuario(idUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idPostCandidatoFK) REFERENCES postulacion_candidato(idPostCandidato) ON DELETE CASCADE ON UPDATE CASCADE
    
);

-- insercion de valores para los campos creados:
#1 Datos Genero
insert into genero values (1,'Femenino',true), (2,'Masculino',true);

#2 Datos Jornada
insert into jornada values (1,'Mañana',true),(2,'Tarde',true),(3,'Noche',true);

#3 Datos tipoDocumento
insert into tipoDocumento values (1,'Tarjeta de Identidad',true),(2,'Cédula Ciudadanía',true),(3,'Cédula Extranjeria',true),(4,'Pasaporte',true),(5,'NUIP',false);

#4 Datos tipoMiembro
insert into tipoMiembro values (1, 'Estudiante',true),(2,'Profesor',true),(3,'Acudiente',true);

#5 Datos curso
insert into curso values (1,'901',true),(2,'902',true),(3,'1001',true),(4,'1002',true),(5,'1003',false),(6,'1101',true),(7,'1102',true),(8,'1103',false);

#6 Datos concejo
insert into concejo values (1,'Concejo Académico',true),(2,'Concejo Directivo',true),(3,'Concejo Convivencia',true);

#7 Datos cargo
insert into cargo values (1,'Personero',1,true),(2,'Contralor',1,true),(3,'Cabildante',1,true);

#8 Datos eleccion
insert into eleccion values (1,'2020-04-20','2020',true),(2,'2019-04-15','2019',true),(3,'2019-04-12','2019',false),(4,'2018-04-14','2018',true),(5,'2017-04-12','2017',true);

#9.1 Datos Usuario
describe usuario;
insert into usuario values (1, "1040520114", 1, "Juan", "Jimenez", 2, "2006-04-21","jimeneezzjuan06@gmail.com", "252236JimJu","",1,1,3,true ),
						   (2, "1020345678", 2, "Ana", "Martínez", 1, "2005-11-15", "anamartinez@gmail.com", "AnaMart10", "", 2, 1, 2, true),
						   (3, "1087654321", 3, "Carlos", "Gómez", 2, "2004-02-25", "carlosgomez@mail.com", "CarlosGomez21", "", 1, 2, 3, true),
						   (4, "1045876453", 1, "Pedro", "Rodríguez", 2, "2007-08-10", "pedro1234@mail.com", "PedroRodriguez34", "", 3, 1, 1, true),
                           (5, "1050321346", 2, "Sofía", "López", 1, "2006-03-21", "sofia_lopez@mail.com", "SofiaLopez20", "", 2, 3, 1, true),
                           (6, "1032347654", 1, "Javier", "Sánchez", 2, "2003-06-30", "javier_sanchez@mail.com", "JavierSanchez50", "", 1, 2, 2, true),
                           (7, "1098765432", 2, "Laura", "Fernández", 1, "2008-01-19", "laura_fernandez@gmail.com", "LauraFernandez21", "", 3, 3, 3, true),
                           (8, "1047563921", 3, "Ricardo", "Pérez", 1, "2006-05-15", "ricardo.perez@mail.com", "RicardoPerez89", "", 2, 1, 2, true),
                           (9, "1065432109", 2, "Marta", "García", 1, "2005-09-22", "marta.garcia@mail.com", "MartaGarcía77", "", 1, 2, 3, true),
                           (10, "1076538490", 3, "Luis", "Hernández", 2, "2004-11-03", "luis_hernandez@mail.com", "LuisHernandez08", "", 3, 1, 1, true);
#9 Datos votacion
insert into votacion values (1,'12:08:15',1,1,true),(2,'12:12:35',2,3,true),(3,'12:14:18',3,2,true),(4,'12:15:58',4,2,true),(5,'12:18:02',5,3,true),
(6,'12:24:22',6,3,true),(7,'12:28:02',7,3,true),(8,'12:30:14',8,2,true),(9,'12:40:20',9,2,true),(10,'12:45:20',10,2,true);

#10 Datos postulacion_candidato
insert into postulacion_candidato values (1,1,1,1,'Mejorar entrega refrigerios, Alargar descansos',0,true), (2,5,1,1,'Mejorar entrega refrigerios, Alargar descansos',0,true), (3,7,1,1,'Mejorar sala de informática, Construir piscina',0,true);



-- Consultas
#1.  Consulta que muestre el nombre de cada concejo, que tenga asignado un cargo con el nombre del cargo, con su estado.
select nomConcejo as "Concejo", nomCargo "Nombre Cargo", estadoC as "Estado del Cargo" from  cargo inner join concejo on cargo.idConcejoFK = concejo.idConcejo;

#2. Realice una consulta que muestre el nomvre de cada concejo, el nombre del cargo al que pertenece y estado actual del mismo.

select nomConcejo as "Concejo", nomCargo "Nombre Cargo", estadoC as "Estado del Cargo" from  concejo left join cargo on concejo.idConcejo = cargo.idConcejoFK ;

#3. Realice una consulta que muestre cada usuario con su jornada, tipo de miembro y curso
select usuario.idUsuario as "Id del Usuario", usuario.nombreUsuario as "Nombre Usuario", usuario.apellidoUsuario as "Apellido Usuario", tipoMiembro.nomTipoMiembro as "Tipo de Miembro",
curso.numCurso as "Curso", jornada.nomJornada as "Jornada" from usuario
inner join tipoMiembro on usuario.idTipoMiembroFK = tipoMiembro.idTipoMiembro
inner join curso on usuario.idCursoFK = curso.idCurso
inner join jornada on usuario.idJornadaFK = jornada.idJornada;



#4. Agregue el campo a la tabla estudiante llamada profesión.
alter table tipoMiembro add column profesion varchar(40);
select * from tipoMiembro;

#5. Realice una consulta que muestre la cantidad de votos obtenidos por cada candidato en las votaciones registradas. 
select postulacion_candidato.idPostCandidato AS "Id Candidato", usuario.nombreUsuario AS "Nombre Candidato", usuario.apellidoUsuario AS "Apellido Candidato", cargo.nomCargo AS "Cargo", COUNT(votacion.idVotacion) AS "Cantidad de Votos"
from postulacion_candidato
inner join usuario on postulacion_candidato.idUsuarioFK = usuario.idUsuario
inner join cargo on postulacion_candidato.idCargoFK = cargo.idCargo
left join votacion on postulacion_candidato.idPostCandidato = votacion.idPostCandidatoFK
group by postulacion_candidato.idPostCandidato,  usuario.nombreUsuario,  usuario.apellidoUsuario, cargo.nomCargo;



#PROCEDIMIENTOS ALMACENADOS
-- 1.
#6. Implemente tres procedimientos almacenados, tres vistas y dos subconsultas
DELIMITER //
create procedure ObtenerVotosPorCandidato(IN idEleccionParam INT, IN idCandidatoParam INT)
begin
    select 
        postulacion_candidato.idPostCandidato AS "Id Candidato",
        usuario.nombreUsuario AS "Nombre Candidato",
        usuario.apellidoUsuario AS "Apellido Candidato",
        cargo.nomCargo AS "Cargo",
        COUNT(votacion.idVotacion) AS "Cantidad Votos"
    from
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

CALL ObtenerVotosPorCandidato(1, 1);
CALL ObtenerVotosPorCandidato(1, 2);
CALL ObtenerVotosPorCandidato(1, 3);


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

call ObtenerUsuariosPorCurso(2);

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

call ObtenerCandidatosPorEleccion(1);


#VISTAS
-- 1.
create view VistaVotosPorCandidato as 
select postulacion_candidato.idPostCandidato AS "Id del Candidato",usuario.nombreUsuario AS "Nombre del Candidato",usuario.apellidoUsuario AS "Apellido del Candidato",cargo.nomCargo AS "Cargo",COUNT(votacion.idVotacion) AS "Cantidad de Votos",eleccion.fechaEleccion AS "Fecha de la Elección"
from postulacion_candidato
inner join usuario on postulacion_candidato.idUsuarioFK = usuario.idUsuario
inner join cargo on postulacion_candidato.idCargoFK = cargo.idCargo
inner join eleccion on postulacion_candidato.idEleccionFK = eleccion.idEleccion
inner join votacion on postulacion_candidato.idPostCandidato = votacion.idPostCandidatoFK
group by 
    postulacion_candidato.idPostCandidato, 
    usuario.nombreUsuario, 
    usuario.apellidoUsuario, 
    cargo.nomCargo, 
    eleccion.fechaEleccion;

select * from VistaVotosPorCandidato;


-- 2.
create view VistaUsuariosPorCursoYJornada AS
select idUsuario AS "Id del Usuario", nombreUsuario AS "Nombre del Usuario", apellidoUsuario AS "Apellido del Usuario", curso.numCurso AS "Curso", jornada.nomJornada AS "Jornada"
from usuario
inner join curso on usuario.idCursoFK = curso.idCurso
inner join jornada on usuario.idJornadaFK = jornada.idJornada;

select * from VistaUsuariosPorCursoYJornada;

# SUBCONSULTAS 
#1.
SELECT 
    idUsuario AS "Id del Usuario", 
    nombreUsuario AS "Nombre del Usuario", 
    apellidoUsuario AS "Apellido del Usuario"
FROM 
    usuario
WHERE 
    idCursoFK = (
        SELECT idCursoFK
        FROM usuario
        WHERE idUsuario = 3
    )
AND idUsuario != 3; -- Excluye al propio usuario (en este caso el de id 3)


#2. 
SELECT 
    postulacion_candidato.idPostCandidato AS "Id del Candidato",
    usuario.nombreUsuario AS "Nombre del Candidato",
    usuario.apellidoUsuario AS "Apellido del Candidato",
    cargo.nomCargo AS "Cargo",
    COUNT(votacion.idVotacion) AS "Cantidad de Votos"
FROM 
    postulacion_candidato
INNER JOIN 
    usuario ON postulacion_candidato.idUsuarioFK = usuario.idUsuario
INNER JOIN 
    cargo ON postulacion_candidato.idCargoFK = cargo.idCargo
LEFT JOIN 
    votacion ON postulacion_candidato.idPostCandidato = votacion.idPostCandidatoFK
GROUP BY 
    postulacion_candidato.idPostCandidato, 
    usuario.nombreUsuario, 
    usuario.apellidoUsuario, 
    cargo.nomCargo
HAVING 
    COUNT(votacion.idVotacion) > 3;
