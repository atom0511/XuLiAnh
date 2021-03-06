%% Segmenting and Image using Thresholding 
% This example uses level based thresholding to segment the image

% Copyright 2014 The MathWorks, Inc.

%% Read in image
I = imread('objets1.jpg');
imshow(I);
%%  Convert to grayscale image
Igray = rgb2gray(I);
imshow(Igray);

 %% Problem: illumination doesn't allow for easy segmentation
level = 0.47;
Ithresh = imbinarize(Igray,level);
imshowpair(I, Ithresh, 'montage');