------------------------------------------------------------------
--  PROCEDURE REVISA_PEDIDOS
------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE REVISA_PEDIDOS
IS
   igual           BOOLEAN := TRUE;
   rPedidos        PEDIDOS%ROWTYPE;
   rContiene       CONTIENE%ROWTYPE;
   vPrecioPedido   NUMBER := 0;
   vPrecio         PLATOS.PRECIO%TYPE;
   vComision       RESTAURANTES.COMISION%TYPE;
   vPrecioT        CONTIENE.PRECIOCONCOMISION%TYPE;


   --Cursor para pedidos
   CURSOR cPedidos
   IS
      SELECT * FROM PEDIDOS;

   --Cursor para contiene
   CURSOR cContiene
   IS
      SELECT * FROM CONTIENE;
BEGIN
   --Comprobamos la consistencia del precio en contiene con el del plato multiplicado por sus unidades.
   FOR rContiene IN cContiene
   LOOP
      SELECT PRECIO
        INTO vPrecio
        FROM PLATOS
       WHERE NOMBRE = rContiene.PLATO;

      SELECT COMISION
        INTO vComision
        FROM RESTAURANTES
       WHERE CODIGO = rContiene.PEDIDO;

      vPrecioT := vPrecio * vComision * 0.01 + vPrecio;

      IF rContiene.PRECIOCONCOMISION != vPrecioT
      THEN
         igual := FALSE;
         DBMS_OUTPUT.PUT_LINE (
               'Datos modificados en el plato: '
            || rContiene.PLATO
            || rContiene.PEDIDO);

         --Actualizamos en contiene el precio de los platos respecto a su nombre y multiplicÃ¡ndolos por sus uds.
         --En el caso de que no haya consistencia
         UPDATE CONTIENE
            SET PRECIOCONCOMISION = vPrecio * vComision * 0.01 + vPrecio
          WHERE CONTIENE.PLATO = rContiene.PLATO;
      END IF;
   END LOOP;

   --Comprobamos la consistencia del importe de los pedidos respecto de la tabla contiene
   FOR rPedidos IN cPedidos
   LOOP
      SELECT SUM (PRECIOCONCOMISION * UDS)
        INTO vPrecioPedido
        FROM CONTIENE
       WHERE PEDIDO = rPedidos.CODIGO;

      IF vPrecioPedido != rPedidos.PRECIOCONCOMISION
      THEN
         igual := FALSE;
         DBMS_OUTPUT.PUT_LINE (
               'Datos modificados en el pedido: '
            || rPedidos.CODIGOPEDIDO
            || ' Nuevo importe: '
            || vPrecioPedido);

         --Actualizamos en caso de que no haya consistencia
         UPDATE PEDIDOS
            SET IMPORTET = vPrecioPedido
          WHERE PEDIDOS.CODIGOPEDIDO = rPedidos.CODIGOPEDIDO;
      END IF;
   END LOOP;


   IF igual
   THEN
      DBMS_OUTPUT.PUT_LINE ('Los datos son iguales');
   END IF;
END;
/



