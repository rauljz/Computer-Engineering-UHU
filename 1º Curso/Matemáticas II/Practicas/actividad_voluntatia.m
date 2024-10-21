A=[0.304 0.061 0.061 0.061 0.061 0 0; 0.166 0.166 0 0 0 0 0; 0.071 0.071 0.141 0 0 0 0; 0 0.035 0.035 0.105 0.035 0 0; 0.045 0 0.045 0.045 0.179 0.045 0; 0.023 0 0 0 0.023 0.45 0; 0 0 0 0 0.061 0 0.061]
%Como poemos observar web mas influyente es la 1, ya que es la que mayor
%conexiones tiene y la segunda mas influyente seria la 5.

% A*X=X -> A*X-X=I -> (A-I)^-1 * (A-I)*X = (A-I)^-1 * I -> X = 8A-I)^-1 * I
I=eye(7);
B=A-I
X=inv(B)