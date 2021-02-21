CREATE OR REPLACE PROCEDURE PEDIDOS_CLIENTE AS (v_dni varchar2)
is
  declare
  --datos cliente
  v_DNI VARCHAR(9);
  v_NOMBRE CHAR(15);
  v_APELLIDO CHAR(20);
  v_CALLE CHAR(20);
  v_NUMERO NUMBER(4,0);
  v_PISO CHAR(5);
  v_LOCALIDAD CHAR(15);
  v_CODIGO_POSTAL CHAR(5);
  v_telefono char(9);
  --pedidos
  v_CODIGO	NUMBER(8,0);
  v_ESTADO	CHAR(9);
  v_FECHA_HORA_PEDIDO	DATE;
  v_FECHA_HORA_ENTREGA	DATE;
  v_IMPORTE_TOTAL	NUMBER(8,2);
  v_CLIENTE	CHAR(9);
  v_CODIGODESCUENTO	NUMBER(8,0);
  -- excepcion
  no_dni EXCEPTION;

BEGIN
  IF NOT EXISTS( SELECT CLIENTES.NOMBRE,CLIENTES.APELLIDO,CLIENTES.CALLE,CLIENTES.LOCALIDAD,CLIENTES.CODIGOPOSTAL,CLIENTES.TELEFONO
    INTO v_nombre, v_apellido, v_calle, v_localidad, v_codigo_postal, v_telefono  
    FROM CLIENTES
    WHERE CLIENTES.DNI = DNI)
     raise no_dni;
  ELSE(
    DBMS_OUTPUT.PUT_LINE(V_NOMBRE);
    DBMS_OUTPUT.PUT_LINE(v_apellido);
    DBMS_OUTPUT.PUT_LINE(v_calle);
    DBMS_OUTPUT.PUT_LINE(v_localidad);
    DBMS_OUTPUT.PUT_LINE(V_CODIGO_POSTAL); 
    DBMS_OUTPUT.PUT_LINE(v_telefono); 
     )
     end if;
 
  EXCEPTION
  when no_dni THEN
  DBMS_OUTPUT.PUT_LINE('No se encontraron datos con ese dni'); 
  end create or replace procedure PEDIDOS_CLIENTE AS
(v_dni varchar)
is
  declare
  --datos cliente
  v_DNI VARCHAR(9);
  v_NOMBRE CHAR(15);
  v_APELLIDO CHAR(20);
  v_CALLE CHAR(20);
  v_NUMERO NUMBER(4,0);
  v_PISO CHAR(5);
  v_LOCALIDAD CHAR(15);
  v_CODIGO_POSTAL CHAR(5);
  v_telefono char(9);
  --pedidos
  v_CODIGO	NUMBER(8,0);
  v_ESTADO	CHAR(9);
  v_FECHA_HORA_PEDIDO	DATE;
  v_FECHA_HORA_ENTREGA	DATE;
  v_IMPORTE_TOTAL	NUMBER(8,2);
  v_CLIENTE	CHAR(9);
  v_CODIGODESCUENTO	NUMBER(8,0);
  -- excepcion
  no_dni EXCEPTION;

BEGIN
  SELECT CLIENTES.NOMBRE,CLIENTES.APELLIDO,CLIENTES.CALLE,CLIENTES.LOCALIDAD,CLIENTES.CODIGOPOSTAL,CLIENTES.TELEFONO
    INTO v_nombre, v_apellido, v_calle, v_localidad, v_codigo_postal, v_telefono  
    FROM CLIENTES
     WHERE CLIENTES.DNI = DNI
     IF NOT EXISTS(
     raise no_dni;
     )
     ELSE(
     DBMS_OUTPUT.PUT_LINE(V_NOMBRE);
      DBMS_OUTPUT.PUT_LINE(v_apellido);
      DBMS_OUTPUT.PUT_LINE(v_calle);
      DBMS_OUTPUT.PUT_LINE(v_localidad);
      DBMS_OUTPUT.PUT_LINE(V_CODIGO_POSTAL); 
      DBMS_OUTPUT.PUT_LINE(v_telefono); 
     )
     end if;
 
  EXCEPTION
  when no_dni THEN
  DBMS_OUTPUT.PUT_LINE('No se encontraron datos con ese dni'); 
  
end PEDIDOS_CLIENTE;