(defrule inicio
	(conjunto ? $?s)
	(not (interseccion $?))
	=>
	(assert (interseccion $?s))
)

(defrule interseccion
	?h <- (interseccion $?i ?e $?f)
	(conjunto ?id $?)
	(not (conjunto ?id $? ?e $?))
	=>
	(retract ?h)
	(assert (interseccion $?i $?f))
)

;mostramos por pantalla

(defrule imprimir-interseccion
  (interseccion $?i)
  =>
  (printout t "La intersección de los conjuntos es: {" ?i "}" crlf)
)

;declaramos las variables

(deffacts datos-iniciales
	(conjunto 9 3 5 11 8)
	(conjunto 8 7 4 2 5)
)