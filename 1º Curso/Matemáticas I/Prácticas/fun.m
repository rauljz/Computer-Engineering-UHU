function[y] = fun(x)
    if 
        x == 0;
        y = 1;
    else
        y = (exp(x) - 1)/x;
   end
end
