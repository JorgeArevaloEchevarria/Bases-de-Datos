SELECT TABLE_NAME FROM USER_TABLES;
-- Permite ver las tablas creadas por el usuario conectado
CREATE TABLE Restaurantes(
 codigo NUMBER(8) NOT NULL,
 nombre CHAR(20) NOT NULL,
 calle CHAR(30) NOT NULL,
 codigoPostal CHAR(5) NOT NULL,
 comision NUMBER(8,2) ,
 PRIMARY KEY(codigo)
);
                            
create table AreasCobertura(
restaurante Number(8)  NOT null REFERENCES  Restaurantes(codigo),
codigoPostal Char(5) NOT null,
PRIMARY KEY(restaurante, codigoPostal)
);
/*DROP TABLE AreasCobertura;*/

create table Horarios(
restaurante Number(8) references Restaurantes(codigo)ON DELETE
CASCADE,
diaSemana Char(1),
hora_apertura Date,
hora_cierre Date,
PRIMARY KEY(diaSemana, restaurante)
);

create table Platos(
restaurante Number(8)  references Restaurantes(codigo)ON DELETE
CASCADE,
nombre Char(20) not null, 
precio Number(8,2),
descripcion Char(30),
categoría Char(10),
PRIMARY KEY(nombre, restaurante)
);
CREATE INDEX I_CatPlatos ON Platos(categoría);

drop table Pedidos;
CREATE TABLE Pedidos(
 codigo NUMBER(8) NOT NULL
 , estado CHAR(9) DEFAULT 'REST' NOT NULL
 , fecha_hora_pedido DATE NOT NULL
 , fecha_hora_entrega DATE
 , "importe total" NUMBER(8,2)
 , cliente CHAR(9) NOT NULL REFERENCES Clientes(DNI) /*constraint on delete restrict = no poner nada*/
 , codigoDescuento Number(8) REFERENCES Descuentos(codigo) ON
DELETE SET NULL
 , PRIMARY KEY(codigo)
 , CHECK (estado IN ('REST', 'CANCEL', 'RUTA', 'ENTREGADO',
'RECHAZADO'))
);
CREATE SEQUENCE Seq_CodPedidos INCREMENT BY 1 START WITH 1 NOMAXVALUE;
/*alter table pedidos modify estado default 'REST';*/
/*alter table pedidos modify estado check (estado in ('REST','CANCEL', 'RUTA','ENTREGADO','RECHAZADO'));*/
drop table contiene
CREATE TABLE Contiene(
 restaurante NUMBER(8)
 , plato CHAR(20)
 , pedido NUMBER(8) REFERENCES Pedidos(codigo) ON DELETE
CASCADE
 , precioConComisión NUMBER(8,2)
 , unidades NUMBER(4)NOT NULL
 , PRIMARY KEY(restaurante, plato, pedido)
 , FOREIGN KEY(restaurante, plato) REFERENCES Platos(restaurante, nombre)
);
CREATE TABLE Descuentos(
 codigo NUMBER(8) NOT NULL
 , fecha_caducidad DATE
 , "porcentaje descuento" NUMBER(3) CHECK ("porcentaje descuento" >0 AND "porcentaje descuento"<=100),
 PRIMARY KEY(codigo)
 );
 CREATE TABLE Clientes(
 DNI Char(9) not null,
 nombre Char(15)not null,
 apellido Char(20)not null,
 calle Char(20),
 numero Number(4)not null,
 piso Char(5),
 localidad Char(15),
 codigoPostal Char(5),
 telefono Char(9),
 usuario Char(8)not null, 
 contraseña Char(8) default 'Nopass',
 PRIMARY KEY(DNI)
 )
alter table clientes modify usuario unique;


INSERT INTO Restaurantes VALUES (1234,'pizzahu','abascal 45','12345',2.0);
INSERT INTO AreasCobertura VALUES (1234,'12345');
INSERT INTO Horarios VALUES (1234,'X',to_date('12:00', 'HH24:MI'),to_date('23:00','HH24:MI'));
INSERT INTO Platos VALUES (1234,'pizza arrabiata',17.50,'pizza de carne y guindilla','picante');
INSERT INTO Clientes VALUES
('12345678N','Pedro','Pérez','Torralba',29,'4B','Madrid','12345','12345612','pedro','pedro'); 
INSERT INTO Descuentos VALUES (1100,to_date('20-04-09', 'DD-MM-YY'),50);
INSERT INTO Pedidos VALUES (1,'REST',to_date('17-02-09:19:50','DD-MM-YY:HH24:MI'),to_date('17-02-09:20:50','DD-MM-YY:HH24:MI'),34.25,'12345678N',1100);
INSERT INTO Contiene VALUES (1234,'pizza arrabiata',1,NULL,2);

/*2b*/
/*Se intenta insertar una fila con clave primaria duplicada*/
INSERT INTO Restaurantes VALUES (1234,'pizzahu','abascal 45','12345',2.0);
/*Se intenta una inserción que no incluye todas las columnas no nulables. Ejemplo:
INSERT INTO Contiene (restaurante) VALUES (1234);*/
INSERT INTO Contiene (restaurante) VALUES (1234);
/*Se intenta una inserción que no verifica las restricciones de dominio (CHECK)*/
INSERT INTO Descuentos VALUES (1100,to_date('20-04-09', 'DD-MM-YY'),-1);
/*Se intenta una inserción que no respeta una regla de integridad referencial */
INSERT INTO Platos VALUES (4321,'pizza arrabiata',17.50,'pizza de carne y guindilla','picante');
/*Se intenta un borrado en una tabla padre con filas dependientes con una regla de borrado
restringuida (el defecto, en Oracle no se pone ‘ON DELETE RESTRICT’), 
y documentar que pasa si se borra en una tabla padre con filas
dependientes con regla de borrado ON DELETE SET NULL y ON DELETE CASCADE. */
drop table Clientes;
drop table Pedidos;
 DELETE FROM restaurantes WHERE codigo='1234';
/*Muestra la tabla de horarios. ¿se muestran las horas?. Trata de solucionarlo con la función to_char.*/
SELECT TO_CHAR(hora_apertura, 'DD-MM-YY:HH24:MI') from horarios;
SELECT TO_CHAR(hora_cierre, 'DD-MM-YY:HH24:MI') from horarios;

/* Borrar todas las tablas para el apartado 3*/
DELETE FROM Descuentos;
DELETE FROM Contiene;
delete from pedidos;
delete from platos;
delete from horarios;
delete from areascobertura;
delete from clientes;
delete from restaurantes;