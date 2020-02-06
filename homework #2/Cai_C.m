% Course: ECE 278A Digital Image Processing
% Homework #2
% Author: Changzhi Cai
% Perm Number: 9911579
% Submitted Date: 10/20/2019
% Input: A gray-scale 512x512 pixel image and Gaussian standard deviation
% Output: Gaussian and Laplacian pyrimids at resolutions 512x512 (original), 256x256, 128x128, and 64x64
% Discription: Write MATLAB code to implement Gaussian and Laplacian pyramids similar to the SIFT feature 
%              computations

%%
clear           % Clear the workspace
clc;            % Clear the command window

img = imread('hw2.tiff');       % Read the image
img = imresize(img,[512 512]);  % Resize the image to 512x512

if ndims(img) == 3       % If the input image is a color map, 
    img = rgb2gray(img); % turn it into a grayscale image
end

[I512, I256, I128, I64] = GaussianPyramid(img, 0.5);       % Calculate four levels in the GaussianPyramid
nums = 4;                                                  % Four levels
Gau = cell(nums, 1);
Gau{1} = I512; Gau{2} = I256; Gau{3} = I128; Gau{4} = I64;
for i = 1: nums
    figure;imshow(Gau{i});
end

Lapla = LaplacianPyramid(Gau);  % Generating Laplacian Pyramid Lapla
for j = 1: nums-1
    figure;imshow(Lapla{j});
end