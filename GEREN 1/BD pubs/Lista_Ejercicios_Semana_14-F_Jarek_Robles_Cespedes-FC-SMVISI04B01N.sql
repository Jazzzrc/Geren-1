
--- Lista de Ejercicios Semana 14 – Gerenciamiento de Datos I ---
--- Grupo: FC-SMVISI04B01N	---
--- Alumno:	Robles Cespedes, Favio Jarek---
--- Fecha:	17/11/23---

USE pubs
Go;

-- Pregunta 1:
-- Ejercicio a:

create table Clientes (
    Id_Cliente		INT IDENTITY(1,1)  NOT NULL,
    Nombre			VARCHAR(50)        NOT NULL,
    Apellido		VARCHAR(50)        NOT NULL,
    Fec_Nacimiento	DATE			   NOT NULL,
    Genero			CHAR(1),
    Telefono		VARCHAR(20),
    DNI				CHAR(8),
    Email			VARCHAR(50),
    Foto			IMAGE ,
    Activo			BIT                NOT NULL
);
select * from Clientes

--Pregunta 1:
--Ejercicio b:
alter table Clientes add primary key (Id_Cliente);

--Pregunta 1:
--Ejercicio c:
select * from sales

alter table sales 
add constraint FK_sales_clientes foreign key (Id_Cliente) references clientes(Id_Cliente);

--Pregunta 1:
--Ejercicio d:
alter table clientes 
add constraint chek_Fec_Nacimiento check (Fec_Nacimiento <= GETDATE());

--Pregunta 1:
--Ejercicio e:
alter table Clientes
add constraint DF_Telefono default '999-999-999' for Telefono;

--Pregunta 1:
--Ejercicio f:
alter table Clientes
add constraint DF_Genero default 'M' for Genero;
GO;


--Pregunta 2:
--Ejercicio a:

Insert into Clientes(Nombre, Apellido, Fec_Nacimiento, Genero, Telefono, DNI, Email,Activo)
values ( 'Pedro',
		 'Torres',
		 '1975-05-12',
		 'M',
		 '9983-123-654',
		 '10101099',
		 'pedro@ejmplo.com',
		 1);

select * from Clientes

--Pregunta 2:
--Ejercicio b:
Insert into Clientes (Nombre, Apellido, Fec_Nacimiento, Genero, Telefono, DNI, Email, Activo)
values ( 'Marco', 'La Torre', '1990-11-21', 'M', NULL, '45789547', NULL, 1),
       ( 'Angela', 'Garcia', '1981-09-04', 'F', '999-333-111', '41237895', NULL, 1),
       ( 'Carlos', 'Perez', '2008-12-01', NULL, '983-345-146', '77459870', 'cperez@ejemplo.com', 1),
       ('Luisa', 'Silva', '2000-09-29', 'F', NULL, NULL, 'lsilva@ejemplo.com', 1),
       ('James', 'Campos', '2015-04-01', NULL, NULL, NULL, NULL, 1);

--Pregunta 2:
--Ejercicio c:

update Clientes set Activo = 0
where DNI IS NULL;

--Pregunta 2:
--Ejercicio d:

update Clientes set Foto = 'no_foto.gif'

--Pregunta 2:
--Ejercicio e:
delete from Clientes
where Email IS NULL;

--Pregunta 2:
--Ejercicio f:
delete from Clientes
where Activo = 0;

select * from sales

--Pregunta 3:
--Ejercicio a:

select stor_id, SUM(qty) as LibrosVendidos
from sales
group by stor_id;

select * from titles
select * from titleauthor
select * from authors


--Pregunta 3:
--Ejercicio b:

select T.title_id, T.title, COUNT(*) as NombreAutores
from titles T
JOIN titleauthor Ta on T.title_id = Ta.title_id
group by T.title_id, T.title;


--Pregunta 3:
--Ejercicio c:


select A.au_fname + ' ' + A.au_lname as NombreAutor, t.title from authors A
JOIN titleauthor Ta on A.au_id = Ta.au_id
JOIN titles T on Ta.title_id = T.title_id;


--Pregunta 3:
--Ejercicio d:
select * from sales
select * from stores

select Sto.stor_name, Sto.city, SUM(t.price * sa.qty) as VentasTotales from stores Sto
JOIN sales Sa on Sto.stor_id = Sa.stor_id
JOIN titles T on Sa.title_id = T.title_id
group by Sto.stor_name, Sto.city;


--Pregunta 3:
--Ejercicio e:


select Sa.stor_id, Sa.title_id, Sa.qty, Sa.ord_date from sales Sa
JOIN (select stor_id, MAX(ord_date) as OrdenReciente from sales
		group by stor_id) FecOr on Sa.stor_id = FecOr.stor_id AND Sa.ord_date =  FecOr.OrdenReciente;

		
--Pregunta 3:
--Ejercicio f:

select * from sales

select stor_id, SUM(qty) as VentasXTienda,
case 
    when SUM(qty) < 50 then 'venta pequeña'
    when SUM(qty) between 50 and 100 then 'venta mediana'
    else 'venta grande'
end as sales_category from sales
group by stor_id;


--Pregunta 3:
--Ejercicio g:

select * from jobs
select * from employee

CREATE VIEW V_Info_Empleado AS
select Emp.emp_id, Emp.fname + ' ' + Emp.lname as NombreEmpleado, Jo.job_desc as Trabajo, Pu.pub_id, Pu.pub_name, Pu.city, Pu.state, Pu.country
from employee Emp
JOIN jobs Jo on Emp.job_id = Jo.job_id
JOIN publishers Pu on Emp.pub_id = Pu.pub_id;

select * from V_Info_Empleado