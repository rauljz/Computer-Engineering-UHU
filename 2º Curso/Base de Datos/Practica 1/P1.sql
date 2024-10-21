--Tabla COMPA��A con PK cif
CREATE TABLE COMPA�IA(
  cif char(9) NOT NULL,
  nombre varchar2(20),
  web varchar2(30),
  CONSTRAINT pk_compa�ia PRIMARY KEY (cif)
);

--Tabla TARIFA con PK tarifa, compa��a(FK -> COMPA��A)
CREATE TABLE TARIFA(
  tarifa varchar2(10) NOT NULL,
  compa�ia char(9) NOT NULL,
  descripcion varchar2(50),
  coste numeric(3, 2),
  CONSTRAINT pk_tarifa PRIMARY KEY (tarifa, compa�ia),
  CONSTRAINT fk_tarifa_compa�ia
    FOREIGN KEY (compa�ia) REFERENCES COMPA�IA(cif)
);

--Tabla CLIENTE con PK dni
CREATE TABLE CLIENTE(
  dni char(9) NOT NULL,
  nombre varchar2(50),
  f_nac date,
  direccion varchar2(100),
  cp char(6),
  ciudad varchar2(50),
  provincia varchar2(50),
  CONSTRAINT pk_cliente PRIMARY KEY (dni)
);

--Tabla TEL�FONO con PK n�mero(FK -> Tarifa(tarifa, compa�ia) // Compa�ia(cif) // Cliente(dni))
CREATE TABLE TELEFONO(
  numero char(9) NOT NULL,
  f_contrato date,
  tipo char(1),
  puntos numeric(6, 0),
  compa�ia char(9),
  tarifa varchar2(10),
  cliente char(9),
  CONSTRAINT pk_telefono PRIMARY KEY (numero),
  CONSTRAINT fk_telefono_tarifa_compa�ia
    FOREIGN KEY (tarifa, compa�ia) REFERENCES TARIFA(tarifa, compa�ia),
  CONSTRAINT fk_telefono_compa�ia
    FOREIGN KEY (compa�ia) REFERENCES COMPA�IA(cif),
  CONSTRAINT fk_telefono_cliente
    FOREIGN KEY (cliente) REFERENCES CLIENTE(dni),
  CONSTRAINT r_caracteres_tipo
    CHECK (tipo IN ('T', 'C'))
);

--Tabla LLAMADA con PK f_origen, fecha_hora (FK -> tf_origen-Telefono // tf_origen-Telefono
CREATE TABLE LLAMADA(
  tf_origen char(9) NOT NULL,
  tf_destino char(9),
  fecha_hora timestamp,
  duracion numeric(5, 0),
  CONSTRAINT pk_llamada PRIMARY KEY (tf_origen, fecha_hora),
  CONSTRAINT fk_llamada_tforigen
    FOREIGN KEY (tf_origen) REFERENCES TELEFONO(numero),
  CONSTRAINT fk_llamada_tfdestino
    FOREIGN KEY (tf_destino) REFERENCES TELEFONO(numero),
  CONSTRAINT r_tfdestino_fecha_unica
    UNIQUE (tf_destino, fecha_hora)
);

--Modificaciones de restriccinoes
  --Nombre de compa�ia unico
ALTER TABLE COMPA�IA ADD CONSTRAINT r_nombre_compa�ia
  UNIQUE (nombre);

  --Telefono no llama a el mismo
ALTER TABLE TELEFONO ADD CONSTRAINT r_numeros_telefono
  CHECK (tf_origen!=tf_destino);

  --Coste llamadas
ALTER TABLE TARIFA ADD CONSTRAINT r_coste_tarifa
  CHECK (coste>=0.05 AND coste<=1.50);

  --Atributos NO obligatorios (NOT NULL)
  --COMPA�IA(nombre)
ALTER TABLE COMPA�IA
  MODIFY nombre NOT NULL;
    --CLIENTE(nombre)
ALTER TABLE CLIENTE
  MODIFY nombre NOT NULL;
   --TARIFA(coste)
ALTER TABLE TARIFA
  MODIFY coste NOT NULL;
   --TELEFONO(compa�ia. tarifa)
ALTER TABLE TELEFONO
  MODIFY compa�ia NOT NULL
  MODIFY tarifa NOT NULL;
  --LLAMADA(duracion)
ALTER TABLE LLAMADA
  MODIFY duracion NOT NULL;
  
  --Borrado tarifas al borrar compa�ia (en cascada)
ALTER TABLE TARIFA
  DROP CONSTRAINT fk_tarifa_compa�ia;
ALTER TABLE TARIFA
  ADD CONSTRAINT fk_tarifa_compa�ia FOREIGN KEY (compa�ia) REFERENCES COMPA�IA (cif) ON DELETE CASCADE;
  
--Insertar datos
  --COMPA�IA
INSERT INTO COMPA�IA
  VALUES('A00000001', 'Kietostar', 'http://www.kietostar.com/');
INSERT INTO COMPA�IA
  VALUES('B00000002', 'Aotra', 'http://www.aotra.com/');
  --TARIFA
INSERT INTO TARIFA
  VALUES('joven', 'A00000001', 'menores de 25 a�os', '0,25');
INSERT INTO TARIFA
  VALUES('d�o', 'A00000001', 'la pareja tambi�n est� en la compa��a', '0,20');
INSERT INTO TARIFA
  VALUES('familiar', 'A00000001', '4 miembros de la familia en la compa��a', '0,15');
INSERT INTO TARIFA
  VALUES('aut�nomos', 'B00000002', 'trabajador aut�nomo', '0,12');
INSERT INTO TARIFA
  VALUES('d�o', 'B00000002', 'la pareja tambi�n est� en la compa��a', '0,15');
  
--Intentar insertar
INSERT INTO COMPA�IA
  VALUES('A00000001', 'Petaf�n', 'http://www.petaf�n.com/'); --el campo cif ya existe y no puede repetirse al ser PK
INSERT INTO COMPA�IA
  VALUES('C00000003', 'Aotra', 'http://www.aot.com/'); --alteramos el campo nombre de la tabla COMPA�IA para convertirse en UNIQUE
INSERT INTO TARIFA
  VALUES('joven', 'D00000004', '4 miembros de la familia en la compa��a', '0,15'); --el campo compa��ia verifica que el cif(PK de COMPA�IA) insertado no corresponde con ninguna compa��a
INSERT INTO TARIFA
  VALUES('d�o', 'B00000002', 'la pareja tambi�n est� en la compa��a', '0,18'); --alteramos el campo nombre de la tabla TARIFA para convertirse en UNIQUE
INSERT INTO TARIFA
  VALUES('amigos', 'B00000002', '10 amigos est�n tambi�n en la compa��a', '1,60'); --el campo coste de la tabla TARIFA no puede superar un coste de 1,50
  
--Eliminar datos
DELETE FROM COMPA�IA
  WHERE cif = 'B00000002';
--Cmprobamos que se hayan elimiado las tarifas de la compa��a en cuesti�n
SELECT * FROM TARIFA
  
  
  
  
  
  
  