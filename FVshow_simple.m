close all;
figure('Position',[100 100 600 600])
lighting( 'phong' )
light('Position',[50 50 50],'Style','infinite')
light('Position',[-50 -50 -50],'Style','infinite')
% camlight( 'left' )
% camlight('right')
axis equal;
axis off;
    
if exist('h','var') && all(ishandle(h))
    delete(h);
end

FV2 = smoothpatch(FV, 1, 1, 1, 1);
h = patch(FV2,'FaceColor', [1 1 1], 'EdgeAlpha', 0);