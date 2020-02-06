% Course: ECE 278A Digital Image Processing
% Homework #4 5a)-5c)
% Author: Changzhi Cai
% Perm Number: 9911579
% Submitted Date: 11/24/2019

%%
clc;
close all;

% Select the source image 
[FileName, PathName, FilterIndex] = uigetfile('.png','Please select the image');
x = imread([PathName, FileName]);

% Block DCT transform of images
x = im2double(x);
t = dctmtx(8);
y = blkproc(x, [8 8], 'P1 * x * P2', t, t');

% Split the image and expand the 8*8 image block into a 1*64 vector.
mask1 = zeros(8,8);
k4 = mask1;k4(1:4) = 1;
k16 = mask1;k16(1:16) = 1;
k32 = mask1;k32(1:32) = 1;
k64 = mask1;k64(1:64) = 1;

% Compress the image
y1 = blkproc(y,[8 8],'P1.*x',k4);
y2 = blkproc(y,[8 8],'P1.*x',k16);
y3 = blkproc(y,[8 8],'P1.*x',k32);
y4 = blkproc(y,[8 8],'P1.*x',k64);

% Reconstruct images
y11 = blkproc(y1,[8 8],'P1*x*P2',t',t);
y22 = blkproc(y2,[8 8],'P1*x*P2',t',t);
y33 = blkproc(y3,[8 8],'P1*x*P2',t',t);
y44 = blkproc(y4,[8 8],'P1*x*P2',t',t);

% Calculate the RMSE values
f1 = RMSE(x, y11);
f2 = RMSE(x, y22);
f3 = RMSE(x, y33);
f4 = RMSE(x, y44);

% Show the reconstructed images
subplot(1,5,1),imshow(x),title('Original');
subplot(1,5,2), imshow(y11),title(strcat(' top 4 coefficients-','RMSE:',num2str(f1)));
subplot(1,5,3),imshow(y22),title(strcat('top 16 coefficients-','RMSE:',num2str(f2)));
subplot(1,5,4),imshow(y33),title(strcat('top 32 coefficients-','RMSE:',num2str(f3)));
subplot(1,5,5),imshow(y44),title(strcat('top 64 coefficients-','RMSE:',num2str(f4)));