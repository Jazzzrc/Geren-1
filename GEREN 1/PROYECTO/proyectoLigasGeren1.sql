Create database proyectGeren1

use proyectGeren1

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

select * from Jugador

--Creación de la tabla EQUIPO
create table Equipo (
    Id_Equipo      int identity(1,1) not null PRIMARY KEY,
    Nom_Equipo     varchar(20) not null,
    Id_Liga        int FOREIGN KEY REFERENCES Liga(Id_Liga),
    Temporada      int not null,
    Id_Entrenador  int FOREIGN KEY REFERENCES Entrenador(Id_Entrenador),
    Posicion_Liga  int not null,
    P_Ganados      int not null,
    P_Empatados    int not null,
    P_Perdidos     int not null,
    Puntos         int not null,
    Gol_Anotados   int not null,
    Gol_Recibidos  int not null,
    Max_Goleador   int FOREIGN KEY REFERENCES Jugador(Id_jugador),
    Max_Asistidor  int FOREIGN KEY REFERENCES Jugador(Id_jugador),
    Id_Estadio     int FOREIGN KEY REFERENCES Estadio(Id_Estadio),
    Anio_Fundación int not null
);

--Creación de la tabla LIGA

create table Liga (
    Id_Liga            int identity(1,1) not null PRIMARY KEY,
    Nom_Liga           varchar(10) not null,
    División           int not null,
    Temporada          int not null,
    F_Inicio           date not null,
    F_Final            date not null,
);
--se altero la tabla por conflictos de creación

alter table Liga
add Ganador_Apertura int FOREIGN KEY REFERENCES Equipo(Id_Equipo),
    Ganador_Clausura int FOREIGN KEY REFERENCES Equipo(Id_Equipo),
    Campeon int FOREIGN KEY REFERENCES Equipo(Id_Equipo);

select * from Liga

--Creación de la tabla PARTIDO

create table Partidos (
    Id_Partido     int identity (1,1) not null PRIMARY KEY,
    N_Fecha        int not null,
    Local          int FOREIGN KEY REFERENCES Equipo(Id_Equipo),
    Visitante      int FOREIGN KEY REFERENCES Equipo(Id_Equipo),
    Temporada      int not null,
    Marcador       varchar(10) not null,
    Dia_Hora       datetime not null,
    MVP            int FOREIGN KEY REFERENCES Jugador(Id_jugador),
    Id_Arbitro     int FOREIGN KEY REFERENCES Arbitro(Id_Arbitro),
    Rating_Partido float not null,
    Id_Liga        int FOREIGN KEY REFERENCES Liga(Id_Liga),
    Id_Estadio     int FOREIGN KEY REFERENCES Estadio(Id_Estadio),
    Goles          int not null,
    Asistencia     int not null,
    Amarillas      int not null,
    Rojas          int not null
);
select * from Partidos

--Creación de la tabla ESTADIO

create table Estadio (
    Id_Estadio    int identity(1,1) not null PRIMARY KEY,
    Nom_estadio   varchar(20) not null,
    Ubicación     varchar(20) not null,
    Capacidad     int not null,
    Propietario   varchar(20) not null,
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

--Creación de la tabla ESTADISTICAS

create table Estadisticas (
    Id_jugador     int NOT NULL,
    Id_Partido     int NOT NULL,
    Temporada      int not null,
    Goles          int not null,
    Asistencias    int not null,
    Amarillas      int not null,
    Rojas          int not null,
    Rating_jugador float not null,
    Minutos        int not null,
    PRIMARY KEY (Id_jugador, Id_Partido),
    FOREIGN KEY (Id_jugador) REFERENCES Jugador(Id_jugador),
    FOREIGN KEY (Id_Partido) REFERENCES Partidos(Id_Partido)
);
select * from Estadisticas

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
select * from Entrenador