% Get the Gaussian pyramid, 
% the first parameter of the function is the input image, 
% and the second parameter is the standard deviation.
function [I512, I256, I128, I64] = GaussianPyramid(img,stdDeviation)

[m, n] = size(img);  % Get the size of image

w = fspecial('gaussian', [3 3], stdDeviation);  % Filter

I512 = imfilter(img, w);  % Gaussian filtering of the original image
I256 = imresize(imfilter(I512, w), [m/2 n/2]);  % Filter I512 and scale image size
I128 = imresize(imfilter(I256, w), [m/4 n/4]);
I64 = imresize(imfilter(I128, w), [m/8 n/8]);
