function C = quantize_dct(B, gamma)
% the function to perform quantization of 8*8 block
Q = [16 11 10 16 24 40 51 61
            12 12 14 19 26 58 60 55
            14 13 16 24 40 57 69 56 
            14 17 22 29 51 87 80 62
            18 22 37 56 68 109 103 77
            24 35 55 64 81 104 113 92
            49 64 78 87 103 121 120 101
            72 92 95 98 112 100 103 99];

if gamma < 50
    alpha = 5000 / gamma;
elseif (gamma >= 50) && (gamma <= 99)
    alpha = 200 - 2*gamma;
else alpha = 1;
end

Q_qual = zeros(8,8);
for i = 1:8
    for j = 1:8
        Q_qual(i,j) = round((alpha * Q(i,j) + 50) / 100);
    end
end
C = round(B./Q_qual);

