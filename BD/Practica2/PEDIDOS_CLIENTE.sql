------------------------------------------------------------------
--  PROCEDURE PEDIDOS_CLIENTE
------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE PEDIDOS_CLIENTE (v_dni CHAR)
IS
   --datos cliente
   v_nombre             CHAR (15);
   V_apellido           CHAR (20);
   calle                CHAR (20);
   numero               NUMBER (4, 0);
   piso                 CHAR (5);
   localidad            CHAR (15);
   codigo_postal        CHAR (5);
   telefono             CHAR (9);
   --pedidos
   CODIGO               NUMBER (8, 0);
   ESTADO               CHAR (9);
   FECHA_HORA_PEDIDO    DATE;
   FECHA_HORA_ENTREGA   DATE;
   importe_total        NUMBER (8, 2);
   CLIENTE              CHAR (9);
   CODIGODESCUENTO      NUMBER (8, 0);
   -- excepcion
   no_dni               EXCEPTION;
BEGIN
   SELECT nombre, apellido
     INTO v_nombre, v_apellido
     FROM clientes
    WHERE v_dni = dni;

   DBMS_OUTPUT.PUT_LINE ('DNI: ' || V_dni);
   DBMS_OUTPUT.PUT_LINE ('NOMBRE: ' || V_NOMBRE);
   DBMS_OUTPUT.PUT_LINE ('APELLIDO: ' || V_APELLIDO);
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      DBMS_OUTPUT.PUT_LINE ('No se encontraron datos con ese dni');
END PEDIDOS_CLIENTE;
/



