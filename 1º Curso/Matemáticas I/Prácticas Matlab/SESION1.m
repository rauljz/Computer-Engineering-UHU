%% Ejercicio 1.1.1.
sqrt(((3^2)+1)-sin(pi))
e=exp(1);
(e^(2^2+1))+(3/2)
log3(9)+log(e)+log10(0.1)
((3^2)+5)/((1/2)+2)
nthroot((sqrt(3)+2), 5)
%% Ejercicio 1.2.2.
x=linspace(3,9,15) % Se utiliza cuando sabemos donde empieza y acaba y cuantos coponentes queremos.
y=15:3:20          % Se utiliza cuando sabemos donde empieza y acaba y de cuanto es cada salto
%% Ejercicio 1.2.3.
x=1:10;
y=([1,3,7,5])
y=x(6:3:10)
y=x(3:6)
%% Ejercicio 1.2.1.
x=linspace(3,12,10)
x*2
y=(3:12)
log10(y)
x.*y
x*y'
%% Ejercicio 1.3.2.
solve('(x^3)-(3*x^2)+2*x+3=0')
vpa(ans,5)
[x,y]=solve('(x^2)+(2*x)-y=0','x-(2*y)=3')
vpa(ans,5)
vpa(y,5)