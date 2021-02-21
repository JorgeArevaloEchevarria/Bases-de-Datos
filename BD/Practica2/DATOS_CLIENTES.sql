------------------------------------------------------------------
--  PROCEDURE DATOS_CLIENTES
------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE DATOS_CLIENTES
IS
   rClientes   CLIENTES%ROWTYPE;
   vTotal      NUMBER := 0;

   --Cursor para clientes
   CURSOR cClientes
   IS
      SELECT * FROM CLIENTES;
BEGIN
   FOR rClientes IN cClientes
   LOOP
      SELECT SUM ("importe total")
        INTO vTotal
        FROM PEDIDOS
       WHERE cliente = rClientes.DNI;

      IF vTotal > 0
      THEN
         DBMS_OUTPUT.PUT_LINE (
               'Cliente: '
            || rClientes.DNI
            || ' '
            || rClientes.NOMBRE
            || ' Importe total de pedidos: '
            || vTotal);
         DBMS_OUTPUT.PUT_LINE (
            ' ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
      ELSE
         DBMS_OUTPUT.PUT_LINE (
               'Cliente: '
            || rClientes.DNI
            || ' '
            || rClientes.NOMBRE
            || ' Importe total de pedidos: '
            || 0);
         DBMS_OUTPUT.PUT_LINE (
            ' ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
      END IF;
   END LOOP;
END;




