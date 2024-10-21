%Ejercicio 1
%Hallamos una base de H+K
H=sym([2 -1 0 -1; 3 2 -1 0])
K=sym([1 -4 1 -2; 0 0 1 -1])
HmK=[H;K]
ReHmK=rref(HmK)
BaseHmK=ReHmK(1:3,:)

%Ejercicio 2
syms x y z t
A=transpose([x y z t;1 0 -3 1;2 2 -1 5])
E1=kf(2,1/A(2,3),4)*sumaf(3,1,-A(3,2),4);A1=E1*A
E2=sumaf(3,2,-A1(3,3),4)*sumaf(4,2,-A1(4,3),4);A2=E2*A1
Ecu=A2(3:4,1)