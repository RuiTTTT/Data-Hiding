function F = myoverlay(C, M)
%overlay function for question 1.1
F = zeros(640,640);
for i = 1:640
    for j = 1:640
        if M(i,j) < 0.5
            F(i,j) = 2 * M(i,j) * C(i,j);
        else
            F(i,j) = 1 - 2 * (1-M(i,j)) * (1-C(i,j));
        end
    end
end
        