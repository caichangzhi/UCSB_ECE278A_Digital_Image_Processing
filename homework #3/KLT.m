clc;
close all;

% Select the source image 
[FileName, PathName, FilterIndex] = uigetfile('.png','Please select the image');
f = imread([PathName, FileName]);

% Use K-L Transform to compress the image
f = im2double(f);
y = [];
[m, n] = size(f);

% Split the image and expand the 10*10 image block into a 1*100 vector.
% The K-L transform transformation matrix is only related to the dimension, 
% so only 100*100 transformation matrix is needed.
for i = 1:m/10
    for j = 1:n/10
        ii = (i-1)*10+1;
        jj = (j-1)*10+1;
        y_append = reshape(f(ii:ii+9, jj:jj+9), 1, 100);  % Divide the image into small pieces of 10*10
        y = [y; y_append];
    end
end

% K-L Transform
[coeff, score, latent] = pca(y);

% Extract coefficients
k100 = y*coeff;

k5 = k100;
k20 = k100;
k10 = k100;
% Keep different coefferents
k5(:,6:100) = 0;
k20(:,21:100) = 0;
k10(:,11:100) = 0;

% Inverse K-L Transform
k5_inverse = k5*coeff';
k20_inverse = k20*coeff';
k10_inverse = k10*coeff';
k100_inverse = k100*coeff';
k=1;

% Reconstruct Image
for i = 1:m/10
    for j = 1:n/10
        y1 = reshape(k5_inverse(k,1:100), 10, 10);
        y2 = reshape(k20_inverse(k,1:100), 10, 10);
        y3 = reshape(k10_inverse(k,1:100), 10, 10);
        y4 = reshape(k100_inverse(k,1:100), 10, 10);
        ii = (i-1)*10+1;
        jj = (j-1)*10+1;
        image1(ii:ii+9, jj:jj+9) = y1;
        image2(ii:ii+9, jj:jj+9) = y2;
        image3(ii:ii+9, jj:jj+9) = y3;
        image4(ii:ii+9, jj:jj+9) = y4;
        k = k+1;
    end
end

% Show the image
RMSE1 = RMSE(f, image1);
RMSE2 = RMSE(f, image2);
RMSE3 = RMSE(f, image3);
RMSE4 = RMSE(f, image4);
subplot(1,5,1),imshow(f),title('Original');
subplot(1,5,2),imshow(image1),title(strcat(' top 5 coefficients-','RMSE:',num2str(RMSE1)));
subplot(1,5,3),imshow(image2),title(strcat('top 20 coefficients-','RMSE:',num2str(RMSE2)));
subplot(1,5,4),imshow(image3),title(strcat('top 10 coefficients-','RMSE:',num2str(RMSE3)));
subplot(1,5,5),imshow(image4),title(strcat('top 100 coefficients-','RMSE:',num2str(RMSE4)));
