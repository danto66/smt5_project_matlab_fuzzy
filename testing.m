clear;
clc;

kelas = ["matang", "mentah", "setengah"];
% kelas = ["matang"];

target = [];
nama = [];
lab_a = [];
hsv_h = [];
defuzzy = [];
testing = [];

fis = readfis('mamdani');

for i=1 : length(kelas)
    imageFiles = dir(strcat("Testing/", kelas(i), "/", '*.jpg'));
    for j=1 : length(imageFiles)
        disp(strcat(kelas(i), " ke-", int2str(j)));
        rgb = imread(strcat("Testing/", kelas(i), "/", imageFiles(j).name));
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
        
        if output_fuzzy < 2.284956708
            kematangan = "Mentah";
        elseif output_fuzzy > 2.284956708 && output_fuzzy < 8.814729823
            kematangan = "Setengah Matang";
        elseif output_fuzzy > 8.814729823
            kematangan = "Matang";
        end

        testing = [testing,kematangan];
        target = [target, kelas(i)];
        nama = [nama, convertCharsToStrings(imageFiles(j).name)];
    end
end

lab_a = lab_a.';
hsv_h = hsv_h.';

target = target.';
nama = nama.';

defuzzy = defuzzy.';
testing = testing.';

T = table(nama, lab_a, hsv_h, target, defuzzy, testing);
filename = "data_testing.xlsx";

writetable(T,filename);

disp('job done');