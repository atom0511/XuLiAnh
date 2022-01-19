%get image
img1=imread('image1.png');
whileBg = imread('whileBg.png');
imshow(img1)
title('Original');

%grayscale
img1=rgb2gray(img1);
imshow(img1)
title('Grayscale');


%gausse
Isp = imnoise(img1,'salt & pepper'); % add 3% (0.03) salt and pepper noise
Ig = imnoise(img1,'gaussian',0.02); % add Gaussian noise (with 0.02 variance)
k = fspecial('gaussian', [5 5], 2);    % define Gaussian filter
I_g = imfilter(img1,k); % apply to original image
Isp_g = imfilter(Isp,k); % apply to salt and pepper image
Ig_g = imfilter(Ig,k); % apply tp gaussian image
img1 = I_g;
imshow(img1)
title('Gauss');

%struct ele by tophat filter
se = strel('disk', 10);
tophatFiltered = imtophat(img1,se);
figure
imshow(tophatFiltered)
img1 = imadjust(tophatFiltered);
figure
imshow(img1)
title('strel');

%graythresh
figure
img2=imbinarize(img1,graythresh(img1));
imshow(img2)
img2=~img2; %swap color
imshow(img2)
title('graythresh');

%find boundary and count
B = bwboundaries(img2);
figure
imshow(img2)
title(['There are ', num2str(length(B)), ' objects in the image!']);
hold on

for k = 1:length(B)
boundary = B{k};
plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 0.2)
end

