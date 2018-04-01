function A3_FirstName_LastName_SutdentNo(Index)

switch(Index)

	case 1 % Question A3.1: DSSS with known spreading sequence
        wnr = 0:0.5:5;  % from 0 to 5 with step 0.5
        hwr = 10;
        L = [10 20 30];
        sigma_x = 1;
        mean_x = 0;
        gamma = sigma_x * 10^(-hwr/20);
        mean_z = 0;
        sigma_z = gamma * 10.^(wnr/20);  % sigma_z for each wnr
        error_count = zeros(3,11);
        N = 100000;  % simulation time
        p_e = qfunc(gamma./sqrt((sigma_x^2+sigma_z.^2))); %theoretical Pe
        
        for i = 1:3  % 3 L values
            for n = 1:N  % N simulation times 
                for j = 1:11  % 11 WNR values
                    rand('seed',8);
                    s = (rand(L(i),1) > 0.5);
                    x = randn(L(i),1) .* sigma_x + mean_x;
                    z = randn(L(i),1) .* sigma_z(j) + mean_z;
                    b = ((rand() > 0.5) * 2) - 1;
                    w = b * s * gamma;
                    y = x + w;
                    v = y + z;
                    clear x;
                    clear z;
                    bhat = sign(v' * s);
                    if bhat ~= b
                        error_count(i,j) = error_count(i,j) + 1; 
                    end
                end
            end
        end
        p_emp = error_count ./ N
        plot(wnr,p_e,'g',wnr,p_emp(1,:),'r',wnr,p_emp(2,:),'y',wnr,p_emp(3,:),'b')
        xlabel('WNR')
        ylabel('P_decoding error')
        
	case 2 % Question A3.2: DSSS with unknown spreading sequence
        wnr = 0:0.5:5;
        hwr = 10;
        L = [10 20 30];
        sigma_x = 1;
        mean_x = 0;
        gamma = sigma_x * 10^(-hwr/20);
        mean_z = 0;
        sigma_z = gamma * 10.^(wnr/20);
        error_count = zeros(1,11);
        N = 100000;
        
        for n = 1:N
            for j = 1:11
                rand('seed',8);
                s = (rand(L(1),1) > 0.5);
                x = randn(L(1),1) .* sigma_x + mean_x;
                z = randn(L(1),1) .* sigma_z(j) + mean_z;
                b = ((rand() > 0.5) * 2) - 1;
                w = b * s * gamma;
                y = x + w;
                v = y + z;
                clear x;
                clear z;
                rand('seed',6);
                s2 = (rand(L(1),1) > 0.5);  % new secret key
                bhat = sign(v' * s2);
                if bhat ~= b
                    error_count(j) = error_count(j) + 1; 
                end
            end
        end
        p_emp = error_count ./ N
end