% Area, ejes abscisas, 0<=x<=1
syms x;
f=4*x^4+7*x^3-9*x^2-x+1;
int(f,0,1)
% Representación
x=linspace(0,1,10000);
f=4*x.^4+7*x.^3-9*x.^2-x+1;
plot(x,f)
%Puntos de corte
solve('4*x^4+7*x^3-9*x^2-x+1=0')
