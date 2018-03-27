function F = myfilter(M, v)
%filter function
M_norm = M ./ 255; %normalisation
vec_M = M_norm(:);
tran = polyval(v,vec_M);
F = reshape(tran,640,640);
