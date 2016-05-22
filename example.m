% example
clear;
clc;
close all;

addpath('uils\','smooth\','uils\AOSLevelsetSegmentationToolboxM\');
% path = 'data\zz';
path = 'data';
object_index = [3];
% object_index = [52];
% sample_size = 1;

% xlim = [-2700 2700];
% ylim = [-1000 1000];
% zlim = [-1000 1000];

xlim = [-7.5 7.5];
ylim = [-10 10];
zlim = [-7.5 15];

% xlim = [-6 6];
% ylim = [-6 6];
% zlim = [-6 0];
ini_num = 3000000;

% image_weight = 1e-3;
% smooth_weight_cv = 1;
% 
% expansion_weight =  -2;
% smooth_weight_gac = 2;
% 
% delta_t = 0.1;
maxiter = 50;

extra_iter = 5;

compute_method =2;

sigma = 1.5;
width = 5;
s_w_1 = 5;
s_w_2 = 10;
thrd = 0.8;


%  FV = reconstruct_3D_ChanVese( object_index, sample_size, step_size, ini_num, ...
%                              image_weight, smooth_weight_cv, ...
%                              expansion_weight, smooth_weight_gac,...
%                              delta_t, maxiter,...
%                              sigma, width, s_w_1, s_w_2, thrd);


% for sample_size = [4]
% for sample_size = [6,7,12,21]
% for sample_size = [2,3]
for sample_size = [1]
  [FV, volume1, area1] = reconstruct_3D_CV( object_index, sample_size, xlim, ylim, zlim, ini_num, ...
                                maxiter, compute_method, sigma, width, s_w_1, s_w_2, thrd);

%   [FV, FV2, volume2, area2,ref_FV,ref_FV2,volume3, area3] = refinement( object_index, sample_size, xlim, ylim, zlim, ini_num, ...
%                                 maxiter, extra_iter, compute_method, sigma, width, s_w_1, s_w_2, thrd);
end
% 
%   FV = reconstruct_3D_GAC( object_index, sample_size, step_size, ini_num, ...
%       image_weight, smooth_weight_cv, ...
%        expansion_weight, smooth_weight_gac,...
%       delta_t, maxiter,...
%     sigma, width, s_w_1, s_w_2, thrd);


