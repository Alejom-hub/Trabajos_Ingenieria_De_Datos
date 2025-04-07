
-- Juan Pablo Gomez
-- Alejandro Montaña
create database BDDataVerse;

use BDDataVerse;


create table sensores(
	idSensor int auto_increment primary key,
    tipoSensor VARCHAR (30) not null,
    ubicacionSensor VARCHAR (40) not null,
    fecha_instalacion date not null
    
);


create table registros_sensores(
	idRegistro int auto_increment primary key,
    idSensorFK int,
    idRegistroEnergetico int,
    valor float not null,
    fechaRegistro date not null,
	FOREIGN KEY (idRegistroEnergetico) REFERENCES consumo_energetico(idRegistro) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idSensorFK) REFERENCES sensores(idSensor) ON DELETE CASCADE ON UPDATE CASCADE
);

create table transporte(
	idTransporte int auto_increment primary key,
    tipoTransporte VARCHAR (20) not null,
    capacidadTransporte INT not null
);

create table usuarios(
	idUsuario INT auto_increment primary key,
    nombreUsuario VARCHAR (20) not null,
    emailUsuario VARCHAR (40) not null,
    idTransporteFK INT,
    idEventoFK INT,
    idSensorFK INT,
    FOREIGN KEY (idTransporteFK) REFERENCES transporte(idTransporte) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idEventoFK) REFERENCES seguridad(idEvento) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idSensorFK) REFERENCES sensores(idSensor) ON DELETE CASCADE ON UPDATE CASCADE
);


create table consumo_energetico(
	idRegistro int auto_increment primary key,
    zona VARCHAR (20) not null,
    consumoKW VARCHAR (10) not null,
    fecha date not null
);

create table seguridad(
	idEvento INT auto_increment primary key,
    tipoEvento VARCHAR (20) not null,
    descripcionEvento VARCHAR (200) not null,
    fecha_hora date not null,
    ubicacion VARCHAR (40) not null,
    idRegistroFK INT,
    FOREIGN KEY (idRegistroFK) REFERENCES registros_sensores(idRegistro) ON DELETE CASCADE ON UPDATE CASCADE
);


-- #Modificar la tabla Usuario y crear un campo Telefono

alter table usuarios add column telefono varchar(40) not null ;
select * from usuarios;



-- # 1. Insercion de Datos

insert into sensores values ("","Sensor de Proximidad", "Calle 1 #92 - 67", "2024-05-12"),("","Sensor de Velocidad", "Calle 4 #72 - 90", "2024-07-01"), ("","Sensor de Gas", "Calle 3 #12 - 76", "2023-06-12"),
("","Sensor de Temperatura", "Calle 67 #87 - 12", "2025-01-01"),("","Sensor de Humedad", "Calle 43 #75 - 16", "2022-03-11");
select * from sensores;

insert into registros_sensores values ("",1,1,20,"2024-05-11"),("",2,2,60,"2024-06-28"),("",3,3,40,"2023-06-10"),("",4,4,70,"2024-12-31"),("",5,5,10,"2022-03-06");

insert into transporte values ("","Camion","8"),("","Carro","5"),("","Moto","2"),("","Bus","10"),("","Van","7");

insert into usuarios values ("","Alejandro", "alejandro@gmail.com",1,1,1),("","Mariana", "Mariana@gmail.com",2,2,2),("","Laura", "Laura@gmail.com",3,3,3),
("","Juan", "Juan@gmail.com",4,4,4),("","Sebastian", "Sebastian@gmail.com",5,5,5);
describe seguridad;

insert into consumo_energetico values ("","Centro","550kW","2024-01-01"),("","Sur","1440kW","2023-11-01"),("","Norte","150kW","2025-01-01"),("","Noroccidente","50kW","2025-01-28"),("","Nororiente","350kW","2023-10-11");

insert into seguridad values ("","","","","");




#2. Actualiza los registros de Consumo_Energetico para incrementar en un 10% el consumo en una zona específica



#3. Eliminar regustros de Seguridad que sean mas antiguos a un año
delete from seguridad
where timestampdiff(year, fecha_hora, CURDATE()) > 1;


#4. Encuentra todos los registros de sensores donde el valor sea mayor a 50 y el tipo de sensor sea 'temperatura'. Excluye valores NULL en valor
select * from sensores where 


/*Punto DDL 
Creación Vistas*/
create view vistaAlertas as
select tipoEvento, descripcion from seguridad where (timestampdiff(day, fecha_Hora, curdate())<0);

create view obtenerConsumoZona as
select avg(consumo) from consumoEnergetico;