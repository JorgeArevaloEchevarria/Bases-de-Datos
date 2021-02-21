LOAD DATA
INFILE 'contiene.txt'
APPEND
INTO TABLE contiene
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
restaurante,
plato,
pedido,
precioConComision,
unidades,
)