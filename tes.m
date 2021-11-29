clear;
clc;

kelas = ["matang", "mentah", "setengah"];
% kelas = ["matang"];
red = [];
green = [];
target = [];
nama = [];
lab_a = [];
lab_b = [];
hsv_h = [];
hsv_s = [];
hsv_v = [];


for i=1 : length(kelas)
    imageFiles = dir(strcat(kelas(i), "/", '*.jpg'));
    for j=1 : length(imageFiles)
        disp(strcat(kelas(i), " ke-", int2str(j)));
        rgb = imread(strcat(kelas(i), "/", imageFiles(j).name));
        rgb = imresize(rgb,[1000 NaN]);
        [bw, rgb] = remove_bg_kmeans(rgb);
        lab = rgb2lab(rgb);
        hsv = rgb2hsv(rgb);
        
        r = rgb(:,:,1);
        g = rgb(:,:,2);
        a = lab(:,:,2);
        b = lab(:,:,3);
        h = hsv(:,:,1);
        s = hsv(:,:,2);
        v = hsv(:,:,3);
        
        r_mean = mean(nonzeros(r));
        g_mean = mean(nonzeros(g));
        a_mean = mean(nonzeros(a));
        b_mean = mean(nonzeros(b));
        h_mean = mean(nonzeros(h));
        s_mean = mean(nonzeros(s));
        v_mean = mean(nonzeros(v));
        
        red = [red, r_mean];
        green = [green, g_mean];
        lab_a = [lab_a, a_mean];
        lab_b = [lab_b, b_mean];
        hsv_h = [hsv_h, h_mean];
        hsv_s = [hsv_s, s_mean];
        hsv_v = [hsv_v, v_mean];
        target = [target, kelas(i)];
        nama = [nama, convertCharsToStrings(imageFiles(j).name)];
    end
end

red = red.';
green = green.';
lab_a = lab_a.';
lab_b = lab_b.';
hsv_h = hsv_h.';
hsv_s = hsv_s.';
hsv_v = hsv_v.';
target = target.';
nama = nama.';

T = table(nama, red, green, lab_a, lab_b, hsv_h, hsv_s, hsv_v, target);
filename = "data_rgb_lab_hsv.xlsx";

writetable(T,filename);

disp('job done');