function [numero, determinante] = ejemplo1(x)

    [n, m] = size(x);
    
    numero = n * m;
    
    determinante = det(x);
    
    fprintf('El numero de elementos de la matriz es: %d\n',numero)
    
    fprintf('El determinante de la matriz es: %d\n',determinante)

end