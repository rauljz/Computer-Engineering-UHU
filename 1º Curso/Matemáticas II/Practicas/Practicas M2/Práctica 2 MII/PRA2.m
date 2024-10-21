%Ejercicio 2
%Paso 1
A=[ 0 0 2 10 1 -1; 2 4 1 1 -2 -12;1 2 -1 -7 0 7;2 4 0 -4 1 13]
%Paso 2
E1=eye(4)
E1([1 3],:)=E1([3 1],:)%indico primero identidad y luego operaciones
A1=E1*A
%Paso 3
E2=eye(4); E2(2,:)=(1/2)*E2(2,:)
A2=E2*A1
%Paso 4
E3=eye(4); E3(2,:)= E3(2,:)-E3(1,:)
A3=E3*A2
%Paso 5
E4=eye(4); E4(4,:)= E4(4,:)-2*E4(1,:)
A4=E4*A3
%Paso 6
E5=eye(4); E5(2,:)=(2/3)*E5(2,:)
A5=E5*A4
%Paso 7
E6=eye(4); E6(1,:)=E6(1,:)+1*E6(2,:)
A6=E6*A5
%Paso 8
E7=eye(4); E7(3,:)=E7(3,:)-2*E7(2,:)
A7=E7*A6
%Paso 9
E8=eye(4); E8(4,:)=E8(4,:)-2*E8(2,:)
A8=E8*A7
%Paso 10
E9=eye(4); E9(3,:)=(3/7)*E9(3,:)
A9=E9*A8
%Paso 11
E10=eye(4); E10(1,:)=E10(1,:)+(2/3)*E10(3,:)
A10=E10*A9
%Paso 12
E11=eye(4); E11(2,:)=E11(2,:)+(2/3)*E11(3,:)
A11=E11*A10
%Paso 13
E12=eye(4);E12(4,:)=E12(4,:)-(7/3)*E12(3,:)
A12=E12*A11

%Ejercicio 3

rref(A)

%Ejercicio 4

A=[1 -1 0 1;2 -1 1 1; 2 1 4 -1;0 -1 1 0];AI=[A eye(4)]
%escribo en forma [AI]
%Transformaciones elementales
E1=eye(4); E1(1,:)=(2)*E1(1,:);AI1=E1*AI
E2=eye(4); E2(2,:)=E2(2,:)-E2(1,:); AI2=E2*AI1
E3=eye(4); E3(3,:)=E3(3,:)-E3(1,:); AI3=E3*AI2
E4=eye(4); E4(1,:)=(1/2)*E4(1,:); AI4=E4*AI3
E5=eye(4); E5(1,:)=E5(2,:)+E5(1,:); AI5=E5*AI4
E6=eye(4); E6(3,:)=E6(3,:)-(3)*E6(2,:); AI6=E6*AI5
E7=eye(4); E7(4,:)=E7(4,:)+E7(2,:); AI7=E7*AI6
E8=eye(4); E8(1,:)=E8(1,:)-E8(3,:); AI8=E8*AI7
E9=eye(4); E9(2,:)=E9(2,:)-E9(3,:); AI9=E9*AI8
E10=eye(4); E10(4,:)=E10(4,:)-(2)*E10(3,:); AI10=E10*AI9
E11=eye(4); E11(2,:)=E11(4,:)-E11(2,:); AI11=E11*AI10
E12=eye(4); E12(2,:)=(-1)*E12(2,:); AI12=E11*AI11
E13=eye(4); E13(4,:)=(-1)*E13(4,:); AI13=E13*AI12

%Lo que quiero que me quede la respuesta desde la columna

AINV=AI13(:,5:8)

%Compruebo que esta bien

A*Ainv

%Para comprobar 

inv(A)

