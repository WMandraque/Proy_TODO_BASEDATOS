

use Negocios2014
go


if OBJECT_ID ('tb_tipo')is not null
begin
drop table tb_tipo
end
go
create table tb_tipo
(
Idtipo char(1) Primary Key,
destipo varchar(100)
)
GO


if OBJECT_ID ('tb_herramienta')is not null
begin
drop table tb_herramienta
end
go
create table tb_herramienta
(
idHer char(5) primary key,
desHer varchar(100) not null,
idtipo char(1) foreign key(idtipo) references tb_tipo,
preUni decimal,
stock int
)
go


insert into tb_tipo values ('A', 'gasfitería')
insert into tb_tipo values('B', 'carpintería')
insert into tb_tipo values('C', 'albañilería')
insert into tb_herramienta  values ('A0001', 'Lampita', 'A', 12, 50)
select*from tb_tipo
select*from tb_herramienta


-- Para obtener codigo autogenerado
if OBJECT_ID ('dbo.retornaCodigo') is not null
begin
drop function dbo.retornaCodigo
end
go
create function dbo.retornaCodigo(@tipoHerramienta char(1)) returns  varchar(100)
as
begin
                declare @codigoObtenido char(5)
				declare @codigoPartido char(4)
				declare @numeroCodigo int
				declare @codigoAuto char(5)

				select @codigoObtenido=convert(CHAR(5),max(idHer))
				from tb_herramienta  as h 
				where h.idtipo =@tipoHerramienta

				set @codigoPartido =convert(char(4),(substring(@codigoObtenido,2,5)))
				set @numeroCodigo =convert(int, @codigoPartido)
				set @numeroCodigo =@numeroCodigo +1

				if(@codigoObtenido is null)
				begin
				     set @codigoAuto =@tipoHerramienta +'0001'
					 return @codigoAuto
				end
				else
				if (@numeroCodigo<=9)
				begin
				     set @codigoAuto =@tipoHerramienta +'000'+convert(char(1),@numeroCodigo )
					 return @codigoAuto
				end
				else

				if (@numeroCodigo<=99) 
				begin
				     set @codigoAuto =@tipoHerramienta +'00'+convert(char(2),@numeroCodigo )
					 return @codigoAuto
				end
				else
				if (@numeroCodigo<=999) 
				begin
				     set @codigoAuto =@tipoHerramienta +'0'+convert(char(3),@numeroCodigo )
					 return @codigoAuto
			    end
				else
				set @codigoAuto =@tipoHerramienta +convert(char(4),@numeroCodigo) 
				return @codigoAuto

				
end
go

print dbo.retornaCodigo('B')


select*from tb_herramienta 



if OBJECT_ID ('usp_listarHerramientas')is not null
begin
drop procedure usp_listarHerramientas
end
go
create procedure usp_listarHerramientas
as
begin
select*From tb_herramienta
end
go 

usp_listarHerramientas


if OBJECT_ID ('usp_agregarHerramientas')is not null
begin
drop procedure usp_agregarHerramientas
end
go
create procedure usp_agregarHerramientas
@desHer varchar(100),
@idtipo char(1),
@preUni decimal,
@stock int
as
begin
insert into tb_herramienta  values (dbo.retornaCodigo(@idtipo), @desHer, @idtipo, @preUni, @stock)

end
go 


while(select count(*)from tb_herramienta )>100
execute usp_agregarHerramientas  'Lampita', 'B', 12, 50
select*From tb_herramienta


if OBJECT_ID ('usp_actualizarHerramientas')is not null
begin
drop procedure usp_actualizarHerramientas
end
go
create procedure usp_actualizarHerramientas
@idHer char(5),
@desHer varchar(100),
@idtipo char(1),
@preUni decimal,
@stock int
as
begin
update  tb_herramienta set  desHer =@desHer, idtipo =@idtipo , preUni =@preUni , stock =@stock 
where idHer =@idHer  
end
go 







