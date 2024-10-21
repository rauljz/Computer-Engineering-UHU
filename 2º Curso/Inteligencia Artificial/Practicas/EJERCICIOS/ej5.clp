(deftemplate conjunto
  (slot valor1)
  (slot valor2)
  (slot valor3)
  (slot valor4)
  (slot valor5)
)

;calculamos

(defrule calcular-diferencia
  (not (diferencia ?))
  (conjunto (valor1 ?v1) (valor2 ?v2) (valor3 ?v3) (valor4 ?v4) (valor5 ?v5))
  =>
  (bind ?max ?v1)
  (bind ?min ?v1)
  (if (> ?v2 ?max) then (bind ?max ?v2))
  (if (< ?v2 ?min) then (bind ?min ?v2))
  (if (> ?v3 ?max) then (bind ?max ?v3))
  (if (< ?v3 ?min) then (bind ?min ?v3))
  (if (> ?v4 ?max) then (bind ?max ?v4))
  (if (< ?v4 ?min) then (bind ?min ?v4))
  (if (> ?v5 ?max) then (bind ?max ?v5))
  (if (< ?v5 ?min) then (bind ?min ?v5))
  (assert (diferencia (- ?max ?min)))
)

;mostramos resultado

(defrule result
  (calcular-diferencia $?diferencia)
  =>
  (printout t "La diferencia es: " (nth$ 1 ?diferencia) crlf)
)

;creamos el conjunto

(deffacts initial
	(conjunto (valor1 6) (valor2 5) (valor3 1) (valor4 4) (valor5 8))
)