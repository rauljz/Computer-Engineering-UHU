% Ejercicio de límites. Cálculo de asintotas y representaciones gráficas.
 
% x variable de funcion
syms x;
% mostrar "bonita" la funcion f(x)
pretty(f(x));
%pause
 
% [x0, xn, y0, yn]
%fplot('f(x)', [-20,20,-30,5]) % Dibuja las asintotas verticales
%pause
 
%ezplot(f(x)) % Dibuja en [-2*pi, 2*pi] e incluye título
%pause
 
%ezplot(f(x), [-20,20]) % Idem definiendo el rango en las x (en "y" no deja)
%pause
 
% Asíntotas horizontales
L1 = limit(f(x),x,inf) %#ok<NOPTS>
L2 = limit(f(x),x,-inf) %#ok<NOPTS>
 
disp('Apartado a): No existen asintotas horizontales')
%pause
 
% Asíntotas verticales
[num,den] = numden(f(x)) %#ok<NOPTS> % separo numerador y denominador
raices_den = solve(den) %#ok<NOPTS> % raices del denominador
 
limit(f(x), x, raices_den(1))
L3_derch = limit(f(x), x, raices_den(1), 'right') %#ok<NOPTS>
L3_izq = limit(f(x), x, raices_den(1), 'left') %#ok<NOPTS>
 
limit(f(x), x, raices_den(2))
L4_derch = limit(f(x), x, raices_den(2), 'right') %#ok<NOPTS>
L4_izq = limit(f(x), x, raices_den(2), 'left') %#ok<NOPTS>
 
AV1 = double(raices_den(1)) %#ok<NOPTS>% convertir variables simbólicas en numéricas
AV2 = double(raices_den(2)) %#ok<NOPTS>
 
disp('Apartado b): existen dos asíntotas verticales de ecuaciones:')
disp(['x = ', num2str(AV1)]), disp(['x = ', num2str(AV2)])
%pause
 
% Asíntotas oblicuas
 
m1 = limit(f(x)/x, x, inf)  %#ok<NOPTS> % existe asintota oblicua por al derecha si la pentiende m obtenida con este límite es real.
n1 = limit(f(x)-m1*x, x, inf) %#ok<NOPTS> % n1 es la ordenada en el origen de la asíntota oblicua derecha
disp('la ecuación de la asíntota oblicua por la derecha es:')
y = m1*x+n1 %#ok<NOPTS>
 
m2 = limit(f(x)/x, x, -inf) %#ok<NOPTS> % existe asintota oblicua por al derecha si la pentiende m obtenida con este límite es real.
n2 = limit(f(x)-m1*x, x, -inf) %#ok<NOPTS> % n1 es la ordenada en el origen de la asíntota oblicua derecha
disp('la ecuación de la asíntota oblicua por la izquierda es:')
y = m2*x+n2 %#ok<NOPTS>
 
% Representación gráfica de y=f(x) con todas sus asintotas
 
ezplot(f(x), [-10, 10])
hold on;
plot([1,1], [-20,100], 'g:')
plot([3/2, 3/2], [-20, 100], 'y:')
axis([-10,10,-20,100])
v = [-10,10];
plot(v, m1*v+n1, 'r--')