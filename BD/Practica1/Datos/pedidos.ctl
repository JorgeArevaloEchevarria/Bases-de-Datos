LOAD DATA
INFILE 'pedidos.txt'
APPEND
INTO TABLE Pedidos
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
codigo "Seq_CodPedidos.nextval",
estado,
fecha_hora_pedido "to_date(:fecha_hora_pedido,'DDQMMQYY:HH24:MI')",
fecha_hora_entrega"to_date(:fecha_hora_entrega,'DDQMMQYY:HH24:MI')",
importeTotal,
cliente
)