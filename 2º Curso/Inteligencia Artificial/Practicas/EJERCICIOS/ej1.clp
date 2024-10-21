;buscamos los elentos repetido

(defrule repetido
	(lista $? ?r $? ?y&:(= ?y ?r) $?)
	=>
	(assert (repetido ?r))
	(assert (result ?r))
)

;mostramos los repetidos 

(defrule result
	(repetido ?r)
	=>
	(printout t "Se repite el numero " ?r "" crlf)
)

;creamos la lista de numeros

(deffacts nums
	(lista 5 4 1 3 3 1)
)