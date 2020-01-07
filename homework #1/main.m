% Course: ECE 278A Digital Image Processing
% Homework #1
% Author: Changzhi Cai
% Perm Number: 9911579
% Submitted Date: 10/06/2019
% Input: A binary image, which is a matrix consisting of either 0s or 1s
% Output: Corresponding distance transform using the manhattan distance
% Discription: Consider a binary image - an image consisting of either 0s or 1s. Assume the 1s in the image
%              represent objects and 0s represent the background. The distance transform assigns to each pixel
%              in the image the distance to the closest object pixel. Thus all pixels belonging to the object 
%              will have an assigned distance equal to zero. Let us assume that we are interested in computing
%              the distance transform using the manhattan distance

%%
clear           % Clear the workspace
clc;            % Clear the command window

D = importdata('custom.txt');    % Import the custom binary image from .txt file
% load('pattern1', 'D');         % Load the example pattern1
% load('pattern2', 'D');         % Load the example pattern2
disp('Input image')              % Discription of the input
disp(D)                          % Output the imported matrix 

[m, n] = size(D);                % Get the size of the image
transImage = zeros(m, n);        % Generate the same zero matrix as the image size

for i = 1: m                                           % Traversing each line
    for j = 1: n                                       % Traversing every element in each line
        T = [];                                        % Create a matrix T to store the distances
        for i1 = 1: m                                  % Based on this element, search the nearest '1'
            for j1 = 1: n
                if D(i1, j1) == 1                      % If we find a '1'
                    image = abs(i1 - i) + abs(j1 - j); % Calculate the Manhattan distance between these 2 elements
                    T = [T image];                     % Store the distance between all '1s' into the T matrix
                end
            end                                          
        end                                            % End of searching
        Tm = min(T);                                   % Find the nearest Manhattan distance from a object
        transImage(i, j) = Tm;                         % Store the distance into the output matrix 
    end                                                % End of traversing this line
end                                                    % End of traversing the whole matrix

% save('pattern1_out', 'transImage');          % Save the transformed matrix of pattern1
% save('pattern2_out', 'transImage');          % Save the transformed matrix of pattern2
save('custom_out', 'transImage');              % Save the transformed matrix from custom input       

disp('Manhattan distance transform')           % Discription of the output
disp(transImage)                               % Output the transformed matrix 
 