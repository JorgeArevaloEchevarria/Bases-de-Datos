create or replace
procedure REVISA_PRECIO_CON_COMISION
AS
  cursor c_comisiones is
  select 
    contine.restaurante
    contiene.plato
    contiene.PRECIOCONCOMISION
    plato.precio
    restaurantes.comision
    round(plato.precio= [] o (restaurantes.comision/ 100)), 2) as precio_correcto_comi
    --revisar el precio correcto con comision
    from contiene co
    where platos ps
    on co.restaurante = ps.restaurante
    and co.plato = ps.nombre
    join restaurante re
    on co.restaurante = re.codigo for update 
BEGIN
  for linea in c_comisiones
  loop
    if linea.PRECIOCONCOMISION IS null or linea.precio_con_comision <> linea.precio_correcto_comi then 
    modifi_contiene  modifi_contine = 1
    update contiene
    set PRECIOCONCOMISION = precio_correcto_comi
    where restaurante =linea.restaurante
    and plato = linea.plato
    and pedido = linea.pedido;
    end if;
  end loop;
  if modifi_contiene = 0 then
    DBMS_OUTPUT.PUT_LINE('No hay cambio en los datos de contiene');
  else 
    DBMS_OUTPUT.PUT_LINE('Filas de la tabla contiene actualizadas';
  end
end
  