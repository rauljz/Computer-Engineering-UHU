function[c, err, yc, iter] = bisection(f, a, b, delta)
% Para usar esta funci´on bisection primero tenemos que haber definido la f,
% por ejemplo: >> f1(x) = sin(x) − 1/2
% Escribiremos las entradas de esta forma: >> bisection(f1, 0, 2, 0.001);
% siendo en este caso el intervalo [a, b] = [0, 2]
% y delta=0.001, la precisi´on, es decir, tres cifras decimales exactas.
% c es el cero buscado
% yc será el valor de f en c que debe ser muy pr´oximo a 0
% err es el error de la aproximaci´on de c
% iter es el n´umero de iteraciones realizadas para dar c.
ya = feval(f, a);
yb = feval(f, b);
if ya * yb > 0
     disp('No se puede aplicar el Teorema de Bolzano en este intervalo.')
   return
 end
err = b - a;
iter = 0;
    while err >= delta
        c = (a + b)/2;
        yc = feval(f, c);
            if yc == 0
                a = c;
                b = c;
            elseif yb * yc > 0
                b = c;
                yb = yc;
            else
                a = c;
                ya = yc;
            end
        err = b - a;
        iter = iter + 1;
      end
    disp('El cero es'), c
    err = abs(b - a);
    disp('El error es menor que'), err
    yc = vpa(feval(f, c), 10);
    disp('El valor de la funcion en c es'), yc
    disp('El numero de iteraciones ha sido'), iter
end