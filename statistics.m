close all;
clear all;

tic;

subfolders  = dir( 'data\zz\' );
kk = 1; %ignore the . and ..
for i = 1 : numel( subfolders )
    if( isequal(subfolders(i).name, '.')||...
            isequal(subfolders(i).name, '..')||...
            ~subfolders(i).isdir)
        continue;
    else
        specimen_index(kk) = subfolders(i);
        kk = kk + 1;
    end
end

group = [4,7,12,14,21,28,42,84];


xlim = [-2700 2700];
ylim = [-1000 1000];
zlim = [-1000 1000];

ini_num = 15000000;

voxels = makevoxels(xlim, ylim, zlim, ini_num);

voxels2 = makevoxels([-2700 2300],ylim,zlim, ini_num);

volume_all = zeros(63,numel(group));

surfaceArea_all = zeros(63,numel(group));

for i = 1:7
    for tt = [1:8,10:44,46:54,56:63]
        data_folder = ['data\zz\',specimen_index(tt).name];
        data_name = [data_folder,'\',specimen_index(tt).name,'_automated_exp_',num2str(group(i)),'.mat'];
        
        load(data_name, 'phi','FV2');
        
        volume = sum(phi(:)>=0.5)*voxels.Resolution.^3/(1e+9);
        
        area = surface_area(FV2);
        
        volume_all(tt,i) = volume;
        
        surfaceArea_all(tt,i) = area;
    end
    data_folder = ['data\zz\',specimen_index(9).name];
    data_name = [data_folder,'\',specimen_index(9).name,'_automated_exp_',num2str(group(i)),'.mat'];
        
    load(data_name, 'phi','FV2');
        
    volume = sum(phi(:)>=1)*voxels.Resolution.^3/(1e+9);
        
    area = surface_area(FV2);
        
    volume_all(9,i) = volume;
        
    surfaceArea_all(9,i) = area;
    
end

ind5 = [37:44,46:54,56:63];

volume_3dpf = volume_all(1:12,:);
volume_4dpf = volume_all(13:36,:);
volume_5dpf = volume_all(37:end,:);

surfaceArea_3dpf = surfaceArea_all(1:12,:);
surfaceArea_4dpf = surfaceArea_all(13:36,:);
surfaceArea_5dpf = surfaceArea_all(37:end,:);

bar([mean(volume_3dpf,1);mean(volume_4dpf,1);mean(volume_5dpf(ind5-36,:),1)]')
set(gca,'XTickLabel',group)
xlabel('View sampling density')
ylabel('Voxel residual volume')