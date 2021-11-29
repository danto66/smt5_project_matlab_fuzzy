clear; clc;

matang = imread('matang/1 (2).jpg');
mentah = imread('mentah/1 (10).jpg');

[matang_bw, matang] = remove_bg(matang);
[mentah_bw, mentah] = remove_bg(mentah);

matang_g = matang(:,:,2);
mentah_g = mentah(:,:,2);

matang_mean = mean(mean(matang_g));
mentah_mean = mean(mean(mentah_g));