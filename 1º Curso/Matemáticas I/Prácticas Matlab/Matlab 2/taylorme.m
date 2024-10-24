%% TAYLOR by GonzaloMQ
syms x
format long
g=input('Ponga la ecuación a aproximar por TAYLOR: g = ');
%g=((1+x)^(1/3));
o=input('\nOrden del polinomio de TAYLOR:      orden = ');
x0=input('Punto evaluación:                    punto = ');
ptaylor=taylor(g,x0,o+1);
fprintf('\nPOLINOMIO DE TAYLOR: \n')
disp(ptaylor)
% Sustituir por los valores
fprintf('***Sustituimos los valores simbólicos por valores reales***\n\n')
s=input('Sustitución: x = ');
subs(g,x,s);
taylor(g,x0,o);
% Funcion evaluar: 
poli=taylor(g,o,x0); 
puntos=s;
valorPolinomio=subs(poli,puntos);
valorFuncion=subs(g,puntos);
error=valorPolinomio-valorFuncion;
% Visualizar resultados
disp('  ----------------------------------------------');
fprintf('  POLINOMIO DE TAYLOR:  ');
disp(   ptaylor);
fprintf('  VALOR FUNCION:    ');
disp(   valorFuncion);
fprintf('  VALOR POLINOMIO:  ');
disp(   valorPolinomio);
format short e 
fprintf('  ERROR:            ');
disp(   error) %vpa(error,5);
disp('  ----------------------------------------------');