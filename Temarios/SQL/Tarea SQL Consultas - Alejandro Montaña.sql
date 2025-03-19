create database techCorp;

USE techCorp;

create table empleado(
	idEmpleado INT auto_increment primary key,
    docEmpleado VARCHAR(30) not null,
    nomEmpleado VARCHAR(40) not null,
    edadEmpleado VARCHAR(20) not null,
    deparEmpleado  VARCHAR(30) not null,
	añoContrato date not null,
    salarioEmpleado decimal(8, 2) not null
);

select * from empleado;
INSERT INTO empleado(idEmpleado,docEmpleado,nomEmpleado,edadEmpleado,deparEmpleado,añoContrato,salarioEmpleado) VALUES ("","103456437","Fernando Hernandez","20 Años","Ventas", "2024-05-12" ,"2850,50"),
("","104563454","Andres Saenz","25 Años","Information Technologhy", "2022-08-19" ,"4000,50"), ("","486904367","Laura Fernandez","40 Años","Information Technologhy", "2017-05-12" ,"12500,50"), 
("","106789546","Sofia Benitez","20 Años","Ventas", "2025-01-15" ,"2200,50"), ("","115645890","Sebastian Diaz","24 Años","Information Technologhy", "2022-05-12" ,"7500,50"),
("", "305678934", "Luis Ramirez", "30 Años", "Information Technologhy", "2020-02-28", "3200.00"), ("", "901234567", "Raul Fernandez", "40 Años", "Information Technologhy", "2015-07-20", "10500.80"),
("", "678905432", "Elena Suarez", "35 Años", "Ventas", "2018-04-30", "6100.45"), ("", "789654321", "Jose Martinez", "27 Años", "Information Technologhy", "2021-09-14", "5800.60"),
("", "890123456", "Sofia Lopez", "23 Años", "Ventas", "2023-02-01", "4700.90"), ("", "102345678", "Gabriela Castro", "29 Años", "Ventas", "2020-12-11", "5300.50"), 
("", "234567890", "Daniel Ortega", "33 Años", "Information Technologhy", "2016-07-15", "9800.75"),("", "345678901", "Marta Escobar", "28 Años", "Ventas", "2019-11-22", "5400.25"),
("", "456789012", "Hugo Rivas", "42 Años", "Information Technologhy", "2010-05-10", "11000.60"),("", "567890123", "Patricia Nuñez", "36 Años", "Ventas", "2015-03-14", "7200.90"),
("", "678901234", "Javier Méndez", "45 Años", "Information Technologhy", "2008-09-30", "12500.40"), ("", "789012345", "Carolina Paredes", "31 Años", "Ventas", "2021-06-25", "5000.10"),
("", "890123456", "Rodrigo Cáceres", "39 Años", "Information Technologhy", "2013-12-05", "8900.80"),("", "901234567", "Liliana Guzmán", "27 Años", "Ventas", "2020-08-19", "6100.55"),
("", "112233445", "César Valenzuela", "37 Años", "Information Technologhy", "2014-04-22", "7800.90"),("", "223344556", "Beatriz Ocampo", "29 Años", "Ventas", "2018-01-18", "6900.75"),
("", "334455667", "Raúl Espinosa", "41 Años", "Information Technologhy", "2011-10-11", "9700.50"),("", "445566778", "Silvia Herrera", "26 Años", "Ventas", "2022-09-09", "5300.30"),
("", "556677889", "Fernando Castaño", "38 Años", "Information Technologhy", "2015-02-15", "8500.20"),("", "667788990", "Diana Montoya", "30 Años", "Ventas", "2017-07-29", "7100.85"),
("", "778899001", "Ricardo Palacios", "44 Años", "Information Technologhy", "2009-05-08", "10800.00"),("", "889900112", "Lorena Fuentes", "35 Años", "Ventas", "2016-11-04", "7500.60"),
("", "990011223", "Gustavo Solano", "32 Años", "Information Technologhy", "2023-03-12", "5600.75"),("", "001122334", "Paola Restrepo", "25 Años", "Ventas", "2021-12-17", "4900.50"),
("", "112233446", "Eduardo Miranda", "40 Años", "Information Technologhy", "2012-06-21", "10200.95"), ("", "223344557", "Alejandra Pino", "28 Años", "Ventas", "2019-08-30", "5800.45");

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
select idEmpleado, nomEmpleado, docEmpleado, MAX(salarioEmpleado) from empleado;