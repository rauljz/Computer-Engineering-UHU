--Tabla COMPAÑÍA con PK cif
CREATE TABLE COMPAÑIA(
  cif char(9) NOT NULL,
  nombre varchar2(20),
  web varchar2(30),
  CONSTRAINT pk_compañia PRIMARY KEY (cif)
);

--Tabla TARIFA con PK tarifa, compañía(FK -> COMPAÑÍA)
CREATE TABLE TARIFA(
  tarifa varchar2(10) NOT NULL,
  compañia char(9) NOT NULL,
  descripcion varchar2(50),
  coste numeric(3, 2),
  CONSTRAINT pk_tarifa PRIMARY KEY (tarifa, compañia),
  CONSTRAINT fk_tarifa_compañia
    FOREIGN KEY (compañia) REFERENCES COMPAÑIA(cif)
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

--Tabla TELÉFONO con PK número(FK -> Tarifa(tarifa, compañia) // Compañia(cif) // Cliente(dni))
CREATE TABLE TELEFONO(
  numero char(9) NOT NULL,
  f_contrato date,
  tipo char(1),
  puntos numeric(6, 0),
  compañia char(9),
  tarifa varchar2(10),
  cliente char(9),
  CONSTRAINT pk_telefono PRIMARY KEY (numero),
  CONSTRAINT fk_telefono_tarifa_compañia
    FOREIGN KEY (tarifa, compañia) REFERENCES TARIFA(tarifa, compañia),
  CONSTRAINT fk_telefono_compañia
    FOREIGN KEY (compañia) REFERENCES COMPAÑIA(cif),
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
  --Nombre de compañia unico
ALTER TABLE COMPAÑIA ADD CONSTRAINT r_nombre_compañia
  UNIQUE (nombre);

  --Telefono no llama a el mismo
ALTER TABLE TELEFONO ADD CONSTRAINT r_numeros_telefono
  CHECK (tf_origen!=tf_destino);

  --Coste llamadas
ALTER TABLE TARIFA ADD CONSTRAINT r_coste_tarifa
  CHECK (coste>=0.05 AND coste<=1.50);

  --Atributos NO obligatorios (NOT NULL)
  --COMPAÑIA(nombre)
ALTER TABLE COMPAÑIA
  MODIFY nombre NOT NULL;
    --CLIENTE(nombre)
ALTER TABLE CLIENTE
  MODIFY nombre NOT NULL;
   --TARIFA(coste)
ALTER TABLE TARIFA
  MODIFY coste NOT NULL;
   --TELEFONO(compañia. tarifa)
ALTER TABLE TELEFONO
  MODIFY compañia NOT NULL
  MODIFY tarifa NOT NULL;
  --LLAMADA(duracion)
ALTER TABLE LLAMADA
  MODIFY duracion NOT NULL;
  
  --Borrado tarifas al borrar compañia (en cascada)
ALTER TABLE TARIFA
  DROP CONSTRAINT fk_tarifa_compañia;
ALTER TABLE TARIFA
  ADD CONSTRAINT fk_tarifa_compañia FOREIGN KEY (compañia) REFERENCES COMPAÑIA (cif) ON DELETE CASCADE;
  
--Insertar datos
  --COMPAÑIA
INSERT INTO COMPAÑIA
  VALUES('A00000001', 'Kietostar', 'http://www.kietostar.com/');
INSERT INTO COMPAÑIA
  VALUES('B00000002', 'Aotra', 'http://www.aotra.com/');
  --TARIFA
INSERT INTO TARIFA
  VALUES('joven', 'A00000001', 'menores de 25 años', '0,25');
INSERT INTO TARIFA
  VALUES('dúo', 'A00000001', 'la pareja también está en la compañía', '0,20');
INSERT INTO TARIFA
  VALUES('familiar', 'A00000001', '4 miembros de la familia en la compañía', '0,15');
INSERT INTO TARIFA
  VALUES('autónomos', 'B00000002', 'trabajador autónomo', '0,12');
INSERT INTO TARIFA
  VALUES('dúo', 'B00000002', 'la pareja también está en la compañía', '0,15');
  
--Intentar insertar
INSERT INTO COMPAÑIA
  VALUES('A00000001', 'Petafón', 'http://www.petafón.com/'); --el campo cif ya existe y no puede repetirse al ser PK
INSERT INTO COMPAÑIA
  VALUES('C00000003', 'Aotra', 'http://www.aot.com/'); --alteramos el campo nombre de la tabla COMPAÑIA para convertirse en UNIQUE
INSERT INTO TARIFA
  VALUES('joven', 'D00000004', '4 miembros de la familia en la compañía', '0,15'); --el campo compaññia verifica que el cif(PK de COMPAÑIA) insertado no corresponde con ninguna compañía
INSERT INTO TARIFA
  VALUES('dúo', 'B00000002', 'la pareja también está en la compañía', '0,18'); --alteramos el campo nombre de la tabla TARIFA para convertirse en UNIQUE
INSERT INTO TARIFA
  VALUES('amigos', 'B00000002', '10 amigos están también en la compañía', '1,60'); --el campo coste de la tabla TARIFA no puede superar un coste de 1,50
  
--Eliminar datos
DELETE FROM COMPAÑIA
  WHERE cif = 'B00000002';
--Cmprobamos que se hayan elimiado las tarifas de la compañía en cuestión
SELECT * FROM TARIFA
  
  
  
  
  
  
  