.MODEL SMALL 


.DATA

    azul DB 01h
    lin DW 00h

.CODE

	mov ax, seg azul
	mov ds, ax
	
	mov al, 13h
	mov ah, 0
	int 10h
	
	mov ax, 0A000h
	mov es, ax


	mov si, 0        

	BUCLE:
	mov bl, azul
	mov es:[SI], bl
	add SI, 2
	add lin, 1
	cmp lin, 160
	jb SL
	mov lin, 0
	add SI, 320

	SL:
	cmp SI, 64000

	jb BUCLE
	add azul, 01h
	mov SI, 0
	mov al, 13h
	mov ah, 0
	int 10h
	JMP BUCLE

	mov ah, 0
	int 16h

	mov ah, 4ch
	int 21h
END

