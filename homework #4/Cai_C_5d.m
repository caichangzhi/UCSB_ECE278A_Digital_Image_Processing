% Course: ECE 278A Digital Image Processing
% Homework #4 5d)
% Author: Changzhi Cai
% Perm Number: 9911579
% Submitted Date: 11/24/2019

%%
clc;
close all;

% Read image and get the DCT matrix
I = imread('p1.png');
I = imresize(I,[512 512]);
I = im2double(I);
T = dctmtx(8);

% DCT transformation
B = blkproc(I,[8 8],'P1*x*P2',T,T');

% Quantization matrix
Q = 1;
q_mat =  Q*[16 11 10 16 24 40 51 61; 
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56; 
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];
% Quantization process
c = @(block_struct) (block_struct.data) ./ q_mat;        
B2 = blockproc(B,[8 8],c);
% Complete the DCT quantization

% Begin DC coefficients prediction
temp = B2(1,1);
for j = 1:8:512
   if j > 1
       temp0 = temp;
       temp = B2(1,j);
       B2(1,j) = B2(1,j)-temp0;
   end
end
temp0 = temp;
for i = 9:8:512
   for j = 1:8:512
        temp0 = temp;
        temp = B2(i,j);
        B2(i,j) = B2(i,j)-temp0;
   end
end
  
% Zigzag order
order = [
 0  1  5  6 14 15 27 28
 2  4  7 13 16 26 29 42
 3  8 12 17 25 30 41 43
 9 11 18 24 31 40 44 53
10 19 23 32 39 45 52 54
20 22 33 38 46 51 55 60
21 34 37 47 50 56 59 61
35 36 48 49 57 58 62 63
];

aa = @(block_struct)  sortrows( [reshape((block_struct.data), [], 1)  reshape(order, [], 1)], 2);
B3 = blockproc(B2,[8 8],aa);

% Zigzag scan
 runl = 0;
 y = 1;
 z = 1;
 s = 1;
for j = 1:2:128
   for i = 1:1:4096
        test(z,1) = B3(i,j);
        h(z,1) = ceil(test(z,1));
         if test(z,1) == 0
             runl = runl+1;
             z = z+1;
         else 
             run(y,1) = runl;
             if test(z,1) <= 1 && test(z,1) >= -1
                s = 1;
             elseif test(z,1)<=-2 &&test(z,1)>= -3 || test(z,1)>=2 && test(z,1) <= 3
                s = 2;
             elseif test(z,1)<=-4 &&test(z,1)>= -7 || test(z,1)>=4 && test(z,1) <= 7
                s = 3;
             elseif test(z,1)<=-8 &&test(z,1)>= -15 || test(z,1)>=8 && test(z,1) <= 15
                s = 4;
             elseif test(z,1)<=-16 && test(z,1)>=-31  || test(z,1)>=16 && test(z,1) <=31
                s = 5;
             elseif test(z,1)<=-32 && test(z,1)>=-63  || test(z,1)>=32 && test(z,1) <=63
                s = 6;
             elseif test(z,1)<=-64 && test(z,1)>=-127  || test(z,1)>=64 && test(z,1) <=127
                s = 7;
             elseif test(z,1)<=-128 && test(z,1)>=-255  || test(z,1)>=128 && test(z,1) <=255
                s = 8;
             elseif test(z,1)<=-256 && test(z,1)>=-511  || test(z,1)>=256 && test(z,1) <=511
                s = 9;
             elseif test(z,1)<=-512  || test(z,1)>=512 
                s = 10;
             end
             run(y,2) = s;
             run(y,3) = h(z,1);
             y = y+1;
             z = z+1;
             runl = 0;
        end
    end
end
% End of Zigzag scan
         
% Huffman encoding
sum1 = 0;
[M,N] = size(run);  
symbols = -100:100;
for i = -100:100
      P(i+101) = length(find(abs(run) == i))/(M*N);
      sum1 = sum1 + P(i+101);  
end
dict = huffmandict(symbols,P);
run2 = reshape(run,1,M*N);
comp = huffmanenco(run2,dict);
% End of Huffman encoding

fid = fopen('image.myJPEG','wb') ;
fwrite(fid,comp,'int');
fclose(fid);
dsig = huffmandeco(comp,dict);
a = 0;
b = 0;
cout = [];
 
% Huffman decoding
for L = 1:2:128   
  for k = 1:64:4096
    j = 1;
    in = [];
   for i = 0:1:63
     in(j,1) = B3((i+k),L);
     j = j+1;
   end
tot_elem = length(in);

% Initialize the output matrix
out = zeros(8,8);
 
cur_row = 1;
cur_col = 1;
cur_index = 1;
while cur_index <= tot_elem 
    if cur_row == 1 && mod(cur_row+cur_col,2) == 0 && cur_col ~= 8
        out(cur_row,cur_col) = in(cur_index);
        cur_col = cur_col+1;                         % Move right at the top
        cur_index = cur_index+1;      
    elseif cur_row == 8 && mod(cur_row+cur_col,2) ~= 0 && cur_col ~= 8
        out(cur_row,cur_col) = in(cur_index);
        cur_col = cur_col+1;                         % Move right at the bottom
        cur_index = cur_index+1;       
    elseif cur_col == 1 && mod(cur_row+cur_col,2) ~= 0 && cur_row ~= 8
        out(cur_row,cur_col) = in(cur_index);
        cur_row = cur_row+1;                         % Move down at the left
        cur_index = cur_index+1;       
    elseif cur_col == 8 && mod(cur_row+cur_col,2) == 0 && cur_row ~= 8
        out(cur_row,cur_col) = in(cur_index);
        cur_row = cur_row+1;                         % Move down at the right
        cur_index = cur_index+1;       
    elseif cur_col ~= 1 && cur_row ~= 8 && mod(cur_row+cur_col,2) ~= 0
        out(cur_row,cur_col) = in(cur_index);
        cur_row = cur_row+1;      
        cur_col = cur_col-1;                         % Move diagonally left down
        cur_index = cur_index+1;     
    elseif cur_row ~= 1 && cur_col ~= 8 && mod(cur_row+cur_col,2) == 0
        out(cur_row,cur_col) = in(cur_index);
        cur_row = cur_row-1;
        cur_col = cur_col+1;                         % Move diagonally right up
        cur_index=cur_index+1;    
    elseif cur_index == tot_elem                     % Input the bottom right element
        out(end) = in(end);                          % End of the operation
        break                                        % Terminate the operation
    end  
end

for i = 1:1:8          
    for j = 1:1:8      
      cout(a+i,j+b) = out(i,j);
    end
end

a = a+8;
if a == 512
    b = b+8;
    a = 0;
end
  end
end
% Inverse Zigzag end

temp = cout(1,1);
for j = 9:8:512
     cout(1,j)= cout(1,j)+temp;

     temp = cout(1,j);     
end
for i = 9:8:512
  for j = 1:8:512
      cout(i,j) = cout(i,j)+temp;
      temp = cout(i,j);
  end
end  
% Recontruct DC coefficients end

Q2 = 1;
q_mtx = Q2*[16 11 10 16 24 40 51 61; 
        12 12 14 19 26 58 60 55;
        14 13 16 24 40 57 69 56; 
        14 17 22 29 51 87 80 62;
        18 22 37 56 68 109 103 77;
        24 35 55 64 81 104 113 92;
        49 64 78 87 103 121 120 101;
        72 92 95 98 112 100 103 99];
c = @(block_struct) (block_struct.data) .* q_mtx;        
B5 = blockproc(cout,[8 8],c);
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B5,[8 8],invdct);
I = imresize(I,[120 160]);
I2 = imresize(I2,[120 160]);
imwrite(I2,'p1_result.jpeg');

% Calculate and compare RMSE
f1 = RMSE(I,I2);
subplot(1,2,1),imshow(I),title('Original');
subplot(1,2,2),imshow(I2),title(strcat('encoder-decoder-','RMSE:',num2str(f1)));