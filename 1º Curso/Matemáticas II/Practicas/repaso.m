H=sym([2 -1 0 -1; 3 2 -1 0])
K=sym([1 -4 1 -2; 0 0 1 -1])
HmK=[H;K]
ReHmK=rref(HmK)