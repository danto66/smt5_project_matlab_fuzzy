clc; clear; close all;

rgb = imread('matang.jpg');
% rgb = imread('mentah/1 (5).jpg');
% rgb = imread('setengah.jpg');
% rgb = imread('C:\Users\ardianto\Downloads\img\orange.jpg');

if length(rgb) > 1000
    I_rgb = imresize(rgb,[1000 NaN]);
    disp(int2str(length(rgb)));
else
    disp(int2str(length(rgb)));
    I_rgb = rgb;
end

[mask, maskedRGB] = remove_bg_kmeans(I_rgb);