function A1(Index)

switch(Index)

	case 1 % Question A1.1: Image Filters
        I = double(imread('briselames.png'));
        imshow(uint8(I));
        pause;
        IR = I(:,:,1);
        IG = I(:,:,2);
        IB = I(:,:,3);
        pr = [-0.1659 0.3726 0.5864 0.0927];
        pg = [9.1383 -25.1677 21.1906 -4.5517 0.3888 -0.0087];
        R = myfilter(IR, pr);
        G = myfilter(IG, pg);
        B = myfilter(IB, pg);
        I_F = zeros(640,640,3);
        I_F(:,:,1) = R;
        I_F(:,:,2) = G;
        I_F(:,:,3) = B;
        imshow(I_F);
        pause;
        
        C_over = zeros(640,640);
        for i = 1:640
            for j = 1:640
                dist = ((i - 320)^2+(j - 320)^2)^.5 / 640;
                if(dist < (1/3))
                    C_over(i,j) = 0.5;
                elseif(dist <= (2/3))
                    C_over(i,j) = (1 + cos(3*pi* (dist - 1/3)) ) / 4;
                else C_over(i,j) = 0;
                end
            end
        end
        imshow(C_over);
        pause;
        
        I_over = zeros(640,640,3);
        I_over(:,:,1) = myoverlay(C_over, R);
        I_over(:,:,2) = myoverlay(C_over, G);
        I_over(:,:,3) = myoverlay(C_over, B);
        imshow(I_over);
        
	case 2 % Question A1.2: Block Transforms
        Image = double(imread('lena.png'));
        T_DCT = dctmtx(8);
        DCT_tran = @(block) (T_DCT * block.data * T_DCT');
        Image_DCT = blockproc(Image, [8,8], DCT_tran);
        Image_DCT(1:8,1:8)
        min1 = min(Image_DCT);
        min1 = min(min1) %get the range of the first matrix
        max1 = max(Image_DCT);
        max1 = max(max1)
        Image2 = Image - 128;
        Image2_DCT = blockproc(Image2, [8,8], DCT_tran);
        Image2_DCT(1:8,1:8)
        min2 = min(Image2_DCT); %get the range of the second matrix
        min2 = min(min2)
        max2 = max(Image2_DCT);
        max2 = max(max2)
        
        
	case 3 % Question A1.3: Quantization
        Image = double(imread('lena.png'));
        Image = Image - 128;
        T_DCT = dctmtx(8);
        DCT_tran = @(block) (T_DCT * block.data * T_DCT');
        Image_DCT = blockproc(Image, [8,8], DCT_tran);
        Image_DCT(1:8,1:8)
        FUN = @(block)(quantize_dct(block.data,20));
        I_DCT = blockproc(Image_DCT, [8 8], FUN);
        I_DCT(1:8,9:16)
        histogram(I_DCT(1:8,9:16));
        %min1 = min(I_DCT);
        %min1 = min(min1)
        %max1 = max(I_DCT);
        %max1 = max(max1)
        
        
	case 4 % Question A1.4: Zigzag Reordering
        Image = double(imread('lena.png'));
        Image = Image - 128;
        T_DCT = dctmtx(8);
        DCT_tran = @(block) (T_DCT * block.data * T_DCT');
        Image_DCT = blockproc(Image, [8,8], DCT_tran);
        FUN = @(block)(quantize_dct(block.data,100));
        I_DCT = blockproc(Image_DCT, [8 8], FUN);
        I_DCT(1:8,17:24);
        zigzag = @(block2)(zigzag_reorder(block2.data));
        Z = blockproc(I_DCT, [8 8], zigzag);
        Z(1,[1 65 129 193 257])
        Z(1:8)
        zero_num = numel(Z(1:8, 1:8)) - find(Z(1:8, 1:8),1,'last')
        
	case 5 % Question A1.5: DPCM on DC component
        Image = double(imread('lena.png'));
        Image = Image - 128;
        T_DCT = dctmtx(8);
        DCT_tran = @(block) (T_DCT * block.data * T_DCT');
        Image_DCT = blockproc(Image, [8,8], DCT_tran);
        FUN = @(block)(quantize_dct(block.data,100));
        I_DCT = blockproc(Image_DCT, [8 8], FUN);
        DC = @(block)(block.data(1));
        dc = blockproc(I_DCT, [8 8], DC);
        dc = reshape(dc, 1, []);
        histogram(dc);
        pause;
        for i = 2:1024
            dc1(i) = dc(i) - dc(i-1);
        end
        histogram(dc1);
        
	case 6 % Question A1.6: Evaluation

end