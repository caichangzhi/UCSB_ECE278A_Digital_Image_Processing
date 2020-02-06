# UCSB_ECE278A_Digital_Image_Processing

This is my coursework of ECE278A, all copyrights reserved by Changzhi Cai.

Introduction:
-------------
Title: Digital Image Processing

Quarter: Fall 2019

Instructor: Prof B.S.Manjunath

Contact me: caichangzhi97@gmail.com

Environment:
------------
[MATLAB 2019b](https://www.mathworks.com/products/new_products/latest_features.html?s_tid=hp_release_2019b)

Homework #1: Distance Transform
------------
Consider a binary image - an image consisting of either 0s or 1s. Assume the 1s in the image represent objects and 0s represent the background. The distance transform assigns to each pixel in the image the distance to the closest object pixel. Thus all pixels belonging to the object will have an assigned distance equal to zero. Let us assume that we are interested in computing the distance transform using the manhattan distance.
- Outline an algorithm that would compute such a transform (this should be in the form of a pseudocode or steps that one can easily follow for a computer implementation.) Include this as part of your written sumission, together with 2 example 8x8 patterns input and their corresponding distance transform.
- Implement the above transform in Matlab which can take patterns of arbitrary matrix dimensions and output the corresponding transforms. 
- Include the 2 patterns (as .MAT files) and your computed corresponding outputs.
- Make sure we are able to run the code with the inputs and get the desired output.

Homework #2: Image Pyramids
-------------
Write MATLAB code to implement Gaussian and Laplacian pyramids similar to the SIFT feature computations
that we will discuss in class soon. You can only use standard MATLAB function calls (e.g., Gaussian smoothing,
convolution, etc). I will go over this problem in detail during the lecture.
- Your code should compute four levels in the pyramid, at resolutions 512x512 (original), 256x256, 128x128, and
64x64. Your report should include these pictures at the corresponding resolutions. Include your MATLAB
code print-out in your report also as text. Your submitted code should be self-contained, should take the image
file name as input, together with Gaussian standard deviation as a parameter. For the Gaussian pyramid, it
should construct the 4 levels as above. 
- For example,[I512, I256, I128, I64] = GaussianPyramid (I, stdDeviation)
- Using the above Gaussian pyramid, you can also construct the corresponding Laplacian pyramid. Construct
the Laplacian pyramid at the four resolutions as noted above. For example, to construct the Laplacian pyramid
at resolution 512x512, you take the Gaussian smoothed image at resolution 512x512, and subtract it from the
original 512x512 image. Include the images and code in your report similar to Gaussian pyramid.
- Take any gray-scale 512x512 pixel image of your choice to construct the Gaussian and Laplacian pyramids.

Homework #3: K-L Transform
-------------
You will be provided 2 sets of 20 images each in the raw format (SET1 and SET2). You will compute
the KLT basis images using SET1 images only, buty you will provide the results (RMSE vs Number
of Coefficients kept graphs) for both SET1 and SET2.
- Implement each step of the Karhunen-Loeve Transform using SET1. You may follow the code found
here (but you can use any other resource or write your own code, it should be few lines in MATLAB):
http://www.mathworks.com/matlabcentral/fileexchange/6995-karhunen-loeve-decompositionfor-statistical-recognition-and-detection
but please make sure you understand each step clearly.
- Reconstruct each of the images in SET1 and SET2 using all of the KLT basis computed as in the
above step. Then reconstruct the image back keeping only (i) 100, (ii) 20, (iii) 10, and (iv) 5 top KLT
coefficients. For each of these cases, include in your report an example of the reconstructed image and
the root mean-squared error for the entire collection. Also include the code you used in generating the
reconstructed images from the specified number of coefficients, and adequately comment your code so
as to explain clearly the steps required to arrive at the reconstructed images.
- Repeat the above step,replacing the KLT with the standard 2D DFT and 2D DCT. Here you use the
magnitiude of the coefficients to pick the top M number of coefficients as specified. As we discussed
in class, for the DFT case, make sure that you pay attention to conjugate symmetry property of the
Fourier transform coefficients. For example, the top 100 coefficients for Fourier transform will include
approximately 50 complex coefficients. Give reconstruction examples for the same image used for the
above KLT case. Your report should include 2 tables, one for SET1 and the other for SET2, where
the columns correspond to the three different transforms, and the rows correspond to the number of
coefficients used in the reconstruction, and the table entries should be the RMS error in reconstructing
the signal.
