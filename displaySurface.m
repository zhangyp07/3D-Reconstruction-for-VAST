% display the reconstructed surface
%% set up
clear;
clc;
close all;

addpath('uils\','smooth\');
path = 'data';
object = [14:14];
save_video = 1;
step_size = 1; % 1 2 3 or 4

subfolders  = dir( path );
kk = 1;
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

for tt = object
    close all;
    data_folder = [path,'\',specimen_index(tt).name];
    surface_name = [data_folder,'\',specimen_index(tt).name,'_optimal_data_views.mat'];
    load(surface_name);
    v = FV2.vertices;
    r = [cos(pi/2) 0 sin(pi/2);
        0    1     0;
        -sin(pi/2) 0 cos(pi/2)];
    v1 = r*v';
    FV3 = FV2;
    FV3.vertices = v1';
    figure('Position',[200 200 600 600]);
    p = patch(FV3, 'facecolor','flat','edgecolor', 'interp');
    set(p,'FaceColor', [0 1 0], 'FaceLighting', 'flat','EdgeColor', 'none',...
        'SpecularStrength', 0.1, 'AmbientStrength', 0.2, 'DiffuseStrength', 0.3);
    set(gca,'DataAspectRatio',[1 1 1], 'PlotBoxAspectRatio',[1 1 1]);
    axis vis3d;
    light('Position',[1 1 0.5], 'Visible', 'on');
    light('Position',[1 -1 0.5], 'Visible', 'on');
    light('Position',[-1 1 0.5], 'Visible', 'on');
    light('Position',[-1 -1 0.5], 'Visible', 'on');
    axis equal;
    axis off
    view([0 0]);
    set(gcf,'name',['The ' num2str(tt) '-th specimen reconstruction'])

    if save_video
        video_name = ['videos\video_' specimen_index(tt).name '_optimal_data_views.gif'];
        %         video_name = ['videos\video_' specimen_index(tt).name '_surface_view' num2str(step_size), '.avi'];
        %         writerObj = VideoWriter(video_name);
        %         open(writerObj);

        nn = 1;
        for ii = 0:2:359
            view([ii 0]);
            saveas(gcf,['temp\' num2str(nn),'.png'],'png');
            im = imread(['temp\' num2str(nn),'.png']);
            im = imrotate(im, 90, 'bicubic');
            [I,map] = rgb2ind(im,256);
            if nn == 1
               imwrite(I, map, video_name, 'gif', 'Loopcount',inf); 
            else
                imwrite(I, map, video_name, 'gif', 'DelayTime', 0.1, 'WriteMode', 'append');
            end
            %             writeVideo(writerObj,im);
            nn = nn + 1;
            drawnow;
        end
        %         close(writerObj);
%{
        figure('Position',[1000 200 600 600]);
        h2 = patch(FV2,'FaceColor',[0 1 0],'EdgeAlpha',0);
        data_name = [data_folder,'\',specimen_index(tt).name,'_optimal_data.mat'];
        load(data_name);
        data = data(1:step_size:end);
        colorsurface( h2, data );
        set(h2,'Vertices',v1');
        set(gca,'DataAspectRatio',[1 1 1], 'PlotBoxAspectRatio',[1 1 1]);
        axis vis3d;
        light('Position',[1 1 0.5], 'Visible', 'on');
        light('Position',[1 -1 0.5], 'Visible', 'on');
        light('Position',[-1 1 0.5], 'Visible', 'on');
        light('Position',[-1 -1 0.5], 'Visible', 'on');
        axis equal;
        axis off
        set(gcf,'name',['The ' num2str(tt) '-th specimen rendering'])
        video_name = ['videos\video_' specimen_index(tt).name '_colorsurface_view' num2str(step_size) '.gif'];
        %         video_name = ['videos\video_' specimen_index(tt).name '_colorsurface_view' num2str(step_size) '.avi'];
        %         writerObj = VideoWriter(video_name);
        %         open(writerObj);

        nn = 1;
        for ii = 0:2:359
            view([ii 0]);
            saveas(gcf,['temp\' num2str(nn),'.png'],'png');
            im = imread(['temp\' num2str(nn),'.png']);
            im = imrotate(im, 90, 'bicubic');
            [I,map] = rgb2ind(im, 256);
            if nn == 1
                imwrite(I, map, video_name, 'gif', 'Loopcount',inf); 
            else
                imwrite(I, map, video_name, 'gif', 'DelayTime', 0.1, 'WriteMode', 'append');
            end
            %             writeVideo(writerObj,im);
            nn = nn + 1;
            drawnow;
        end
        %         close(writerObj);

    else

        for ii = 0:1:359
            view([ii 0]);
            drawnow;
        end

        figure('Position',[1000 200 600 600]);
        h2 = patch(FV2,'FaceColor',[0 1 0],'EdgeAlpha',0);
        data_name = [data_folder,'\',specimen_index(tt).name,'_optimal_data.mat'];
        load(data_name);
        data = data(1:step_size:end);
        colorsurface( h2, data );
        set(h2,'Vertices',v1');
        set(gca,'DataAspectRatio',[1 1 1], 'PlotBoxAspectRatio',[1 1 1]);
        axis vis3d;
        light('Position',[1 1 0.5], 'Visible', 'on');
        light('Position',[1 -1 0.5], 'Visible', 'on');
        light('Position',[-1 1 0.5], 'Visible', 'on');
        light('Position',[-1 -1 0.5], 'Visible', 'on');
        axis equal;
        axis off
        set(gcf,'name',['The ' num2str(tt) '-th specimen rendering'])
        for ii = 0:1:359
            view([ii 0]);
            drawnow;
        end
        %}
    end
end
