% PUNTOS CRITICOS
syms t x
g=int(t^2+2*t,-1,x+1);
dg=diff(g)

gx=diff(dg,x);
disp('Puntos críticos')
[a]=solve(gx)
ezplot(dg)