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
select * from empleado group by desc;

/*Empleados que gannen mas y lleven mas de 5 años trabajando*/
select nomEmpleado, salarioEmpleado, timestampdiff(year, añoContrato, curdate()) as "años trabajados" from empleado where timestampdiff(year, añoContrato, curdate())> (select max(timestampdiff(year, añoContrato, curdate())) as "mayor años" from empleado)
and salarioEmpleado >= (select max(salarioEmpleado) from empleado) order by salarioEmpleado desc limit 5;




/*  having*/

select deparEmpleado, count(*) from empleado group by deparEmpleado having count(*) >=5;




/*-------------------- MODIFICACION --------------------*/

/*sintaxis   update   nombreTAbla   set campol = "valor de remplazo"   where   llaveprimaria = "valor"*/
select * from empleado;
update empleado set nomEmpleado = "Gabriel" where idEmpleado = 1;


/*sentencia delete  "siempre debe llevar una clausula where"*/
/*sintaxis   delete   from   nombreTabla   where   condicion*/









/* MultiConsulta

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
select nomEmpleado, salarioEmpleado, timestampdiff(year, añoContrato, curdate()) as "años trabajados" from empleado where timestampdiff(year, añoContrato, curdate()>3)  
and salarioEmpleado >= (select max(salarioEmpleado) from empleado) order by salarioEmpleado) inner join departamento on  empleado.idCargoFK = cargo.idCargo;



/* 4. Mostrar toda la informacion del empleado, fecha en la que se contrato, departamento al que pertenece, años de antiguedad en la empresa, cargo que tiene actualmente y el rango del cargo que tiene. */
SELECT 
    nomEmpleado AS "Nombre Empleado", 
    añoContrato AS "Fecha  Contrato", 
    nombre AS "Departamento", 
    TIMESTAMPDIFF(YEAR, STR_TO_DATE(CONCAT(añoContrato, '-01-01'), '%Y-%m-%d'), CURDATE()) AS "Años de Antigüedad", 
    nombreCargo AS "Cargo Actual", 
    rangoCargo AS "Rango del Cargo"
FROM Empleado
INNER JOIN Cargo ON Empleado.idCargoFK = Cargo.idCargo;


/* 5. Mostrar todos los departamentos que no tengan empleados asignados.*/


/* 6. Mostrar todos los cargos que no tengan empleados asignados*/





