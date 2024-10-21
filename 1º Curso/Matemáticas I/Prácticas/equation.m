function [x1, x2] = ecu2(x^2-4*x-5)
>>ecu2(x^2-4*x-5);
Delta = ((-4*x)^2)-4*x^2*(-5);
    if Delta <0
        disp('No hay soluciones reales')
    elseif Delta > 0
        x1= (4*x - (--sqrt(Delta))/(2*x^2);
        x2= (4*x + (--sqrt(Delta))/(2*x^2);
        disp('hay dos soluciones reales'), x1, x2
    else 
        x1 = 4*x/(2*x^2);
        x1 = 4*x/(2*x^2);
        disp ('solo hay una solucion real'), x1, x2
    end
end


        
end


