%% EXAMEN 14 FEB
%% Ejercicio 1
x=linspace(0,pi,1000000);
f=(x-pi).*cos(x);
g=sin(x-pi);
plot(x,f,'b',x,g,'r')
%% Ejercicio 2
syms x
f=abs(x-1)/(x^2-1);
limit(f,x,1)            % LÍMITE EN 1
a=limit(f,x,1,'right')  % LÍMITE EN 1, POR LA DERECHA
b=limit(f,x,1,'left')   % LÍMITE EN 1, POR LA IZQUIERDA
if(a==b)                % Sí ambos límites coinciden es continua, si no coinciende no
    fprintf('La funcion ES CONTINUA')
else fprintf('La funcion NO ES CONTINUA')
end
%% Ejercicio 3
% REVISAR
e=exp(1);
syms x
f=e^x^2/(x^2+1);
d1=diff((e^x^2/(x^2+1)),x);
pretty(d1)
w=ans;
% 3 B
solve ('ans=0')
%  -----
d2=diff((e^x^2/(x^2+1)),2);
if (d2>0 && x==w)
    fprintf('Es un minimo')
elseif fprintf('Es un MÁXIMO')
elseif fprintf('ES UN PTO DE INFLEXIÓN')
end



%% Ejercicio 4
syms x
g=((1+x)^(1/3))
taylor(g,0,4)
%%B (comprobad lo que he hecho del taylorme.m)
subs(g,x,0.15)
taylor(g,0,4)

%% EJERCICIO 5
% A
solve ('x^(3)-(7*x)+6=0')
% B [sí va ;)]
x=linspace(-4,3);
y=x.^(3)-(7*x)+6;
plot(x,y);
% C
