--Ejercicio 3: (Disparadores no entran. Y entra uno muy parecido a este)
set serveroutput on;
create or replace
procedure llamadas_cia(cia COMPAÑIA.nombre %type, fecha date) is

  existe_fecha integer;
  porcentaje number(5, 2);
  num_LL_100 integer;
  num_LL_Total integer;
  num_Total integer;
  no_existe_fecha exception;
  cursor c_telefonos_cia is
    select numero
    from COMPAÑIA C INNER JOIN TELEFONO T ON C.cif=T.compañia
    where C.nombre = cia;
  cursor c_llamadas_tf(tlf LLAMADA.tf_origen%type) is
    select duracion
    from LLAMADA L
    where to_char(fecha_hora, 'dd/mm/yy') = fecha and tf_origen=tlf;
begin
    select count (*) into existe_fecha
    from LLAMADA
    where to_char( fecha_hora, 'dd/mm/yy') = fecha;
    
    if existe_fecha= 0 then
        raise no_existe_fecha;
    end if;
    
    
    dbms_output.put_line('');
    dbms_output.put_line('Llamadas realizadas por los telefonos de la compañia ' || cia);
    dbms_output.put_line('---------------------------------------------');
    dbms_output.put_line('Tlf. Origen NUM_LL NUM_LL_100 %');
    dbms_output.put_line('---------------------------------------------');
    
    num_total:=0;
    
    for v_telefonos in c_telefonos_cia loop
        num_LL_100:=0;
        num_LL_Total:=0;
        for v_llamadas in c_llamadas_tf(v_telefonos.numero) loop 
            if v_llamadas.duracion > 100 then 
                num_LL_100 := num_LL_100 +1;
            end if;
            num_ll_Total:= num_LL_100 +1;
        end loop;
        num_Total:= num_Total + num_LL_Total;
        
        if num_LL_100 <> 0 then
            porcentaje := (num_LL_100/num_LL_Total)*100;
        else
            porcentaje := 0;
        end if;
        
         dbms_output.put_line(v_telefonos.numero || '      ' || num_ll_Total ||'           '||
                              num_ll_100 || '         ' || porcentaje || '%');
    end loop;
    dbms_output.put_line('Numero Total de LLamadas: ' || num_Total);
exception
    when no_existe_fecha then 
         dbms_output.put_line('No hay llamadas en la fecha ' || fecha || 'En la BD');
end;