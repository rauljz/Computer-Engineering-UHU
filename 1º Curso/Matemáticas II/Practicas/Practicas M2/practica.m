%Ejercicio 1

A=[1,2,3; 4,2,8; -5,7,-1]

%Ejercicio 2

v1=[1,2,3]
v2=[1;4;-5]

%Ejercicio 3

e=5

%Ejercicio 4

%Para crear una matriz nula usamos el comando >>zeros(mxn)

z1=zeros(2,3)
z2=zeros(2)

%Ejercicio 5

%Para crear una matriz de unos usamos el comando >>ones(m,n)

z3=ones(3,2)
z4=ones(6)

%Ejercicio 6

%Para crear una matriz identidad usamos el comando >>eye(m,n)

a1=eye(3,2)
a2=eye(4)
a3=eye(25,25)

%Ejercicio 7

%Para generar matrices aleatorias usamos el comando >>rand

r1=rand(5,3)
r2=rand(3)

%Ejercicio 8

D=[1,2;3,4]
F=[D,zeros(2);ones(2),eye(2)]

%Ejercicio 9 

%Para determinar las dimensiones usamos >>size()
%Para determinar la dimension mayor usamos >>length()

size(F)
length(F)

%Ejercicio 10

Y=[20000,80000,160000;50000,10000,400000]
Y.'

%Ejercicio 11

A4=A*e
A3=A/e
A2=A+e
A1=A-e

%Ejercicio 12

P=[1,2,3;4,5,6;7,8,9]
Q=[1,4,7;2,5,8;3,6,9]

P1=P+Q
P2=P-Q
P3=P*Q
P4=Q*P
