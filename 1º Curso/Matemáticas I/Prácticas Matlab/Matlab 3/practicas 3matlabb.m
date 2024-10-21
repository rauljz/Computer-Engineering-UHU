%% ejercicio 3.1.3
x=(pi/4):pi/100:(3*pi/4); %% f(x)=Cos(x)/x -->[pi/4, 3*pi/4]
y=cos(x)./(x);
plot(x,y)
%% Ejercicio f(x)= e.^(x.^2+1)
x=-5:0.1:5;
y=e.^(x.^2+1);
plot(x,y)
%% Ejercicio f(x)=Ln(x^2+1)
x=-5:0.1:5;
y=log(x.^2+1);
plot(x,y)
%% Ejercicio f(x)=senx),g(x)=cos(x),h(x)=tan(x);
x=-2*pi:pi/100:2*pi;
y= sin (x);
plot(x,y)
hold on
z= cos (x);
plot (x,z)
hold on
w=tan (x);
plot(x,w)
%% ejerciicioo
x=-100:1.100;
e=2.7178
e =
    2.7178
y1=x.^2;
subplot (2,2,1);plot(x,y1);

plotç(x,y1)
??? plotç(x,y1)
        |
Error: The input character is not valid in MATLAB statements or expressions.
plot(x,y1)
x=-100:1:100;
subplot(2,2,1);plot(x,y1)
??? Error using ==> plot
Vectors must be the same lengths.
y1=x.^2;
subplot(2,2,1);plot(x,y1);
e
e =
    2.7178
x=-1:0.00001:1;
y2=e.^(x.^2);
subplot(2,2,2);plot(x,y2);

