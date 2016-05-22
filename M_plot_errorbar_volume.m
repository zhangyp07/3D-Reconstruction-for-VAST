%% plot volume and area
close all;
clear;
clc;

addpath(genpath('tools\'));
folder = 'Experiments_efficient\';
% folder = 'Experiments_redundancy\';

files = dir(fullfile(folder,'*volume*.mat'));
N = numel(files);
area_mat = zeros(60,8);
volume_mat = area_mat;

tt = 1; % object index
rr = 1; % matrix row
cc = 1; % matrix column
for i = 1:N
    name = files(i).name;
    load([folder,name]);
    obj{tt} = name(4:12);
    if strcmp(name(end-5),'_')
        stepsize = str2num(name(end-4));
    else
        stepsize = str2num(name(end-5:end-4));
    end
    
    switch stepsize
        case 21
            cc = 1;
        case 12
            cc = 2;
        case 7
            cc = 3;
        case 6
            cc = 4;
        case 4
            cc = 5;
        case 3
            cc = 6;
        case 2
            cc = 7;
        case 1
            cc = 8;
    end
    
    if tt ~= 1 && ~strcmp(obj{tt},obj{tt-1})
        rr = rr + 1;
    end
    area_mat(rr,cc) = surface_area;
    volume_mat(rr,cc) = volume;
    tt = tt + 1;
end

%% volume plot
volume_mat = volume_mat*10;

feat1 = volume_mat(1:12,:);
mu1 = mean(feat1);
sigma1 = std(feat1);

feat2 = volume_mat(13:36,:);
mu2 = mean(feat2);
sigma2 = std(feat2);

feat3 = volume_mat(37:60,:);
mu3 = mean(feat3);
sigma3 = std(feat3);

% feat4 = volume_mat(36:44,:);
% mu4 = mean(feat4);
% sigma4 = std(feat4);

% M = [mu1;mu2;mu3;mu4]';
M = [mu1;mu2;mu3]';
% st = [sigma1;sigma2;sigma3;sigma4]';
st = [sigma1;sigma2;sigma3]';
bar(M,1.2)

[hBar,hErrorbar] = barwitherr(st, M);
hBar(1).FaceColor = [204 0 102]/255; hBar(2).FaceColor = [0 153 76]/255; hBar(3).FaceColor = [0 102 204]/255;
% hBar(4).FaceColor = [54 54 54]/255;
hBar(1).BarWidth = 1; hBar(2).BarWidth = 1; hBar(3).BarWidth = 1;
set(hErrorbar(1),'LineStyle','-','LineWidth',2,'Color','r','Marker','v','MarkerFaceColor','y','MarkerSize',8);
set(hErrorbar(2),'LineStyle','-','LineWidth',2,'Color','g','Marker','v','MarkerFaceColor','y','MarkerSize',8);
set(hErrorbar(3),'LineStyle','-','LineWidth',2,'Color','b','Marker','v','MarkerFaceColor','y','MarkerSize',8);
% set(hErrorbar(4),'LineStyle','-','LineWidth',2,'Color','k','Marker','v','MarkerFaceColor','y','MarkerSize',8);
set(gca,'XTickLabel',{'4','7','12','14','21','28','42','84'})

legend('3 dpf zebrafish','4 dpf zebrafish','5 dpf zebrafish');
ylim([1 4.5]);
ylimi = 1:0.25:4.5;
set(gca, 'YTick', ylimi)
set(gca, 'YTickLabel', sprintf('%1.2f\n', ylimi));
set(gca, 'FontSize', 20, 'FontWeight', 'bold');

text('Interpreter','tex','String','\times10^{8}\mum^3','Position',[0 4.5],'FontSize',20,'HorizontalAlignment','left','VerticalAlignment','bottom');
title('Voxel residual volume of zebrafish during development against VSD','FontSize', 20, 'FontWeight', 'bold')
xlabel('View sampling density (VSD)','FontSize', 20, 'FontWeight', 'bold')
ylabel('Voxel residual volume','FontSize', 20, 'FontWeight', 'bold')

grid on;
set(gcf,'outerposition',get(0,'screensize'));

export_fig('figures\volume_errorbar_efficient.pdf', '-pdf');
% export_fig volume_errorbar_redundancy -pdf

