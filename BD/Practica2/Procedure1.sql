--Apartado 0
SET SERVEROUTPUT ON SIZE 100000;
DECLARE
 V VARCHAR(10);
BEGIN
 V:='Hola';
 DBMS_OUTPUT.PUT_LINE(V);
END; 
--apartado 1
create or replace 
PROCEDURE PEDIDOS_CLIENTE 
(v_dni char)
is
--datos cliente
  v_nombre char(15);
  V_apellido char(20);
  calle char(20);
  numero number(4,0);
  piso char(5);
  localidad char(15);
  codigo_postal char(5);
  telefono char(9);
  --pedidos
  CODIGO	NUMBER(8,0);
  ESTADO	CHAR(9);
  FECHA_HORA_PEDIDO	DATE;
  FECHA_HORA_ENTREGA	DATE;
  importe_total	NUMBER(8,2);
  CLIENTE	CHAR(9);
  CODIGODESCUENTO	NUMBER(8,0);
  -- excepcion
  no_dni EXCEPTION;

begin
  select nombre into v_nombre from clientes
     where v_dni = dni;
     DBMS_OUTPUT.PUT_LINE('DNI: ' || V_dni);
     DBMS_OUTPUT.PUT_LINE('NOMBRE: ' || V_NOMBRE);
 -- if clientes.dni <> dni then--saltar la exception y mostrar
   -- raise no_dni;
 -- end if;
  EXCEPTION
  when NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('No se encontraron datos con ese dni'); 
END PEDIDOS_CLIENTE;