%Ejercicio 3
A=sym([1 2 -4 -1 9; -1 -2 4 0 -5; 1 1 -1 0 3;-1 1 -5 1 -3])
RA=rref(A)
BaseFilaA=RA(1:3,:)
BaseColA=[A(:,1) A(:,2) A(:,4)] 