clc; clear; close all;

% rgb = imread('matang.jpg');
rgb = imread('setengah/1 (5).jpg');
% rgb = imread('setengah.jpg');
% rgb = imread('C:\Users\ardianto\Downloads\img\apple.jpg');

I_rgb = imresize(rgb,[1000 NaN]);

I_hsv = rgb2hsv(I_rgb);

% h = I_hsv(:,:,1);
s = I_hsv(:,:,2);
% v = I_hsv(:,:,3);

nColors = 2;
% repeat the clustering 3 times to avoid local minima
pixel_labels = imsegkmeans(uint8(s), nColors, 'NumAttempts', 3);

% mask1 = pixel_labels == 1;
mask2 = pixel_labels == 2;

% strel
SE_rode = strel('disk', 12);
SE_dilate = strel('disk', 12);

% operasi morfologi
mask_rode = imerode(mask2, SE_rode);
mask = imdilate(mask_rode, SE_dilate);

mask = imfill(mask, 'holes');
mask = bwconvhull(mask, 'objects');

I_masked = I_rgb .* uint8(mask);