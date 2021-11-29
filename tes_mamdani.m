clear;
clc;

kelas = ["matang", "mentah", "setengah"];
% kelas = ["matang"];

target = [];
nama = [];
lab_a = [];
hsv_h = [];
defuzzy = [];

fis = readfis('mamdani');

for i=1 : length(kelas)
    imageFiles = dir(strcat(kelas(i), "/", '*.jpg'));
    for j=1 : length(imageFiles)
        disp(strcat(kelas(i), " ke-", int2str(j)));
        rgb = imread(strcat(kelas(i), "/", imageFiles(j).name));
        rgb = imresize(rgb,[1000 NaN]);
        [bw, rgb] = remove_bg_kmeans(rgb);
        lab = rgb2lab(rgb);
        hsv = rgb2hsv(rgb);
        
        a = lab(:,:,2);
        h = hsv(:,:,1);
        
        a_mean = mean(nonzeros(a));
        h_mean = mean(nonzeros(h));
        output_fuzzy = evalfis(fis, [a_mean h_mean]);
        
        lab_a = [lab_a, a_mean];
        hsv_h = [hsv_h, h_mean];
        defuzzy = [defuzzy, output_fuzzy];

        target = [target, kelas(i)];
        nama = [nama, convertCharsToStrings(imageFiles(j).name)];
    end
end

lab_a = lab_a.';
hsv_h = hsv_h.';

target = target.';
nama = nama.';

defuzzy = defuzzy.';

T = table(nama, lab_a, hsv_h, target, defuzzy);
filename = "data_tes_fuzzy_lab_hsv.xlsx";

writetable(T,filename);

disp('job done');