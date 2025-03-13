create database aseguradora;

USE aseguradora;

create table compañia(
	idCompañia INT auto_increment PRIMARY KEY,
    nitCompañia VARCHAR(20) not null,
    nomCompañia VARCHAR(30) not null,
    fechFunCompañia date,
    repLegalCompañia VARCHAR(20) not null
);

create table automovil(
	idAutomovil INT auto_increment PRIMARY KEY,
    marcaAutomovil VARCHAR(20) not null,
    modAutomovil VARCHAR(15) not null,
    placaAutomovil VARCHAR(10) not null,
    tipoAutomovil VARCHAR(20) not null,
    añoFabAutomovil date,
    serialChAutomovil INT not null,
    pasajAutomovil INT
);

create table accidente(
	idAccidente INT auto_increment PRIMARY KEY,
    auMotAccidente VARCHAR(50) not null,
    fatalAccidente VARCHAR(50) not null,
    herAccidente INT,
    lugarAccidente VARCHAR(20) not null,
    fechaAccidente date
);

create table asegura(
	idASegura INT auto_increment PRIMARY KEY,
    idCompañia INT not null,
    idAutomovil INT not null,
	serialChAutomovil INT not null,
    fechaIniAsegura date,
    fechaExpAsegura date,
    estadoASegura VARCHAR(15) not null,
    valorSeguro int not null,
    costoSeguro int not null
);


create table involucra(
	idInjvolucra INT auto_increment PRIMARY KEY,
    idAutomovil INT NOT NULL,
    idAccidente INT NOT NULL,
    serialChAutomovil INT NOT NULL
);


