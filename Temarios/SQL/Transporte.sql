create database transporte;

USE transporte;

create table camionero(
	idCamionero INT AUTO_INCREMENT PRIMARY KEY,
	nombreCamionero VARCHAR(20) NOT NULL,
	emailCamionero  VARCHAR(20) NOT NULL,
	telefonoCamionero VARCHAR(20) NOT NULL
);

create table camion(
    idPlacaCamion INT AUTO_INCREMENT PRIMARY KEY,
    modeloCamion VARCHAR(30) NOT NULL,
    potenciaCamion VARCHAR(20) NOT NULL,
    tipoCamion VARCHAR(20) NOT NULL
);

CREATE TABLE ciudad (
	codCiudad INT auto_increment PRIMARY KEY,
    nomCiudad VARCHAR(20) NOT NULL
);

CREATE TABLE paquete (
	idPaquete INT auto_increment PRIMARY KEY,
    descPaquete VARCHAR(200) not null,
    destPaquete VARCHAR(50) not null,
    dirPaquete VARCHAR(30) not null
);

CREATE TABLE conduceVehiculo (
    idConduce INT AUTO_INCREMENT PRIMARY KEY,
    idCamioneroFK INT NOT NULL,
    idPlacaCamionFK INT NOT NULL,
);


