clc;
close all;

% Select the source image 
[FileName, PathName, FilterIndex] = uigetfile('.png','Please select the image');
x = imread([PathName, FileName]);

% Block DCT transform of images
x = im2double(x);
t = dctmtx(10);
y = blkproc(x, [10 10], 'P1 * x * P2', t, t');

% Split the image and expand the 10*10 image block into a 1*100 vector.
mask1 = zeros(10,10);
k5 = mask1;k5(1:5) = 1;
k10 = mask1;k10(1:10) = 1;
k20 = mask1;k20(1:20) = 1;
k100 = mask1;k100(1:100) = 1;

% Compress the image
y1 = blkproc(y,[10 10],'P1.*x',k5);
y2 = blkproc(y,[10 10],'P1.*x',k10);
y3 = blkproc(y,[10 10],'P1.*x',k20);
y4 = blkproc(y,[10 10],'P1.*x',k100);

% Reconstruct images
y11 = blkproc(y1,[10 10],'P1*x*P2',t',t);
y22 = blkproc(y2,[10 10],'P1*x*P2',t',t);
y33 = blkproc(y3,[10 10],'P1*x*P2',t',t);
y44 = blkproc(y4,[10 10],'P1*x*P2',t',t);

% Calculate the RMSE values
f1 = RMSE(x, y11);
f2 = RMSE(x, y22);
f3 = RMSE(x, y33);
f4 = RMSE(x, y44);

% Show the reconstructed images
subplot(1,5,1),imshow(x),title('Original');
subplot(1,5,2), imshow(y11),title(strcat(' top 5 coefficients-','RMSE:',num2str(f1)));
subplot(1,5,3),imshow(y22),title(strcat('top 10 coefficients-','RMSE:',num2str(f2)));
subplot(1,5,4),imshow(y33),title(strcat('top 20 coefficients-','RMSE:',num2str(f3)));
subplot(1,5,5),imshow(y44),title(strcat('top 100 coefficients-','RMSE:',num2str(f4)));
