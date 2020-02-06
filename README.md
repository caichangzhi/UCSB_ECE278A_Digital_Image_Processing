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
Your code should compute four levels in the pyramid, at resolutions 512x512 (original), 256x256, 128x128, and
64x64. Your report should include these pictures at the corresponding resolutions. Include your MATLAB
code print-out in your report also as text. Your submitted code should be self-contained, should take the image
file name as input, together with Gaussian standard deviation as a parameter. For the Gaussian pyramid, it
should construct the 4 levels as above. For example,
[I512, I256, I128, I64] = GaussianPyramid (I, stdDeviation)
Using the above Gaussian pyramid, you can also construct the corresponding Laplacian pyramid. Construct
the Laplacian pyramid at the four resolutions as noted above. For example, to construct the Laplacian pyramid
at resolution 512x512, you take the Gaussian smoothed image at resolution 512x512, and subtract it from the
original 512x512 image. Include the images and code in your report similar to Gaussian pyramid.
Take any gray-scale 512x512 pixel image of your choice to construct the Gaussian and Laplacian pyramids.
