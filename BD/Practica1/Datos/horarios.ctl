LOAD DATA
INFILE 'horarios.txt'
APPEND
INTO TABLE Horarios
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
restaurante,
diaSemana,
hora_apertura "to_date(:fecha_hora_pedido,'DDQMMQYY:HH24:MI')",
hora_cierre "to_date(:fecha_hora_pedido,'DDQMMQYY:HH24:MI')"
)