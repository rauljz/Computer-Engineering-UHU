;calculamos las diferencias

(defrule resta
	(c1 $? ?x $?)
	(not (c2 $? ?x $?))
	(not (resta $? ?x $?))
	?r <- (resta $?y)
	=>
	(retract ?r)
	(assert (resta ?y ?x))
	(assert (result))
)

;mostramos por pantalla

(defrule result
	(resta $?x)
	=>
	(printout t "La diferencia es: " ?x crlf)
)

;definimos el conjunto

(deffacts cjt
	(c1 8 2 7 6 3)
	(c2 5 2 6 0 8)
	(resta)
)