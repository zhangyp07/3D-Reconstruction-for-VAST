datafolder = 'data\bird_data\images\';
silfolder = 'data\bird_data\silhouettes\';
Pfolder = 'data\bird_data\calib\';

datafiles = dir(fullfile(datafolder,'*.ppm'));
silfiles = dir(fullfile(silfolder,'*.pgm'));
Pfiles = dir(fullfile(Pfolder,'*.txt'));

len = length(datafiles);

for i = 1:len
    data(i).Image = imread([datafolder, datafiles(i).name]);
    sil = imread([silfolder, silfiles(i).name]);
    data(i).Silhouette = ~sil;
    tmp = importdata([Pfolder, Pfiles(i).name]);
    data(i).P = tmp.data;
end

save('data\bird_data\bird_data_optimal_data.mat','data');
