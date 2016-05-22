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

group = [4,7,12,14,21,28,42];

volume_all_refine = zeros(63,numel(group));

surfaceArea_all_refine = zeros(63,numel(group));

for i = 1:7
    for tt = [1:8,10:44,46:54,56:63]
        data_folder = ['data\zz\',specimen_index(tt).name];
        data_name = [data_folder,'\',specimen_index(tt).name,'_automated_exp_',num2str(group(i)),'_refine.mat'];
        
        load(data_name, 'volume3','area3')
        
        volume_all_refine(tt,i) = volume3;
        
        surfaceArea_all_refine(tt,i) = area3;
    end
    data_folder = ['data\zz\',specimen_index(9).name];
    data_name = [data_folder,'\',specimen_index(9).name,'_automated_exp_',num2str(group(i)),'_refine.mat'];
        
    load(data_name, 'volume3','area3');

    volume_all_refine(9,i) = volume3;
        
    surfaceArea_all_refine(9,i) = area3;
    
end

ind5 = [37:44,46:54,56:63];

volume_3dpf = volume_all_refine(1:12,:);
volume_4dpf = volume_all_refine(13:36,:);
volume_5dpf = volume_all_refine(37:end,:);

surfaceArea_3dpf = surfaceArea_all_refine(1:12,:);
surfaceArea_4dpf = surfaceArea_all_refine(13:36,:);
surfaceArea_5dpf = surfaceArea_all_refine(37:end,:);

M = [mean(volume_3dpf,1);mean(volume_4dpf,1);mean(volume_5dpf(ind5-36,:),1)]';
st = [std(volume_3dpf,1,1);std(volume_4dpf,1,1);std(volume_5dpf(ind5-36,:),1,1)]';

bar(M,1.2);


[hBar,hErrorbar] = barwitherr(st, M);
hBar(1).FaceColor = [204 0 102]/255; hBar(2).FaceColor = [0 153 76]/255; hBar(3).FaceColor = [0 102 204]/255;
% hBar(4).FaceColor = [54 54 54]/255;
hBar(1).BarWidth = 1; hBar(2).BarWidth = 1; hBar(3).BarWidth = 1;
set(hErrorbar(1),'LineStyle','-','LineWidth',2,'Color','r','Marker','v','MarkerFaceColor','y','MarkerSize',8);
set(hErrorbar(2),'LineStyle','-','LineWidth',2,'Color','g','Marker','v','MarkerFaceColor','y','MarkerSize',8);
set(hErrorbar(3),'LineStyle','-','LineWidth',2,'Color','b','Marker','v','MarkerFaceColor','y','MarkerSize',8);
% set(hErrorbar(4),'LineStyle','-','LineWidth',2,'Color','k','Marker','v','MarkerFaceColor','y','MarkerSize',8);
set(gca,'XTickLabel',{'4','7','12','14','21','28','42'})

legend('3 dpf zebrafish','4 dpf zebrafish','5 dpf zebrafish');
ylim = [1 4.5];
ylimi = 1:0.25:4.5;
set(gca, 'YTick', ylimi)
gca.YTick = ylimi
set(gca, 'YTickLabel', sprintf('%1.2f\n', ylimi));
set(gca, 'FontSize', 20, 'FontWeight', 'bold');

text('Interpreter','tex','String','\times 10^{8}\mu m^3','Position',[0 4.5],'FontSize',20,'HorizontalAlignment','left','VerticalAlignment','bottom');
title('Voxel residual volume of zebrafish during development against VSD','FontSize', 20, 'FontWeight', 'bold')
xlabel('View sampling density (VSD)','FontSize', 20, 'FontWeight', 'bold')
ylabel('Voxel residual volume','FontSize', 20, 'FontWeight', 'bold')

grid on;
set(gcf,'outerposition',get(0,'screensize'));

% export_fig('figure\volume_errorbar_efficient.pdf', '-pdf');
