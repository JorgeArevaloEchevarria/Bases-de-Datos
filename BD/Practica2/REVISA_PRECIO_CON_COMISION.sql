------------------------------------------------------------------
--  PROCEDURE REVISA_PRECIO_CON_COMISION
------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE REVISA_PRECIO_CON_COMISION
IS
   igual       BOOLEAN := TRUE;
   rContiene   CONTIENE%ROWTYPE;
   vPrecio     PLATOS.PRECIO%TYPE;
   vComision   RESTAURANTES.COMISION%TYPE;
   vPrecioT    CONTIENE.PRECIOCONCOMISION%TYPE;


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
       WHERE NOMBRE = rContiene.plato;

      SELECT COMISION
        INTO vComision
        FROM RESTAURANTES
       WHERE CODIGO = rContiene.restaurante;

      vPrecioT := vPrecio * vComision * 0.01 + vPrecio;

      IF rContiene.PRECIOCONCOMISION != vPrecioT
      THEN
         igual := FALSE;
         DBMS_OUTPUT.PUT_LINE (
               'Datos modificados en el plato: '
            || rContiene.PLATO
            || rContiene.PEDIDO);

         --Actualizamos en contiene el precio de los platos respecto a su nombre y multiplicándolos por sus uds.
         --En el caso de que no haya consistencia
         UPDATE CONTIENE
            SET PRECIOCONCOMISION = vPrecio * vComision * 0.01 + vPrecio
          WHERE CONTIENE.PLATO = rContiene.PLATO;
      END IF;
   END LOOP;

   IF igual
   THEN
      DBMS_OUTPUT.PUT_LINE ('Los datos son iguales');
   END IF;
END;


/*Probamos a actualizar el precio de un plato y comprobamos la consistencia de los datos*/
/*UPDATE PLATOS 
SET PRECIO = '22,22'
WHERE PLATOS.NOMBRE = 'pizza arrabiata';*/

--exec REVISA_PRECIO_CON_COMISION;
/



