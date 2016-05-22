close all;

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

tt =58;
view_number =42;

data_folder = ['data\zz\',specimen_index(tt).name];
restructed_name = [data_folder,'\',specimen_index(tt).name,'_automated_exp_',num2str(view_number),'.mat'];
refined_name = [data_folder,'\',specimen_index(tt).name,'_automated_exp_',num2str(view_number),'_refine.mat'];


load(refined_name,'ref_FV');
% load(refined_name,'phi');
% FV = isosurface(phi,0);

figure('Position',[100 100 600 600])
lighting( 'phong' )
camlight( 'headlight' )
axis equal;
axis off;
    
if exist('h','var') && all(ishandle(h))
    delete(h);
end
h = patch(ref_FV,'FaceColor', [0 1 0], 'EdgeAlpha', 0);

% voxels = makevoxels(xlim,ylim,zlim,ini_num);
% voxels2image = find_projection_point(voxels, data);
% display_seg(phi,data, voxels2image);
