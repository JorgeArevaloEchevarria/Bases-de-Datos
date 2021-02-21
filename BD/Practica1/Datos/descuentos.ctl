LOAD DATA
INFILE 'descuentes.txt'
APPEND
INTO TABLE Descuentos
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
codigo,
fecha_caducidad "to_date(:fecha_hora_pedido,'DDQMMQYY:HH24:MI')",
porcentaje descuento
)