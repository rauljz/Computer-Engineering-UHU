function[a,media]=media(x)
n=length(x);
suma=sum(x);
function[a]=med(suma,n) %Calcula la MEDIA
a=suma/n;
end
fprintf('La suma de las omponentes es:')
suma
fprintf('La media es:')
media=med(suma,n)
end