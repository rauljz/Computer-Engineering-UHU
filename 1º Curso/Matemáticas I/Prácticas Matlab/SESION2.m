%% Ejercicio 3.1.1.
a=[1,3,2,1];
b=[1,2,3,1];
plot(x,y)
%% Ejercicio 3.1.2.
x=-2*pi:pi/100:2*pi;
y=x.*sin(x);
plot(x,y)
%% Ejercicio 3.1.3.
% f(x)=cos(x)/x, x [pi/4,3pi/4]
x=linspace((pi/4),(3*pi/4));
y=cos(x)./x;
plot(x,y)
% f(x)=e^(x^(2)+1), x [-5,5]
x=linspace(-5,5);
e=exp(1);
y=e.^(x.^(2)+1);
plot(x,y)
% f(x)=ln(x^2+1), x [-5,5]
x=linspace(-5,5);
y=log(x.^(2)+1);
plot(x,y)
%% Ejercio 3.1.4
% intervalo [0,3]
% f(x)=x^2+3x
% g(x)=e^x
x=0:0.01:3;
y=x.^(2)+3*x;
z=exp(x);
plot(x,y,x,z)
%% Ejercicio 3.1.5
% f(x)=sen(x)
% g(x)=cos(x)
% h(x)=tan(x)
% intervalo [-2pi, 2pi]
x=linspace(-2*pi, 2*pi);
f=sin(x);
g=cos(x);
h=tan(x);
plot(x,f,x,g,x,h)