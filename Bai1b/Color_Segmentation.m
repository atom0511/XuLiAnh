%% Read in image
I = imread('objets3.jpg');
imshow(I);

%% Solution:  Thresholding the image on each color pane
%Im=double(img)/255;
Im=I;

rmat=Im(:,:,1);
gmat=Im(:,:,2);
bmat=Im(:,:,3);

subplot(2,2,1), imshow(rmat);
title('Red Plane');
subplot(2,2,2), imshow(gmat);
title('Green Plane');
subplot(2,2,3), imshow(bmat);
title('Blue Plane');
subplot(2,2,4), imshow(I);
title('Original Image');

%%
levelr = 0.4;
levelg = 0.4;
levelb = 0.45;
i1=imbinarize(rmat,levelr);
i2=imbinarize(gmat,levelg);
i3=imbinarize(bmat,levelb);
Isum = (i1&i2&i3);
imshow(Isum)

% Plot the data
subplot(2,2,1), imshow(i1);
title('Red Plane');
subplot(2,2,2), imshow(i2);
title('Green Plane');
subplot(2,2,3), imshow(i3);
title('Blue Plane');
subplot(2,2,4), imshow(Isum);
title('Sum of all the planes');

%% Complement Image and Fill in holes
Icomp = imcomplement(Isum);
figure
imshow(Icomp);
Ifilled = imfill(Icomp,'holes');
figure
imshow(Ifilled);

%%
se = strel('disk', 3);
Iopenned = imopen(Ifilled,se);
imshow(Ifilled);

%% Extract features
Iregion = regionprops(Iopenned, 'centroid');
[labeled,numObjects] = bwlabel(Iopenned, 4);
stats = regionprops(labeled,'Eccentricity','Area','BoundingBox');
areas = [stats.Area];
eccentricities = [stats.Eccentricity];

%% Use feature analysis to count skittles objects
count = find(eccentricities);
statsDefects = stats(count);

figure, imshow(I);
hold on;
for idx = 1 : length(count)
        h = rectangle('Position',statsDefects(idx).BoundingBox,'LineWidth',2);
        set(h,'EdgeColor',[.75 0 0]);
        hold on;
end

if idx > 8
title(['There are ', num2str(numObjects), ' objects in the image!']);
end
hold off;


