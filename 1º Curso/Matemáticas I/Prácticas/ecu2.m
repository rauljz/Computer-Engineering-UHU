function[x1, x2] = ecu2(a, b, c)
%Para resolver la ecuaci´on de coeficientes a, b y c escribiremos la orden >> ecu2(a, b, c);
Delta = b^2 -4*a*c; %Se calcula el discriminante
if Delta < 0
    disp('No hay soluciones reales')
elseif Delta > 0
    x1 = (-b - sqrt(Delta))/(2 * a);
    x2 = (-b + sqrt(Delta))/(2 * a);
    disp('Hay dos soluciones reales'), x1, x2
else
    x1 = -b/(2*a);
    x2 = -b/(2*a);
    disp('Solo hay una solucion real'), x1, x2
   end
end

