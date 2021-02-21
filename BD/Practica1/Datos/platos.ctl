LOAD DATA
INFILE 'platos.txt'
APPEND
INTO TABLE platos
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
restaurante,
nombre,
precio,
descripcion,
categoria
)