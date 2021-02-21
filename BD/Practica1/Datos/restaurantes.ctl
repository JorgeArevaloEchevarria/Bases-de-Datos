LOAD DATA
INFILE 'restaurante.txt'
APPEND
INTO TABLE Restaurante
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
codigo,
nombre,
calle,
codigoPostal,
comision
)