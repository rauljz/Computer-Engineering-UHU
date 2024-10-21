(deftemplate suma
	(field num1)
	(field num2)
	(field num3)
	(field num4)
)

;mostramos la suma por pantalla

(defrule sumalista
	(suma
		(num1 ?num1)
		(num2 ?num2)
		(num3 ?num3)
		(num4 ?num4)
	)
	=>
	(bind ?total (+ ?num1 ?num2 ?num3 ?num4))
	(printout t "La suma de la lista es " ?total crlf)
)

;le damos valor a las variables

(deffacts sumaop
	(suma
		(num1 5)
		(num2 10)
		(num3 12)
		(num4 8)
	)
)