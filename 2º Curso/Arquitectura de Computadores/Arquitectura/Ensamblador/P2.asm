.MODEL SMALL ;El modelo pequeño tiene un segmento de codigo y otro de
	     ;datos, pero como lo vamos a montar en un .COM solo
	     ;podemos usar el segmento de codigo, 64KB.
.CODE ;Comienzo del segmento de codigo

	org 100h ;Le decimos al ensamblador que comience las
		 ;instrucciones en 100h, porque esos 256 bytes se
		 ;reservan para que el OS ponga su PSP, para .COM
Programa_Int: ;Aquí comienza nuestro programa residente
	
	JMP Reside ;Tenemos que saltar, porque lo que sigue aquí no
		   ;queremos que se ejecute, no es codigo, son datos, y
		   ;luego esta la rutina de servicio, que tampoco
		   ;queremos que se ejecute justo ahora. Vamos al codigo
		   ;que hace residente nuestro programa.
	CONT DB 0 ;Las variables las tenemos que declarar en este
		  ;mismo segmento porque no tenemos segmento de datos
	

Rutina_Servicio PROC ;Esta estas son las instrucciones que
		     ;pondremos en memoria

	CLI ;Desactivamos las interrupciones para que
	    ;nadie interrumpa una interrupción
	INC CONT ;Incrementamos el contador
	CMP CONT, 3 ;Si llegamos a 18 interrupciones significa que
	             ;ha pasado un segundo
	JNE SALIR ;Si no hemos llegado, terminamos ya la rutina
	MOV AH,4ch
    INT 21h
	
	SALIR:
	STI ;Activa las interrupciones
	IRET ;Retorno de la interrupcion.

ENDP ;Acaba la rutina de atencion a la interrupcion
Reside: ;Codigo que hace el programa residente, esta parte no, la
	;anterior es la que carga en memoria

	MOV DX, offset Rutina_Servicio ;Desplazamiento, donde
				       ;comienza la rutina de
				       ;servicio
	MOV AX, 0 ;Escribimos en el registro del segmento extra 0,
	       	  ;porque queremos escribir justo en el principio de la
		  ;memoria, que es donde esta el vector de interrupcion
		  ;Reservados todos los derechos.

	MOV ES, AX ;No podemos escribir con direccionamiento inmediato
		;en ES, por eso usamos AX como intermediario
	MOV SI, 1Ch*4 ;En el registro indice ponemos la posicion del
	              ;vector de interrupciones donde queremos
		      ;escribir la entrada. 1Ch porque es el codigo
		      ;de la interrupcion de reloj. El *4 es debido
		      ;a que cada entrada de esta tabla ocupa 4
			;bytes.
	CLI ;Desasctiva las interrupciones, porque estamos
	    ;modificando el vector de interrupcion. Como
            ;tenemos que escribir dos datos, si viene una
	    ;interrupcion mientras estamos a medias las
		;consecuencias son inpredecibles.
	MOV ES:[SI], DX ;Copiamos el desplazamiento de la rutina de
			;servicio
	MOV ES:[SI+2], CS ;Dos bytes mas acabajo copiamos el segmento de
			  ;nuestro codigo
	STI ;Habilita las interrupciones
	MOV DX, offset Reside ;Ponemos en DX el desplazamiento del final
			      ;de la rutina de atencion a la
		              ;interrupcion, que acaba justo donde
			      ;empieza esta seccion de codigo.
	INT 27h ;Esta interrupcion significa, termina y
		;sigue residente
END Programa_Int ;Acaba Todo el programa