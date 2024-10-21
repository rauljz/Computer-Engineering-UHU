;definimos las clases

(deftemplate Especialista
	(field esp)
	(multifield medcm)
)

(deftemplate Medicamento
	(field medcm)
	(multifield enf)
)

(deftemplate Enfermedad
	(field enf)
	(multifield sint)
)

;buscamos enfermedades

(defrule buscarEnfermedad
	(sint $? ?S $?)
	(Enfermedad
		(enf ?N)
		(sint $? ?S $?)) 
	(not (enf $? ?N $?))
	?enferm <- (enf $?E)
	=>
	(retract ?enferm)
	(assert (enf ?E ?N))
	(printout t "Podrias tener " ?S " porque tienes " ?N crlf)
)

;buscamos tratamiento

(defrule buscarTratamiento
	(enf $? ?E $?)
	(Medicamento
		(medcm ?N)
		(enf $? ?E $?))
	(Especialista
		(esp ?D)
		(medcm  $? ?E $?))
	(not (medcm $? ?N $?))
	?f <- (medcm $?T)
	=>
	(retract ?f)
	(assert (medcm ?T ?N))
	(printout t "Para la enfermedad " ?E " se puede tomar " ?N  ", dado por " ?D crlf)
)

;generamos los especialistas

(deffacts sistema

(Especialista
	(esp Medicogeneral)
	(medcm Vacuna Pastilla))

(Especialista
	(esp Nutricionista)
	(medcm Vitamina))

(Especialista
	(esp Endocrinologo)
	(medcm Vacuna))

(Especialista
	(esp Otorrino)
	(medcm Jarabe Contrex))

(Medicamento
	(medcm Pastilla)
	(enf Rubeola Hepatitis Tuberculosis))
(Medicamento
	(medcm Vacuna)
	(enf Gripe Rubeola Malaria Hepatitis))

(Medicamento
	(medcm Vitamina)
	(enf Anemia))

(Medicamento
	(medcm Contrex)
	(enf Gripe))

(Medicamento
	(medcm Jarabe)
	(enf Gripe))

(Enfermedad
	(enf Anemia)
	(sint Cansancio Mauseas Apatia))
(Enfermedad
	(enf Tuberculosis)
	(sint Tos Cansancio Fiebre Escalofrios))
(Enfermedad
	(enf Hepatitis)
	(sint Diarrea Nauseas Ictericia))
(Enfermedad
	(enf Malaria)
	(sint Diarrea Fiebre Ictericia Escalofrios))
(Enfermedad
	(enf Rubeola)
	(sint Fiebre Escalofrios Jaqueca Secredon))
(Enfermedad
	(enf Gripe)
	(sint Tos Cansancio Fiebre Dolor))
)

;generamos el diagnostico

(deffacts diagnosticoFinal
	(medcm)
	(enf)
)
