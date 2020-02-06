clc;
close all;

% Select the source image 
[FileName, PathName, FilterIndex] = uigetfile('.png','Please select the image');
img = imread([PathName, FileName]);

% Block DCT Transform
y = blkproc(img, [10, 10], 'DFT_part');

% Split the image and expand the 10*10 image block into a 1*100 vector.
mask1 = zeros(10,10);
k5 = mask1;k5(1:5) = 1;
k10 = mask1;k10(1:10) = 1;
k20 = mask1;k20(1:20) = 1;
k100 = mask1;k100(1:100) = 1;

% Compress the image
y1=blkproc(y,[10 10],'P1.*x',k5);
y2=blkproc(y,[10 10],'P1.*x',k10);
y3=blkproc(y,[10 10],'P1.*x',k20);
y4=blkproc(y,[10 10],'P1.*x',k100);

% Using inverse transform to reconstruct image
y11 = blkproc(y1, [10, 10], 'IDFT_2D');
y22 = blkproc(y2, [10, 10], 'IDFT_2D');
y33 = blkproc(y3, [10, 10], 'IDFT_2D');
y44 = blkproc(y4, [10, 10], 'IDFT_2D');

% Using absolute value to eliminate complex coefficients
y11 = abs(y11);y22 = abs(y22);y33 = abs(y33);y44 = abs(y44);

% Calculate the RMSE values
f1 = RMSE(img,y11);
f2 = RMSE(img,y22);
f3 = RMSE(img,y33);
f4 = RMSE(img,y44);

% Show the reconstructed images
subplot(1,5,1),imshow(img),title('Original');
subplot(1,5,2), imshow(uint8(y11)),title(strcat(' top 5 coefficients-','RMSE:',num2str(f1)));
subplot(1,5,3),imshow(uint8(y22)),title(strcat('top 10 coefficients-','RMSE:',num2str(f2)));
subplot(1,5,4),imshow(uint8(y33)),title(strcat('top 20 coefficients-','RMSE:',num2str(f3)));
subplot(1,5,5),imshow(uint8(y44)),title(strcat('top 100 coefficients-','RMSE:',num2str(f4)));
