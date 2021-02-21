create or replace trigger control_detalle_pedidos
before insert or update or delete on CONTIENE
for each row
begin
  IF INSERTING THEN 
  UPDATE pedidos SET 
    "importe total" =  "importe total" + (:NEW."PRECIOCONCOMISI�N" * :NEW.unidades)
  WHERE codigo = :NEW.pedido;
  end IF;
    
  if UPDATING THEN 
  UPDATE pedidos SET
    "importe total" = "importe total" - (:OLD."PRECIOCONCOMISI�N" * :OLD.unidades) + (:NEW."PRECIOCONCOMISI�N" * :NEW.unidades)
  WHERE codigo = :NEW.PEDIDO;
  end if;
  
  if DELETING then
  update pedidos set
    "importe total" =  "importe total" - (:OLD."PRECIOCONCOMISI�N"  * :OLD.unidades)
  where codigo = :NEW.pedido;
  end if; 
end;