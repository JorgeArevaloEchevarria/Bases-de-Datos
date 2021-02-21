LOAD DATA
INFILE 'areas.txt'
APPEND
INTO TABLE "Areas Cobertura"
FIELDS TERMINATED BY';'(restaurante,"codigo postal")
