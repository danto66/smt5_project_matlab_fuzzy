function [mask, maskedRGB] = remove_bg_kmeans(rgb)
% ubah RGB ke HSV
hsv = rgb2hsv(rgb);

% ambil nilai s
s = hsv(:,:,2);

% segmentasi k-means
nColors = 2;
% repeat the clustering 3 times to avoid local minima
pixel_labels = imsegkmeans(uint8(s), nColors, 'NumAttempts', 3);

% ambil nilai foreground
mask = pixel_labels == 2;

% operasi morfologi
mask = imopen(mask, strel('disk', 12));

mask = imfill(mask, 'holes');
mask = bwconvhull(mask, 'objects');

maskedRGB = rgb .* uint8(mask);
end

