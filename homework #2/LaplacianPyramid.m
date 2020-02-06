function Lapla = LaplacianPyramid(Gau)
nums = 4;
% The highest level of the Laplacian pyramid 
% is equal to the highest level of the Gaussian pyramid I64
Lapla = cell(nums-1, 1);
w = fspecial('gaussian', [3 3], 0.5);

for index = nums-1:-1:1                            % Get the residual into the Laplacian pyramid
    temp = imresize(Gau{index+1}, 2, 'bilinear');  % Upsampling
    temp = imfilter(temp, w);                      % Gaussian blur
    Lapla{index} = Gau{index} - temp;
end


