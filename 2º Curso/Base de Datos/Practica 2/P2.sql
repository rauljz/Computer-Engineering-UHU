--Practica 2


--SESION 1

--S1.1 Obtener el nombre de las compa��as cuya direcci�n web
--contenga la cadena �et� y acabe en �com�.
SELECT * FROM MF."COMPA�IA"
WHERE web LIKE '%et%com'

--S1.2 Obtener el nombre y direcci�n de los clientes nacidos en 1973 o 1985 y cuyo c�digo postal comience por 15,
--ordenado ascendentemente por el nombre y, en caso de igualdad, descendentemente por la direcci�n
SELECT NOMBRE, DIRECCION
FROM MF.CLIENTE
WHERE CP LIKE '15%'
  AND (EXTRACT (year FROM F_NAC)='1973'
      OR EXTRACT (year FROM F_NAC)='1985')
--AND (EXTRACT (year FROM f_nac) IN ('1973', '1985')
ORDER BY nombre, direccion desc;

--S1.3 Obtener el tel�fono de destino de las llamadas
--realizadas desde el n�mero �666010101�, en el a�o 2006
SELECT tf_destino
FROM MF.LLAMADA
WHERE  TF_ORIGEN like '666010101'
AND EXTRACT (YEAR FROM FECHA_HORA)='2006';

--S1.4 Obtener los n�meros de tel�fono que han llamado alguna vez
--al �666010101�, entre las 10:00 y las 12:00
SELECT TF_ORIGEN
FROM MF.LLAMADA
WHERE TF_DESTINO LIKE '666010101'
AND EXTRACT (HOUR FROM FECHA_HORA)='10:00' BETWEEN '12:00';

--S1.5 Obtener las tarifas distintas de aquellos clientes cuyo dni contiene el n�mero 2 y tienen entre 10000 y
--20000 puntos, pero que son de contrato, no tarjeta de prepago.
SELECT DISTINCT TARIFA
FROM MF.TELEFONO
WHERE CLIENTE LIKE '%2%'
AND (PUNTOS BETWEEN 10000 AND 20000)
AND TIPO='C';

--S1.6 Obtener los n�meros de tel�fonos junto a su tarifa, cuya fecha de contrato es en mayo (cualquier d�a y
--a�o), con tarifa distinta de joven, y que acaban en 9, ordenados por puntos descendentemente.
SELECT NUMERO, TARIFA
FROM MF.TELEFONO
WHERE EXTRACT (MONTH FROM F_CONTRATO)='5'
AND TARIFA NOT LIKE 'joven'
AND NUMERO LIKE '%9'
ORDER BY PUNTOS DESC;

--S1.7 Obtener los distintos tel�fonos a los que se han llamado desde el �654345345� durante el mes de octubre y
--noviembre, cuyas llamadas hayan tenido una duraci�n superior a los 250 segundos.
SELECT DISTINCT TF_DESTINO
FROM MF.LLAMADA
WHERE TF_ORIGEN='654345345'
AND EXTRACT (MONTH FROM FECHA_HORA) IN (10,11)
AND DURACION>=250;

--S1.8 Obtener los nombres de los clientes que nacieron entre 1970 y 1985 y que pertenezcan a la provincia de
--Huelva, ordenados ascendentemente por ciudad y descendentemente por provincia
SELECT NOMBRE
FROM MF.CLIENTE
WHERE EXTRACT (YEAR FROM F_NAC) BETWEEN '1970' AND '1985'
AND PROVINCIA LIKE 'Huelva'
ORDER BY ciudad ASC, provincia DESC



--SESION 2

--S2.1 Mostrar el código y coste de las tarifas junto con el nombre de la compañía que las ofrecen, de aquellas
--tarifas cuya descripción indique que otras personas deben estar también en la misma compañía
SELECT T.tarifa, T.coste, CC.nombre 
FROM MF."TARIFA" T INNER JOIN MF."COMPAÑIA" CC ON T.compañia=CC.cif
WHERE T.descripcion LIKE '%compañia%';


--S2.2 Nombre y número de teléfonos de aquellos abonados con contrato que tienen tarifas inferiores a 0,20 €.
SELECT C.NOMBRE, T.NUMERO
	FROM MF."CLIENTE" C INNER JOIN MF."TELEFONO" T ON T.CLIENTE=C.DNI
		INNER JOIN MF."TARIFA" TF USING (TARIFA, COMPAÑIA)
			WHERE TF.COSTE<0.20 AND T.TIPO='C';

--S2.3 Obtener el código de las tarifas, el nombre de las compañías, los números de teléfono y los puntos, de
--aquellos teléfonos que se contrataron en el año 2006 y que hayan obtenido más de 200 puntos.
SELECT T.TARIFA, CC.NOMBRE, TF.NUMERO, TF.PUNTOS
	FROM MF."TARIFA" T INNER JOIN MF."COMPAÑIA" CC ON T.COMPAÑIA=CC.CIF 
		INNER JOIN MF."TELEFONO" TF ON TF.COMPAÑIA=CC.CIF 
			WHERE EXTRACT(YEAR FROM TF.F_CONTRATO)='2006' AND TF.PUNTOS>=200;
	
		
		
--S2.4 Obtener los números de teléfono (origen y destino), así como el tipo de contrato, de los clientes que alguna
--vez hablaron por teléfono entre las 8 y las 10 de la mañana
SELECT LL.TF_ORIGEN, LL.TF_DESTINO , TF.TIPO
	FROM MF."LLAMADA" LL INNER JOIN MF."TELEFONO" ON LL.TF_ORIGEN=T.NUMERO
		WHERE EXTRACT(HOUR FROM LL.fecha_hora) BETWEEN '8' AND '9'
  			AND EXTRACT(MINUTE FROM LL.fecha_hora) BETWEEN '00' AND '59';
		
		
--S2.5 Interesa conocer los nombres y números de teléfono de los clientes (origen y destino) que, perteneciendo
--a compañías distintas, mantuvieron llamadas que superaron los 15 minutos. Se desea conocer, también, la
--fecha y la hora de dichas llamadas así como la duración de esas llamadas
SELECT   clo.nombre AS "Cliente origen", lla.tf_destino, cld.nombre as "Cliente Destino", lla.tf_origen, lla.duracion
FROM (((MF.cliente clo INNER JOIN MF.telefono tlf ON clo.dni=tlf.cliente)
    INNER JOIN MF.llamada lla ON lla.tf_origen=tlf.numero)
    INNER JOIN MF.telefono tlfd ON lla.tf_destino=tlfd.numero)
    INNER JOIN mf.cliente cld on cld.dni=tlfd.cliente
WHERE tlf.compañia <> tlfd.compañia AND lla.duracion>900;
		
		

--SESION 3


--S3.1 Obtener la fecha (día mes año) en la que se realizó la llamada de mayor duración
SELECT TO_CHAR(fecha_hora, 'dd/mm/yyyy') Fecha
FROM MF."LLAMADA" l
WHERE l.duracion>= ALL (SELECT ll.duracion
						FROM MF."LLAMADA" ll);
					
--S3.2 Obtener el nombre de los abonados de la compañía ‘Aotra’ con el mismo tipo de tarifa que la del telefono
--"654123321"
SELECT c.nombre
FROM MF.CLIENTE c INNER JOIN MF.TELEFONO tf ON c.dni=tf.cliente
INNER JOIN MF.COMPAÑIA cc ON tf.compañia=cc.cif
WHERE cc.nombre='Aotra' AND tf.tarifa=(SELECT tlfd.tarifa
									  FROM MF.TELEFONO tlfd 
									  WHERE tlfd.numero='654123321');

--S3.3 Mostrar, utilizando para ello una subcobsulta, el número de teléfono, fecha de contrato y tipo de los
--abonados que han llamado a teléfonos de clientes de fuera de la provincia de La Coruña durante el mes de
--octubre de 2006.
SELECT DISTINCT tf.numero, tf.f_contrato, tf.tipo
FROM MF.TELEFONO tf INNER JOIN MF.LLAMADA ll ON ll.tf_origen=tf.numero
WHERE TO_CHAR(ll.fecha_hora , 'mm/yyyy')='10/2006' AND tf.numero NOT IN(SELECT tfd.numero
																		FROM MF.TELEFONO tfd INNER JOIN MF.CLIENTE cl ON tfd.cliente=cl.dni
																		WHERE cl.provincia='La Coruña');

--S3.4 Se necesita conocer el nombre de los clientes que tienen teléfonos con tarifa “dúo” pero no “autónomos”.
--Utiliza subconsultas para obtener la solución.
SELECT cl.nombre
FROM MF.CLIENTE cl INNER JOIN MF.TELEFONO tf ON tf.cliente=cl.dni
WHERE tf.numero=(SELECT tfd.numero
				FROM MF.TELEFONO tfd INNER JOIN MF.TARIFA t ON tfd.tarifa=t.tarifa
				WHERE t.descripcion='dúo')
AND tf.numero NOT IN (SELECT tfd.numero
				FROM MF.TELEFONO tfd INNER JOIN MF.TARIFA t ON tfd.tarifa=t.tarifa
				WHERE t.descripcion='autónomos');
			
--S3.5 Obtener mediante subconsultas los nombres de clientes y números de teléfono que aquellos que hicieron
--llamadas a teléfonos de la compañía Petafón pero no Aotra
SELECT 	cl.nombre, tf.numero
FROM MF.CLIENTE cl INNER JOIN MF.TELEFONO tf ON cl.dni=tf.cliente
WHERE tf.numero IN (SELECT ll.tf_destino
					FROM MF.LLAMADA ll INNER JOIN MF.TELEFONO tfd ON tfd.numero=ll.tf_destino
					INNER JOIN MF.COMPAÑIA cc ON tfd.compañia=cc.cif
					WHERE cc.nombre='Petafón')
					AND tf.numero NOT IN (SELECT ll.tf_destino
								 	      FROM MF.LLAMADA ll INNER JOIN MF.TELEFONO tfd ON tfd.numero=ll.tf_destino
								 		  INNER JOIN MF.COMPAÑIA cc ON tfd.compañia=cc.cif
								  		  WHERE cc.nombre='Aotra');
																	
--S3.6 Nombre de los clientes de la compañía Kietostar que hicieron las llamadas de mayor duración en
--septiembre de 2006																	
SELECT cl.nombre
FROM MF.CLIENTE cl INNER JOIN MF.TELEFONO tf ON cl.dni=tf.cliente
INNER JOIN MF.LLAMADA ll ON ll.tf_origen=tf.numero
INNER JOIN MF.COMPAÑIA cc ON tf.compañia=cc.cif
WHERE cc.nombre='Kietostar' AND to_char(ll.fecha_hora, 'mm/yy')='09/06' AND ll.duracion>=ALL (SELECT duracion
                                           												  		FROM (MF.telefono t INNER JOIN MF.compañia co ON co.cif=t.compañia)
                                           												  		INNER JOIN MF.llamada ll ON ll.tf_origen=t.numero
                                          												 		 WHERE co.nombre='Kietostar' AND to_char(ll.fecha_hora, 'mm,yy')='09/06')

--S3.7 Se necesita conocer el nombre de los clientes que tienen teléfonos con fecha de contratación anterior a
--alguno de los teléfonos de Ramón Martínez Sabina, excluido, claro, el propio Ramón Martínez Sabina.                                          												 		 
SELECT cl.nombre 
	FROM MF.CLIENTE cl INNER JOIN MF.TELEFONO tf ON cl.dni=tf.cliente
		WHERE cl.nombre<>'Ramón Martínez Sabina' 
		AND tf.f_contrato< ANY (SELECT TL.f_contrato FROM MF."TELEFONO" TL
								WHERE TL.cliente IN (SELECT CL.dni FROM MF."CLIENTE" CL
													WHERE CL.nombre = 'Ramón Martínez Sabina' )				 
   							  ); 		
													
   												 		 
--SESION 4


--S4.1 Utilizando consultas correlacionadas,
--mostrar el nombre de los abonados que han llamado el día ‘16/10/06’
SELECT C.NOMBRE, T.NUMERO
FROM MF.CLIENTE C INNER JOIN MF .TELEFONO T ON C.DNI=T.CLIENTE
WHERE EXISTS (SELECT *
                FROM MF.LLAMADA L
                WHERE to_char(L.FECHA_HORA,'dd/mm/yy')='16/10/06'
                AND L.TF_ORIGEN=T.NUMERO);
                
--S4.2 Utilizando consultas correlacionadas, obtener el nombre de los abonados que han realizado llamadas de 
--menos de 1 minuto y medio         
SELECT C.NOMBRE
FROM MF.CLIENTE C INNER JOIN MF.TELEFONO T ON C.DNI=T.CLIENTE
WHERE EXISTS (SELECT *
              FROM  MF.LLAMADA L
              WHERE L.DURACION<90
              AND L.TF_ORIGEN=T.NUMERO);
              
--S4.3 Utilizando consultas correlacionadas, obtener el nombre de los abonados de la compañía ‘KietoStar’ que no 
--hicieron ninguna llamada el mes de septiembre
SELECT C.NOMBRE
FROM MF.CLIENTE C INNER JOIN MF.TELEFONO T ON C.DNI=T.CLIENTE
INNER JOIN MF.COMPAÑIA CC ON CC.CIF=T.COMPAÑIA
WHERE CC.NOMBRE='KietoStar' AND 
  NOT EXISTS (SELECT *
              FROM MF.LLAMADA L
              WHERE EXTRACT(MONTH FROM L.FECHA_HORA)='9'
              AND L.TF_ORIGEN=T.NUMERO);
              
              
 --S4.4 Utilizando consultas correlacionadas, mostrar todos los datos de los telefonos que hayan llamado al 
--número 654234234 pero no al 666789789             
SELECT *
FROM MF.telefono t
WHERE EXISTS ( SELECT *
              FROM MF.llamada ll INNER JOIN MF.telefono tl ON ll.tf_origen=tl.numero
              WHERE ll.tf_destino='654234234' AND ll.tf_origen=t.numero)
     AND NOT EXISTS (SELECT *
                     FROM MF.llamada ll INNER JOIN MF.telefono tl ON ll.tf_origen=tl.numero
                     WHERE ll.tf_destino='666789789' AND ll.tf_origen=t.numero) 


--S4.5 Utilizando consultas correlacionadas, obtener el nombre y número de teléfono de los clientes de la 
--compañía Kietostar que no han hecho llamadas a otros teléfonos de la misma compañía
SELECT cl.nombre, tf.numero
FROM MF.CLIENTE cl INNER JOIN MF.TELEFONO tf ON cl.dni=tf.cliente
INNER JOIN MF.COMPAÑIA cc ON tf.compañia=cc.cif
WHERE cc.nombre='Kietostar'
AND NOT EXISTS(SELECT *
			FROM MF.LLAMADA ll INNER JOIN MF.TELEFONO tfl ON tfl.numero=ll.tf_destino
			INNER JOIN MF.COMPAÑIA co ON tfl.compañia=co.cif
			WHERE co.nombre='Kietostar'
            AND ll.tf_origen=tf.numero);       
           
           
                                          
--SESION 5 
                     
--S5.1 Mostrar la compañía con la que se realizaron más llamadas durante el día 16/10/06            
SELECT DISTINCT CC.nombre 
FROM MF."LLAMADA" LL INNER JOIN MF."TELEFONO" TL ON TL.numero=LL.tf_origen
  INNER JOIN MF."COMPAÑIA" CC ON CC.cif=TL.compañia
   WHERE TO_CHAR(LL.fecha_hora, 'dd/mm/yy')='16/10/06'
GROUP BY CC.nombre
  HAVING COUNT(*)=(SELECT MAX(COUNT(*))
                      FROM MF."LLAMADA" LL INNER JOIN MF."TELEFONO" TL ON TL.numero=LL.tf_origen
                        WHERE TO_CHAR(LL.fecha_hora, 'dd/mm/yy')='16/10/06'
                          GROUP BY TL.compañia
                  );                     
                     
--S5.2 Obtener los números de teléfono y los nombres de los abonados que han llamado a todos los números a los
--que se llamó desde el 654345345 en octubre de 2006                     
SELECT DISTINCT  t.numero, c.nombre
FROM MF.cliente c INNER JOIN MF.telefono t ON c.dni=t.cliente
WHERE t.numero = (SELECT MAX (ll.tf_origen)
                              FROM MF.llamada ll
                              WHERE EXTRACT(year from ll.fecha_hora)='2006' AND ll.tf_origen='654345345'
                          );

--S5.3 Mostrar el nombre de cada cliente junto con coste total de las llamadas que realiza con cada compañia. El
--resultado debe mostrarse ordenado descendentemente por cliente y ascendentemente por compañia
SELECT cl.nombre as Cliente, co.nombre as Compañia, SUM(lla.duracion/60 * ta.coste) as Costetotal
FROM (((MF.cliente cl INNER JOIN MF.telefono t ON cl.dni=t.cliente)
        INNER JOIN MF.compañia co ON t.compañia=co.cif)
        INNER JOIN MF.tarifa ta ON ta.tarifa=t.tarifa)
        INNER JOIN MF.llamada lla ON lla.tf_origen=t.numero
GROUP BY cl.nombre, co.nombre
ORDER BY cl.nombre DESC, co.nombre ASC  

--S5.4 Para cada cliente residente en la provincia de 'La Coruña', mostrar la duración de todas las llamadas
--realizadas a clientes residentes en 'Jaén'
SELECT cl.nombre, SUM(lla.duracion) AS Duracion
FROM (MF.cliente cl INNER JOIN MF.telefono t ON cl.dni=t.cliente)
        INNER JOIN MF.llamada lla ON lla.tf_origen=t.numero
WHERE cl.provincia LIKE 'La Coruña' AND lla.tf_destino IN (SELECT te.numero
                                                            FROM (MF.cliente c INNER JOIN MF.telefono te ON c.dni=te.cliente)
                                                                    INNER JOIN MF.llamada l ON l.tf_destino=te.numero
                                                            WHERE c.provincia LIKE 'Jaen')
GROUP BY cl.nombre

--S5.5 Mostrar los nombres de todos los clientes que hayan realizado más de 5 llamadas
SELECT c.nombre, COUNT(*)
FROM (MF.cliente c INNER JOIN MF.telefono t ON c.dni=t.cliente)
        INNER JOIN MF.llamada lla ON t.numero=lla.tf_origen
GROUP BY c.nombre
HAVING COUNT(*) > 5

--S5.6 Mostrar el nombre de aquellos clientes que hayan contratado con cualquier compañía, de media, una tarifa
--superior a la tarifa media total.
SELECT c.nombre, AVG(tar.coste) AS Media
FROM (MF.cliente c INNER JOIN MF.telefono t ON c.dni=t.cliente)
        INNER JOIN MF.tarifa tar ON t.tarifa=tar.tarifa
GROUP BY c.nombre
HAVING AVG(tar.coste) >=ALL (SELECT AVG(coste)
                            FROM MF.tarifa
                            )
                            
--S5.7 Mostrar los nombres de los clientes que hayan realizado llamadas a telefonos de la compañia 'Kietostar'
--por un coste menor de 100€
SELECT c.nombre 
FROM (((MF.cliente c INNER JOIN MF.telefono t ON c.dni=t.cliente)
     INNER JOIN MF.compañia co ON t.compañia=co.cif)
    INNER JOIN MF.llamada l ON t.numero=l.tf_origen)
    INNER JOIN MF.tarifa ta ON t.tarifa=ta.tarifa
WHERE l.tf_destino IN (SELECT te.numero
                        FROM MF.telefono te INNER JOIN MF.compañia com ON te.compañia=com.cif
                        WHERE co.nombre LIKE 'Kietostar'
                        )
GROUP BY c.nombre
HAVING SUM(ta.coste) < 100




                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 