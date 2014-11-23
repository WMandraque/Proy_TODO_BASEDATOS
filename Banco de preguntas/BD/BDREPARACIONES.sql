create database bdrepCuchi
go
use bdrepCuchi
go

CREATE TABLE TIPO_EQUIPO(
CODTIPO INT NOT NULL PRIMARY KEY,
DESCRIPTIPO VARCHAR(50) NOT NULL
)

insert into TIPO_EQUIPO values (1,'COMPUTADORA')
insert into TIPO_EQUIPO values (2,'ELECTRODOMESTICO')

create table EQUIPO
(codEQUI INT not null primary key,
NOMEQUI varchar(30) not null,
MODELOEQUI varchar(30) not null,
CODTIPO INT not null REFERENCES TIPO_EQUIPO,
FECHAFABEQUI DATE NOT NULL)
Go

insert into EQUIPO values (1,'PC PENTIUM IV', 'MOD777',1,'01/01/2010')
insert into EQUIPO values (2,'LAPTOP ACER', 'MOD111',1,'01/05/2010')

CREATE TABLE TIPOTRABAJADOR(
CODTIPTRAB INT NOT NULL PRIMARY KEY,
DESCRIPTIPTRAB VARCHAR(30) NOT NULL
)

insert into TIPOTRABAJADOR values (1,'VENDEDOR')
insert into TIPOTRABAJADOR values (2,'ADMINISTRATIVO')
insert into TIPOTRABAJADOR values (3,'LIMPIEZA')



create table TRABAJADOR
(codTRAB INT not null primary key,
nomTRAB varchar(20) not null,
apePatTRAB varchar(20) not null,
apeMaTTRAB varchar(20) not null,
DIRTRAB VARchar(50) not nulL,
TLFTRAB  CHAR(8) NOT NULL,
CODTIPTRAB INT not null REFERENCES TIPOTRABAJADOR,
FEC_INGTRAB DATE NOT null)

insert into TRABAJADOR values (1,'LUIS','VALLE','ALVA','SAN ISIDRO','4192900',1,'01/04/2010')
insert into TRABAJADOR values (2,'ANA','MARIN','SIERRA','LINCE','4191100',2,'01/07/2011')

create table OrdenServicio
(NUMOS INT not null primary key,
FECOS DATE not null,
CODTRAB INT not null REFERENCES TRABAJADOR,
MONTOTOTAL MONEY not null)
go 

insert into ORDENSERVICIO values (1,'01/04/2010',1,200)
insert into ORDENSERVICIO values (2,'01/07/2011',1,100)
GO

CREATE table DetalleOrdenS
(NUMOS INT not null references ORDENSERVICIO,
codEQUI INT not null references EQUIPO,
cantidad int not null,
precio money not null,
SUBTOTAL MONEY NOT NULL
PRIMARY KEY(NUMOS,CODEQUI))
go
insert into DETALLEORDENS values (1,1,1,20,20)
insert into DETALLEORDENS values (1,2,1,40,40)
GO
SELECT * FROM TIPOTRABAJADOR 
SELECT * FROM TRABAJADOR 
SELECT * FROM OrdenServicio 
SELECT * FROM EQUIPO 
SELECT * FROM DetalleOrdenS 

SELECT 'maximo' ,MAX(montototal) FROM OrdenServicio 
union all
SELECT 'minio',min(montototal) FROM OrdenServicio 
SELECT avg(montototal) FROM OrdenServicio 
