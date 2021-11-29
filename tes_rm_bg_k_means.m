clc; clear; close all;

% rgb = imread('matang.jpg');
% rgb = imread('mentah/1 (10).jpg');
rgb = imread('setengah.jpg');

I_rgb = imresize(rgb,[1000 NaN]);

I_lab = rgb2lab(I_rgb);

ab = I_lab(:,:,2:3);
ab = im2single(ab);
nColors = 3;
% repeat the clustering 3 times to avoid local minima
pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',4);

% imshow(pixel_labels,[])
% title('Image Labeled by Cluster Index');

mask1 = pixel_labels == 1;
mask2 = pixel_labels == 2;
mask3 = pixel_labels == 3;

% mask3 = imfill(mask3, 'holes');
% mask3 = bwconvhull(mask3, 'objects');

cluster3 = I_rgb .* uint8(mask3);
cluster2 = I_rgb .* uint8(mask2);
cluster1 = I_rgb .* uint8(mask1);

% SE = strel('disk', 15);

% 
% cluster2 = I_rgb .* uint8(mask2rode);
% cluster2mix = I_rgb .* uint8(mask2mix);
