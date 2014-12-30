


-- Sirve para saber el siguiente codigo autoincrementado
SELECT `AUTO_INCREMENT`
FROM  INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'DatabaseName'
AND   TABLE_NAME   = 'TableName'


-- Para concatenar "Char o varchar"

set idEmpleadoGenerado=CONCAT('EMP000',numeroCapturado);
set idEmpleadoGenerado=CONCAT('EMP000',nombreCapturado);

-- Prodcedure para insertar detalle de ventas con id autogenerado
DROP PROCEDURE IF EXISTS usp_registrarDetalleVenta;
DELIMITER $$
create procedure usp_registrarDetalleVenta(p_idprod char(5), p_cant int, p_precio decimal(8,2))
begin
        declare p_numvta int;
		set p_numvta=concat((SELECT  count(*)FROM  tb_ventas));

	INSERT INTO  tb_detventas(numvta, idprod, cant, precio) VALUES (p_numvta, p_idprod, p_cant, p_precio);

end$$
DELIMITER ;


DROP PROCEDURE IF EXISTS usp_registrarDetalleVenta;
DELIMITER $$
create procedure usp_registrarDetalleVenta(p_idprod char(5), p_cant int, p_precio decimal(8,2))
begin
        declare p_numvta int;
		set p_numvta=concat((SELECT MAX(numvta) AS id FROM tb_ventas));

	INSERT INTO  tb_detventas(numvta, idprod, cant, precio) VALUES (p_numvta, p_idprod, p_cant, p_precio);

end$$
DELIMITER ;


-- como usar parametros de salidas
delimiter //  
  
CREATE PROCEDURE demoSp(IN inputParam VARCHAR(255), INOUT inOutParam INT)  
BEGIN  
    DECLARE z INT;  
    SET z = inOutParam + 1;  
    SET inOutParam = z;  
  
    SELECT inputParam;  
  
    SELECT CONCAT('zyxw', inputParam);  
END//  




-- Generar codigos autogenerados de manera primitiva
DROP FUNCTION if exists CalcularIdCliente;
DELIMITER $$
CREATE FUNCTION CalcularIdCliente()-- Retornara el codigo del empleado convertido
Returns CHAR(7)
begin
    Declare cantidadCliente  INT;
    Declare idClienteAumentado INTEGER;
    Declare idClienteConvertido Char(10);
    
    Set cantidadCliente=CONCAT((select count(*) from tb_Cliente));
if cantidadCliente=0 then
    set idClienteConvertido=CONCAT('CLI',1);
    return idClienteConvertido;
end if;
    set idClienteAumentado=cantidadCliente+1;
    set idClienteConvertido=CONCAT('CLI', idClienteAumentado);
    return idClienteConvertido;
end;|
$$
Delimiter ;



-- GenerarCodigo de forma PROFESIONAL
DROP FUNCTION if exists CalcularIdVehiculo;
DELIMITER $$
CREATE FUNCTION CalcularIdVehiculo()-- Retornara el codigo del empleado convertido
Returns CHAR(7)
begin
    
    Declare ultimoRegistro char(7);
    Declare numeroCapturado int;
    Declare idEmpleadoGenerado Char(7);
    
    -- Capturamos el ultimo registro!!
    Set ultimoRegistro=(select max(idVeh)from tb_vehiculo);

    -- si no existen registros, retornaremos por default un codigo
    if (ultimoRegistro is null) then
    set idEmpleadoGenerado='EMP0001';
    return idEmpleadoGenerado;
    end if;
    
    -- Si existe algun registro entonces

    -- Separaremos los prefijos de los numeros quedandonos solo con los numeros
    -- SUBSTR(ultimoRegistro, 4) ejemplo: EMP0001 entonces obtendremos:
    -- 0001 que sera transformado en 1 al ser entero
    set numeroCapturado=SUBSTR(ultimoRegistro, 4);
    -- Aumentaremos + 1 , el numero capturado
    set numeroCapturado=numeroCapturado+1;

    -- si el numero aumentado es menor a ....
    if(numeroCapturado<=9) then
        -- concatenaremos 
        set idEmpleadoGenerado=CONCAT('VEH000',numeroCapturado);
    return idEmpleadoGenerado;

    elseif(numeroCapturado<=99) then
        set idEmpleadoGenerado=CONCAT('VEH00',numeroCapturado);
    return idEmpleadoGenerado;

    elseif(numeroCapturado<=999) then
        set idEmpleadoGenerado=CONCAT('VEH0',numeroCapturado);
    return idEmpleadoGenerado;

    else
        set idEmpleadoGenerado=CONCAT('VEH',numeroCapturado);
        return idEmpleadoGenerado;
    end if;
end;
$$
Delimiter ;






-- Para ejecutar un while es necesaro hacerlo dentro de un procedure 
-- Ejemplo aqui usaremos un procedure
DROP PROCEDURE IF EXISTS myFunction;
DELIMITER $$
CREATE PROCEDURE myFunction()
BEGIN
          DECLARE i Int;
          set i=1;
          WHILE i <= 100 DO
           set i=i+1;
                call usp_registrarEmpleado 
                ( 
                '1', 
                '1', 
                '47084553', 
                'Carlos', 
                'Bonilla', 
                'Heliz', 
                'H', 
                '1980/07/08', 
                'Imperial 325', 
                '1231', 
                '6788767', 
                '99887865679', 
                'bonilla@bonansa.com', 
                null,
                'ADMI'
                );
        END WHILE;
end ;
$$
DELIMITER ;

-- Aqui llamamos al procedure que ejecutara 100 registros automaticos
call myFunction();