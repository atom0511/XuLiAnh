%get image
img1=imread('image3.png');
whileBg = imread('whileBg.png');
figure
imshow(img1)
title('Original');

%grayscale
img1=rgb2gray(img1);
imshow(img1)
title('Grayscale');

img1 = wiener2(img1, [10,10]);
figure
imshow(img1)