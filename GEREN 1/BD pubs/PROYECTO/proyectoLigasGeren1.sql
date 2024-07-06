Create database proyectGeren1

use proyectGeren1
--MOSTRAMOS TABLAS--

select * from Jugador
where Id_Equipo = 3;

select * from Equipo
select * from Entrenador
select * from Liga
select * from Estadio
select * from Partidos
select * from Estadisticas
select * from Arbitro

--Creación de la tabla JUGADOR--
create table Jugador(
	
	Id_jugador     int identity (1,1) NOT NULL PRIMARY KEY,
	N_camiseta     int NULL,
	Nombre         varchar(20) NOT NULL,
	Estatura       int NOT NULL,
	Edad           int NOT NULL,
	Nacionalidad   varchar(20) NOT NULL,
	Posicion       varchar(20) NOT NULL,
	Total_partidos int NOT NULL,
	Ave_Rating     float NOT NULL,
	Goles          int NOT NULL,
	Asistencias    int NOT NULL,
	Amarillas      int NOT NULL,
	Rojas          int NOT NULL,
	Minutos        int NOT NULL,
);
alter table Jugador
add Id_Equipo int FOREIGN KEY PREFERENCES Equipo(Id_Equipo);

--Creación de la tabla EQUIPO
create table Equipo (
    Id_Equipo      int identity(1,1) not null PRIMARY KEY,
    Nom_Equipo     varchar(20) not null,
    Posicion_Liga  int not null,
    P_Ganados      int not null,
    P_Empatados    int not null,
    P_Perdidos     int not null,
    Puntos         int not null,
    Gol_Anotados   int not null,
    Gol_Recibidos  int not null,   
    Anio_Fundación int not null
);

alter table Equipo
add Id_Liga        int FOREIGN KEY REFERENCES Liga(Id_Liga),
	Id_Entrenador  int FOREIGN KEY REFERENCES Entrenador(Id_Entrenador),
	Max_Goleador   int FOREIGN KEY REFERENCES Jugador(Id_jugador),
    Max_Asistidor  int FOREIGN KEY REFERENCES Jugador(Id_jugador),
    Id_Estadio     int FOREIGN KEY REFERENCES Estadio(Id_Estadio);

--Creación de la tabla LIGA
create table Liga (
    Id_Liga            int identity(1,1) not null PRIMARY KEY,
    Nom_Liga           varchar(10) not null,
    División           int not null,
    Temporada          int not null,
    F_Inicio           date not null,
    F_Final            date not null,
);


alter table Liga
add Ganador_Apertura int FOREIGN KEY REFERENCES Equipo(Id_Equipo),
    Ganador_Clausura int FOREIGN KEY REFERENCES Equipo(Id_Equipo),
    Campeon int FOREIGN KEY REFERENCES Equipo(Id_Equipo);

--Creación de la tabla PARTIDO
create table Partidos (
    Id_Partido     int identity (1,1) not null PRIMARY KEY,
    N_Fecha        int not null,  
    Gol_Local      int,
	Gol_Visita     int,
    Dia_Hora       datetime not null,
    Rating_Partido float not null,
    Goles          int not null,
    Asistencia     int not null,
    Amarillas      int not null,
    Rojas          int not null
);

alter table Partidos
add Local          int FOREIGN KEY REFERENCES Equipo(Id_Equipo),
    Visitante      int FOREIGN KEY REFERENCES Equipo(Id_Equipo),
	MVP            int FOREIGN KEY REFERENCES Jugador(Id_jugador),
    Id_Arbitro     int FOREIGN KEY REFERENCES Arbitro(Id_Arbitro),
	Id_Liga        int FOREIGN KEY REFERENCES Liga(Id_Liga),
    Id_Estadio     int FOREIGN KEY REFERENCES Estadio(Id_Estadio),

--Creación de la tabla ESTADIO
create table Estadio (
    Id_Estadio    int identity(1,1) not null PRIMARY KEY,
    Nom_estadio   varchar(50) not null,
    Ubicación     varchar(20) not null,
    Capacidad     int not null,
    Propietario   varchar(50) not null,
    Fec_Apertura  date not null,
    Dimensiones   varchar(20) not null
);

--Creación de la tabla ARBITRO
create table Arbitro (
    Id_Arbitro     int identity (1,1) not null PRIMARY KEY,
    Nom_Arbitro    varchar(20) not null,
    Edad           int not null,
    Amarillas      int not null,
    Rojas          int not null,
    Total_partidos int not null
);

select * from Jugador
--Creación de la tabla ESTADISTICAS
create table Estadisticas (
    Id_jugador     int NOT NULL,
    Id_Partido     int NOT NULL,
    Goles          int not null,
    Asistencias    int not null,
    Amarillas      int not null,
    Rojas          int not null,
    Rating_jugador float not null,
    Minutos        int not null,
    PRIMARY KEY (Id_jugador, Id_Partido),   
);

alter table Estadisticas
add FOREIGN KEY (Id_jugador) REFERENCES Jugador(Id_jugador),
    FOREIGN KEY (Id_Partido) REFERENCES Partidos(Id_Partido);


--Creación de la tabla ENTRENADOR
create table Entrenador (
    Id_entrenador  int identity(1,1) not null PRIMARY KEY,
    Nom_Entrenador varchar(20) not null,
    Edad           int not null,
    P_Ganados      int not null,
    P_Empatados    int not null,
    P_Perdidos     int not null,
    Total_Partidos int not null
);

-- Creación de constraints --

--Solo puede hacer un equipo con un nombre--
alter table Equipo
add constraint UC_Equipo unique (Nom_Equipo);

--Todos los equipos empiezan con 0 en los siguientes atributos--
alter table Equipo
add constraint DF_Equipo_P_Ganados default 0 for P_Ganados,
	constraint DF_Equipo_P_Empatados default 0 for P_Empatados,
	constraint DF_Equipo_P_Perdidos default 0 for P_Perdidos,
	constraint DF_Equipo_Gol_Anotados default 0 for Gol_Anotados,
	constraint DF_Equipo_Gol_Recibidos default 0 for Gol_Recibidos,
	constraint DF_Equipo_Puntos default 0 for Puntos;

--Checkamos que la edad del jugador sea minimo 15 años --
alter table Jugador
add constraint CHK_Jugador_Edad check (Edad > 15);

insert into Jugador(N_camiseta, Nombre, Estatura, Edad, Nacionalidad, Posicion, Id_Equipo)
values (12, 'Paolo Guerrero', 188, 20, 'Peru', 'Delantero',3);

--Todos los jugadores empiezan con 0 en lso siguientes atributos--
alter table Jugador
add constraint DF_Jugador_Total_Partidos default 0 FOR Total_Partidos,
    constraint DF_Jugador_Ave_Rating DEFAULT 0 FOR Ave_Rating,
    constraint DF_Jugador_Goles DEFAULT 0 FOR Goles,
    constraint DF_Jugador_Asistencias DEFAULT 0 FOR Asistencias,
    constraint DF_Jugador_Rojas DEFAULT 0 FOR Rojas,
    constraint DF_Jugador_Minutos DEFAULT 0 FOR Minutos;
go;

alter table Jugador
add 	constraint DF_Jugador_Amarillas default 0 for Amarillas;

--Los jugadores que no se le ingrese una nacionalidad se pondra por default en UNKNOW--
alter table Jugador
add constraint DF_Jugador_Nacion DEFAULT 'Unknow' FOR Nacionalidad;

alter table Jugador
add constraint DF_Jugador_Equipo Default 0 for Id_Equipo;
--Todos los entrenadores empiezan con 0 en lso siguientes atributos--
alter table Entrenador
add constraint DF_Entrenador_P_Ganados default 0 for P_Ganados,
	constraint DF_Entrenador_P_Empatados default 0 for P_Empatados,
	constraint DF_Entrenador_P_Perdidod default 0 for P_Perdidos,
	constraint DF_Entrenado_T_Partidos default 0 for Total_Partidos;

--Todos los arbitros empiezan con 0 en lso siguientes atributos--
alter table Arbitro
add constraint DF_Arbitro_Amarillas default 0 for Amarillas,
	constraint DF_Arbitro_Rojas default 0 for Rojas,
	constraint DF_Arbitro_Total_Partidos default 0 for Total_partidos; 

alter table Partidos
add constraint DF_Partidos_Goles default 0 for Goles,
	constraint Df_Partidos_Asistencias default 0 for Asistencia,
	constraint DF_Partidos_Amarillas default 0 for Amarillas,
	constraint Df_Partidos_Rojas default 0 for Rojas;
go;

alter table Partidos
add constraint DF_Partidos_Gol_Local default 0 for Gol_Local,
	constraint DF_Partidos_Gol_Visita default 0 for Gol_Visita;

--Insertamos datos en la tabla ESTADIO--
insert into Estadio (Nom_estadio, Ubicación, Capacidad, Propietario, Fec_Apertura, Dimensiones)
values ('Estadio Héroes de San Ramon', 'Cajamarca, Perú', 18000, 'IPD', '1942-01-01', '105 x 70 m'),
	   ('Estadio Campeones del 36', 'Sullana, Piura', 12000, 'Mun. Prov. de Sullana', '2000-01-01', '105 x 68 m');
go;

insert into Estadio(Nom_estadio,Ubicación,Capacidad,Propietario,Fec_Apertura,Dimensiones)
values ('Estadio Alberto Gallardo', 'Lima, Perú', 11500, 'IPD', '1961-06-09', '107 x 74 m'),
	   ('Estadio Monumental', 'Lima, Perú', 80093, 'Universitario de Deportes', '2000-07-02', '105 x 70 m'),
	   ('Estadio Alejandro Villanueva', 'Lima, Perú', 33938, 'Club Alianza Lima', '1974-12-27', '105 x 68 m'),
	   ('Estadio Monumental de la UNSA', 'Arequipa, Perú', 40370, 'Universidad Nacional de San Agustin', '1995-07-30', '105 x 70 m'),
	   ('Estadio Guillermo Briceño Rosamedina', 'Juliaca, Perú', 20000, 'IPD', '1966-10-24', '125 x 75m'),
	   ('Estadio Inca Garcilaso de la Vega', 'Cuzco, Perú', 42000, 'IPD', '1958-01-01', '105 x 68 m'),
	   ('Estadio Iván Elías Moreno', 'Lima, Perú', 13773, 'Mun. Dist. VES', '2002-06-02', '105 x 70 m'),
	   ('Estadio Miguel Grau', 'Callao, Perú', 17000, 'Gob. Reg. Callao', '1996-06-16', '105 x 70 m'),
	   ('Estadio Carlos Vidaurre García', 'Tarapoto, Perú', 18000, 'Mun. Prov. de San Martín', '2023-01-01', '105 x 68 m'),
	   ('Estadio Huancayo', 'Huancayo, Perú', 20000, 'IPD', '1962-01-01', '105 x 70 m'),
	   ('Estadio Municipal de Bernal', 'Sechura, Perú', 7000,'Mun. Dist. Bernal', '1000-01-01', '105 x 70 m'),
	   ('Estadio Unión Tarma', 'Tarma, Perú', 6000, 'Mun. Prov. Tarma', '2022-01-01', '105 x 70 m'),
	   ('Estadio Mansiche', 'Trujillo, Perú', 25036, 'IPD', '1946-10-12', '111 x 73 m');
go;


--Insertamos datos en la tabla ARBITRO--

select * from Arbitro
insert into Arbitro (Nom_Arbitro, Edad) 
values ('Juan Pérez', 45),
	   ('Mario García', 40),
       ('Carlos Rodríguez', 50),
       ('Amadeo Martínez', 38),
       ('Luis Fernández', 42),
       ('Santiago González', 39),
       ('Miguel López', 46),
       ('Patricio Torres', 41),
       ('Ricardo Ramírez', 43),
       ('Edwin Ordoñez', 44),
       ('Javier Morales', 47),
       ('Israel Guzmán', 48),
       ('Francisco Aguilar', 49),
       ('Alexis Peña', 51),
       ('Ernesto Vargas', 52),
       ('Roger Castillo', 53),
       ('Hugo Ortega', 54),
       ('Kevin Ortega', 55),
       ('Oscar Herrera', 56),
       ('Diego Haro', 57);
go;


--Insertamos datos en la tabla EQUIPO--
select * from Equipo
insert into Equipo(Nom_Equipo, Id_Liga, Temporada, Id_Entrenador, Posicion_Liga, P_Ganados, P_Empatados, P_Perdidos, Id_Estadio, Anio_Fundación)    
values ('Sporting Cristal', 3, 2003, 1, 3, 10,6,2,17,1955);

insert into Equipo(Nom_Equipo, Id_Liga, Temporada, Id_Entrenador, Posicion_Liga, P_Ganados, P_Empatados, P_Perdidos, Id_Estadio, Anio_Fundación)    
values ('Universitario', 3, 2023, 2, 2, 13,5,1,18,1924),
	   ('Alianza Lima', 3, 2023, 4, 1, 15,3,1,19, 1901),
	   ('Cienciano', 3, 2023, 3, 4, 9,7,2,22,1901);
go;

insert into Equipo(Nom_Equipo, Id_Liga, Temporada, Id_Entrenador, Posicion_Liga, P_Ganados, P_Empatados, P_Perdidos, Id_Estadio, Anio_Fundación)
values	('Melgar', 3, 2023, 5,5, 0,0,0, 20,1915),
		('ADT', 3, 2023, 6,6, 0,0,0, 28,1929),
		('Sport Huancayo', 3, 2023, 7,7, 0,0,0, 26,2007),
		('Deportivo Garcilazo', 3, 2023, 8,8, 0,0,0, 22,1957),
		('U. Cesar Vallejo', 3, 2023, 9,9, 0,0,0, 29,1996),
		('Sport Boys', 3, 2023, 10,10, 0,0,0, 24,1927),
		('Carlos A. Manucci', 3, 2023, 11,11, 0,0,0, 29,1959),
		('UTC', 3, 2023, 12,12, 0,0,0, 4,1964),
		('Cuzco FC', 3, 2023, 13,13, 0,0,0, 22,2009),
		('Atletico Miguel Grau', 3, 2023, 14,14, 0,0,0, 24,1919),
		('Deportivo Binacional', 3, 2023, 15,15, 0,0,0, 21,2010),
		('Union Comerio', 3, 2023, 16,16, 0,0,0, 25,2002),
		('AD Cantolao', 3, 2023, 17,17, 0,0,0, 24,1981),
		('Alianza Atl. Sullana', 3, 2023, 18,18, 0,0,0, 5,2021),
		('Municipal', 3, 2023, 19,19, 0,0,0, 23,1935);


--Insertamos datos en la tabla JUGADOR--
insert into Jugador(N_camiseta, Nombre, Estatura, Edad, Nacionalidad, Posicion, Id_Equipo)
values (12, 'Renato Solis', 188, 25, 'Peru', 'Portero',1);

insert into Jugador(N_camiseta, Nombre, Estatura,Edad,Nacionalidad,Posicion, Id_Equipo)
values (13, 'Alejandro Duarte', 182, 29, 'Peru', 'Portero', 1),
	   (14, 'Ignacio Da Silva', 192, 26, 'Brasil', 'Defensa Central', 1),
	   (4, 'Gianfranco Chavez', 180, 25, 'Peru', 'Defensa Central', 1),
	   (5, 'Rafael Lutiger', 188, 22, 'Peru - Suiza', 'Defensa Central', 1),
	   (32, 'Leonardo Diaz', 184, 19, 'Peru', 'Defensa Central', 1),
	   (29, 'Nilson Loyola', 180, 29, 'Peru','Lat. Izquierdo', 1),
	   (28, 'Nicolas Pasquini', 177,32, 'Argentina', 'Lat. Izquierdo', 1),
	   (15, 'Jhilmar Lora', 176, 23, 'Peru', 'Lat. Derecho',1),
	   (25, 'Martin Tavara', 180, 24, 'Peru', 'Pivote', 1),
	   (6, 'Jesus Pretell', 170, 24, 'Peru', 'Pivote', 1),
	   (19, 'Yoshimar Yotun', 173, 33, 'Peru', 'Mediocentro', 1),
	   (30, 'Jostin Alarcon', 180, 21, 'Peru', 'Medio Ofensivo', 1),
	   (8, 'Leandro Sosa', 177, 29, 'Peru', 'Medio Ofensivo', 1),
	   (21, 'Adrian Ascues', 180, 21, 'Peru', 'Medio Ofensivo', 1),
	   (7, 'Washington Corozo', 180, 25, 'Ecuador', 'Ext. Derecho', 1),
	   (10, 'Alejandro Hohberg', 170, 32, 'Peru', 'Ext. Izquierdo', 1),
	   (20, 'Joao Grimaldo', 175, 20, 'Peru', 'Ext. Derecho', 1),
	   (9, 'Brenner', 182, 29, 'Brasil', 'Delantero Centro', 1),
	   (11, 'Irven Avilan', 170, 33, 'Peru', 'Delantero Centro', 1);
go;

insert into Jugador(N_camiseta, Nombre, Estatura, Edad, Nacionalidad, Posicion, Id_Equipo)
values (10, 'Jairo Concha', 170, 23, 'Peru', 'Medio Ofensivo', 3),
	   (23, 'Christian Cueva', 170, 34, 'Peru', 'Medio Ofensivo', 3),
	   (9, 'Hernan Barcos', 189, 39, 'Argentina', 'Delantero Centro', 3),
	   (11, 'Bryan Reyna', 172, 26, 'Peru', 'Ext. Derecho', 3);

select * from Jugador
--Insertamos datos en la tabla PARTIDO--

select * from Partidos
insert into Partidos(N_Fecha, Local, Visitante, Temporada, Dia_Hora, MVP, Id_Arbitro, Rating_Partido,Id_Liga, Id_Estadio, Gol_Local, Gol_Visita)
values (1, 1,2, 2023,'2023-11-21 19:00:00', 17,14, 8.5,3,  17,2,0);

insert into Partidos(N_Fecha, Local, Visitante, Temporada, Dia_Hora, MVP, Id_Arbitro, Rating_Partido,Id_Liga, Id_Estadio, Gol_Local, Gol_Visita)
values (1, 3, 4, 2023, '2023-11-21 19:00:00', 28,19, 7.3, 3, 19, 3, 3);

--Insertamos datos en la tabla ENTRENADOR--
select * from Entrenador
insert into Entrenador(Nom_Entrenador, Edad, P_Ganados, P_Empatados, P_Perdidos)
values ('Tiago Nunes', 43, 102, 63, 52),
       ('Jorge Fossati', 71, 206, 112, 126),
	   ('Mauricio Larriera', 53, 100, 59, 68);

insert into Entrenador(Nom_Entrenador, Edad, P_Ganados, P_Empatados, P_Perdidos)
values	   ('Mariano Soso', 42, 0, 0, 0),
	   ('Franco Navarro', 62, 0, 0, 0),
	   ('Wilmar Valencia', 62, 0, 0, 0),
	   ('Jorge Celico', 59, 0, 0, 0),
	   ('Roberto Mosquera', 67, 0, 0, 0),
	   ('Fernando Gamboa', 53, 0, 0, 0),
	   ('Mario Viera', 64, 0, 0, 0),
	   ('Carlos Ramacciotti', 68, 0, 0, 0),
	   ('Luis Flores', 62, 0, 0, 0),
	   ('Angel Comizzo', 68, 0, 0, 0),
	   ('Aristoteles Ramos', 51, 0, 0, 0),
	   ('Raymundo Paz', 56, 0, 0, 0),
	   ('Jersi Socola', 33, 0, 0, 0),
	   ('Agapo Gonzales', 60, 0, 0, 0),
	   ('Santiago Acasiete', 46, 0, 0, 0);

--Insertamos datos en la tabla ESTADISTICAS--
select * from Estadisticas
insert into Estadisticas(Id_jugador, Id_Partido, Temporada, Goles, Asistencias, Amarillas, Rojas, Rating_jugador, Minutos)
values (6,1, 2023, 0,0,1,0,7.4, 90),
	   (14,1, 2023, 0,0,0,0,7.4, 90),
	   (8,1, 2023, 0,0,0,0,7.7, 90),
	   (11,1, 2023, 0,0,0,0,7.3, 85),
	   (13,1, 2023, 0,0,0,0,6.8, 85),
	   (15,1, 2023, 0,0,0,0,7.1, 90),
	   (18,1, 2023, 0,0,0,0,7.1, 79),
	   (17,1, 2023, 0,0,1,0,7.6, 90),
	   (23,1, 2023, 1,0,0,0,8.0, 90),
	   (24,1, 2023, 0,0,0,0,6.6, 79),
	   (21,1, 2023, 0,0,0,0,6.8, 67),
	   (22,1, 2023, 1,0,0,0,7.3, 90-67),
	   (19,1, 2023, 0,0,1,0,7.1, 90-79),
	   (25,1, 2023, 1,0,0,0,6.7, 90-79),
	   (12,1, 2023, 0,0,0,0,6.7, 90-85),
	   (16,1, 2023, 0,0,0,1,6.3, 90-85);
go;

insert into Estadisticas(Id_jugador, Id_Partido, Temporada, Goles, Asistencias, Amarillas, Rojas, Rating_jugador, Minutos)
values (28,3, 2023, 2,1,1,0,8.9, 90);

--Insertamos datos en la tabla LIGA--
select * from Liga
insert into Liga(Nom_Liga, División, Temporada, F_Inicio, F_Final)
values ('Liga 1', 1 , 2023, '2023-02-03', '2023-11-08');

insert into Liga(Nom_Liga, División, Temporada, F_Inicio, F_Final)
values ('Liga 2', 2, 2023, '2023-04-06', '2023-10-26');


--Trigger para la tabla entrenador--
CREATE TRIGGER TR_Act_Total_Partidos
ON Entrenador
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Entrenador
    SET Total_Partidos = i.P_Ganados + i.P_Empatados + i.P_Perdidos
    FROM Entrenador e
    INNER JOIN inserted i ON e.Id_Entrenador = i.Id_Entrenador;
END;

--Trigger para almacenar las estadisticas--
CREATE TRIGGER ActualizarEstadisticas ON Estadisticas
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Jugador
    SET Goles = (SELECT SUM(Goles) FROM Estadisticas WHERE Id_jugador = Jugador.Id_jugador),
        Asistencias = (SELECT SUM(Asistencias) FROM Estadisticas WHERE Id_jugador = Jugador.Id_jugador),
        Amarillas = (SELECT SUM(Amarillas) FROM Estadisticas WHERE Id_jugador = Jugador.Id_jugador),
        Rojas = (SELECT SUM(Rojas) FROM Estadisticas WHERE Id_jugador = Jugador.Id_jugador),
        Ave_Rating = (SELECT AVG(Rating_jugador) FROM Estadisticas WHERE Id_jugador = Jugador.Id_jugador),
        Minutos = (SELECT SUM(Minutos) FROM Estadisticas WHERE Id_jugador = Jugador.Id_jugador)
    WHERE Id_jugador IN (SELECT Id_jugador FROM inserted);

    UPDATE Equipo
    SET Gol_Anotados = (SELECT SUM(Goles) FROM Jugador WHERE Id_Equipo = Equipo.Id_Equipo)
    WHERE Id_Equipo IN (SELECT Id_Equipo FROM Jugador WHERE Id_jugador IN (SELECT Id_jugador FROM inserted));
END;


--Trigger para Sumar Puntos--
create trigger TR_Act_Puntos
ON Equipo
AFTER insert, UPDATE
AS
BEGIN
	UPDATE Equipo
	SET Puntos = (i.P_Ganados*3) + (i.P_Empatados*1) + (i.P_Perdidos*0)
	FROM Equipo Equi
	INNER JOIN inserted i  ON  Equi.Id_Equipo = i.Id_Equipo;
END;


--Trigger para sacar goles totales de un partido--
create trigger TR_Goles_Partido
on Partidos
After insert, update
as begin
	update Partidos
	set Goles = i.Gol_Local + i.Gol_Visita
	from Partidos parti
	INNER JOIN inserted i on parti.Id_Partido = i.Id_Partido;
END;


--VISTA GENERAL DEL PARTIDO--
CREATE VIEW PartidosDetallados AS
SELECT 
    P.Id_Partido,
    CONCAT(P.Gol_Local, '-', P.Gol_Visita) AS Marcador,
    J.Nombre AS Jugador_Mayor_Rating,
    E.Nom_estadio
FROM  Partidos P
JOIN  Estadio E ON P.Id_Estadio = E.Id_Estadio
JOIN  (SELECT Id_Partido, MAX(Rating_jugador) AS Max_Rating FROM Estadisticas GROUP BY  Id_Partido) AS MaxRating ON P.Id_Partido = MaxRating.Id_Partido
JOIN Estadisticas ES ON MaxRating.Id_Partido = ES.Id_Partido AND MaxRating.Max_Rating = ES.Rating_jugador
JOIN  Jugador J ON ES.Id_jugador = J.Id_jugador;

select * from PartidosDetallados

--SE muestran los mejores jugadores--
CREATE VIEW MejoresJugadores AS
SELECT 
    TOP 100 PERCENT
    J.Nombre AS Jugador,
    E.Nom_Entrenador AS Entrenador,
    EQ.Posicion_Liga AS Posicion,
    (J.Goles + J.Asistencias) AS GA,
    J.Ave_Rating AS Rating_Promedio
FROM 
    Jugador J
JOIN 
    Equipo EQ ON J.Id_Equipo = EQ.Id_Equipo
JOIN 
    Entrenador E ON EQ.Id_Entrenador = E.Id_entrenador
WHERE 
    J.Ave_Rating > 6.5
ORDER BY 
    GA DESC;

select * from MejoresJugadores

--Se muestra lo datos de los jugadores por partido detallado--
CREATE VIEW DetallesEstadisticas AS
SELECT ES.Id_Partido, J.Nombre AS Jugador, P.N_Fecha, E1.Nom_Equipo AS Local, E2.Nom_Equipo AS Visitante, ES.Goles, ES.Asistencias
FROM Estadisticas ES
JOIN Jugador J ON ES.Id_jugador = J.Id_jugador
JOIN Partidos P ON ES.Id_Partido = P.Id_Partido
JOIN Equipo E1 ON P.Local = E1.Id_Equipo
JOIN Equipo E2 ON P.Visitante = E2.Id_Equipo;

select * from DetallesEstadisticas

--Esta vista muestra el estadio donde los jugadores hicieron gol
CREATE VIEW EstadioPartidosGoles AS
SELECT 
    S.Nom_estadio,
    P.Id_Partido,
    J.Nombre AS Jugador
FROM 
    Estadio S
JOIN 
    Partidos P ON S.Id_Estadio = P.Id_Estadio
JOIN 
    Estadisticas ES ON P.Id_Partido = ES.Id_Partido
JOIN 
    Jugador J ON ES.Id_jugador = J.Id_jugador
WHERE 
    ES.Goles > 0;

select * from EstadioPartidosGoles

--Aqui se mostrara, en que estadio un equipo marco más goles--
CREATE VIEW EstadioMasGoles AS
SELECT 
top 100 percent
    E.Nom_Equipo,
    S.Nom_estadio,
    SUM(ES.Goles) AS Total_Goles
FROM 
    Jugador J
JOIN 
    Estadisticas ES ON J.Id_jugador = ES.Id_jugador
JOIN 
    Partidos P ON ES.Id_Partido = P.Id_Partido
JOIN 
    Estadio S ON P.Id_Estadio = S.Id_Estadio
JOIN 
    Equipo E ON J.Id_Equipo = E.Id_Equipo
GROUP BY 
    E.Nom_Equipo,
    S.Nom_estadio
ORDER BY 
    Total_Goles DESC;

select * from EstadioMasGoles

--1. Obtener Posiciones y Rating Promedio de Jugadores en una Temporada:
Formato: exec SP_ObtenerPosicionesYRating *temporada*
CREATE PROCEDURE SP_ObtenerPosicionesYRating
    @Temporada INT
AS
BEGIN
    SELECT J.Posicion, AVG(E.Rating_jugador) AS AveRating
    FROM Jugador J
    INNER JOIN Estadisticas E ON J.Id_jugador = E.Id_jugador
    INNER JOIN Partidos P ON E.Id_Partido = P.Id_Partido
    WHERE P.Temporada = @Temporada
    GROUP BY J.Posicion;
END;
--2. Obtener Equipos en una Liga:
Formato: exec SP_ObtenerEquiposLiga *id_liga*
CREATE PROCEDURE SP_ObtenerEquiposLiga
    @IdLiga INT
AS
BEGIN
    SELECT E.*
    FROM Equipo E
    INNER JOIN Liga L ON E.Temporada = L.Temporada
    WHERE L.Id_Liga = @IdLiga;
END;
--3. Obtener Estadísticas de un Jugador en una Temporada:
Formato: exec SP_ObtenerEstadisticasJugadorTemporada *id_jugador*, *temporada*
CREATE PROCEDURE SP_ObtenerEstadisticasJugadorTemporada
    @IdJugador INT,
    @Temporada INT
AS
BEGIN
    SELECT E.*
    FROM Estadisticas E
    WHERE E.Id_Jugador = @IdJugador AND E.Temporada = @Temporada;
END;
--4. Obtener Equipos con Mejor Posición en una Temporada:
exec SP_ObtenerEquiposMejorPosicion *temporada*

CREATE PROCEDURE SP_ObtenerEquiposMejorPosicion
    @Temporada INT
AS
BEGIN
    SELECT E.*
    FROM Equipo E
    WHERE E.Temporada = @Temporada
    ORDER BY E.Posicion_Liga;
END;
--5. Obtener Estadísticas Generales de un Jugador:
exec SP_ObtenerEstadisticasGeneralesJugador *id_jugador*
CREATE PROCEDURE SP_ObtenerEstadisticasGeneralesJugador
    @IdJugador INT
AS
BEGIN
    SELECT J.*, E.*
    FROM Jugador J
    INNER JOIN Estadisticas E ON J.Id_Jugador = E.Id_Jugador
    WHERE J.Id_Jugador = @IdJugador;
END;
--6. Obtener Estadísticas de un Jugador en un Partido Específico:
exec SP_ObtenerEstadisticasJugadorPartido *id_jugador*,*id_partido*
CREATE PROCEDURE SP_ObtenerEstadisticasJugadorPartido
    @IdJugador INT,
    @IdPartido INT
AS
BEGIN
    SELECT E.*
    FROM Estadisticas E
    WHERE E.Id_Jugador = @IdJugador AND E.Id_Partido = @IdPartido;
END;
--7. Obtener Partidos con Mayor Asistencia en una Temporada:
exec SP_ObtenerPartidosMayorAsistencia *temporada*
CREATE PROCEDURE SP_ObtenerPartidosMayorAsistencia
    @Temporada INT
AS
BEGIN
    SELECT P.*
    FROM Partidos P
    WHERE P.Temporada = @Temporada
    ORDER BY P.Asistencia DESC;
END;
--8. Obtener Jugadores con Mejor Rating en una Temporada:
exec SP_ObtenerMejoresJugadoresTemporada *temporada*
CREATE PROCEDURE SP_ObtenerMejoresJugadoresTemporada
    @Temporada INT
AS
BEGIN
    SELECT J.*
    FROM Jugador J
    INNER JOIN Estadisticas E ON J.Id_jugador = E.Id_jugador
    INNER JOIN Partidos P ON E.Id_Partido = P.Id_Partido
    WHERE P.Temporada = @Temporada
    ORDER BY J.Ave_Rating DESC;
END;
9. Obtener Equipos con Mejor Diferencia de Goles en una Temporada:
Formato: exec SP_ObtenerEquiposMejorDiferenciaGoles *temporada*
CREATE PROCEDURE SP_ObtenerEquiposMejorDiferenciaGoles
    @Temporada INT
AS
BEGIN
    SELECT E.*
    FROM Equipo E
    WHERE E.Temporada = @Temporada
    ORDER BY (E.Gol_Anotados - E.Gol_Recibidos) DESC;
END;
10. Obtener Equipos y sus Entrenadores en una Liga:
Formato: exec SP_ObtenerEquiposEntrenadoresLiga *id_liga*
CREATE PROCEDURE SP_ObtenerEquiposEntrenadoresLiga
    @IdLiga INT
AS
BEGIN
    SELECT E.*, En.*
    FROM Equipo E
    INNER JOIN Liga L ON E.Temporada = L.Temporada
    LEFT JOIN Entrenador En ON E.Id_Entrenador = En.Id_entrenador
    WHERE L.Id_Liga = @IdLiga;
END;
--11. Obtener Jugadores con Mejor Relación Goles por Minuto:
Formato: exec SP_JugadoresGolMin
CREATE PROCEDURE SP_JugadoresGolMin
AS
BEGIN
    SELECT J.*, E.*
    FROM Jugador J
    INNER JOIN Estadisticas E ON J.Id_jugador = E.Id_jugador
    WHERE E.Goles > 0 AND E.Minutos > 0
    ORDER BY (E.Goles * 1.0 / E.Minutos) DESC;
END;
--12. Obtener Estadísticas de Jugadores con Hat-tricks:
Formato: exec SP_HatTricks
CREATE PROCEDURE SP_HatTricks
AS
BEGIN
    SELECT J.*, E.*
    FROM Jugador J
    INNER JOIN Estadisticas E ON J.Id_jugador = E.Id_jugador
    WHERE E.Goles >= 3
    ORDER BY E.Goles DESC;
END;
Funciones
Función para devolver jugadas valiosas
Create Function Jugadas_Valiosas_X(@IDjugador int)
Returns int
as
Begin
declare @JugadasValiosas int
select @JugadasValiosas= Goles from Jugador where @IDjugador=Id_jugador 
return @JugadasValiosas
end
Create Procedure usp_Jugadas_Valiosas_X
As
	Select dbo.Jugadas_Valiosas_Por_Partido(9) as Jugadas_Valiosas
Go
Exec usp_Jugadas_Valiosas_X
Go


Funcion para devolver Partidos Ganados de un entrenador utilizando su id
Create Function Partidos_Ganados_WRS12XL(@NomEntrenador int)
Returns int
as 
Begin
declare @PartidosW int
select @PartidosW= P_Ganados from Entrenador where @NomEntrenador=Id_entrenador
return @PartidosW
end
Create  Procedure usp_Partidos_Ganados_WRS12XLW
As
	Select dbo.Partidos_Ganados(1) as Partidos_Ganados_del_Entrenador
Go
Exec usp_Partidos_Ganados_WRS12XL
Go
