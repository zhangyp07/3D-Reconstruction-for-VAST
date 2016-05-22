function [mu_in, sigma_in, mu_out, sigma_out] = meanshift_method( data,sigma, width, w_s_1, w_s_2, thrd )
%SCRIBBLE Summary of this function goes here
%   Detailed explanation goes here
I_obj = [];
I_bck = [];
% for im = 1:round(numel(data)/4)       %zebrafish
% for im = 26:26      %pig
for im  = 1:1   %bunny
    I = data(im).Image;
%     I = delete_capillary( data(im).Image, 150);
    [I, seg] = pre_seg2(I, sigma, width, w_s_1, w_s_2, thrd);
    [H,W,~] = size(I);
    
    ind1 = get_ind_f(seg);          %bunny
    ind2 = get_ind_b(seg);
%     ind1 = find(seg > 0);         %pig
%     ind2 = find(seg == 0);

    I_r = double(reshape(I(:,:,1),H,W));
    I_g = double(reshape(I(:,:,2),H,W));
    I_b = double(reshape(I(:,:,3),H,W));

%     mu_in(1,1) = mean(I_r(ind1));
%     mu_in(2,1) = mean(I_g(ind1));
%     mu_in(3,1) = mean(I_b(ind1));

    I_rgb1 = zeros(length(ind1),3);
    I_rgb1(:,1) = I_r(ind1);
    I_rgb1(:,2) = I_g(ind1);
    I_rgb1(:,3) = I_b(ind1);

%     sigma_in = cov(I_rgb1,1);

%     mu_out(1,1) = mean(I_r(ind2));
%     mu_out(2,1) = mean(I_g(ind2));
%     mu_out(3,1) = mean(I_b(ind2));

    I_rgb2 = zeros(length(ind2),3);
    I_rgb2(:,1) = I_r(ind2);
    I_rgb2(:,2) = I_g(ind2);
    I_rgb2(:,3) = I_b(ind2);
    
    I_obj = [I_obj;I_rgb1];
    I_bck = [I_bck;I_rgb2];
% 
%     sigma_out = cov(I_rgb2,1);
end
mu_in = mean(I_obj,1)';
sigma_in = cov(I_obj,1);

mu_out = mean(I_bck,1)';
sigma_out = cov(I_bck,1);
end

function [meanshift_filtered, seg] = pre_seg2(Img, sigma, width, w_s_1, w_s_2, thrd)
% fR = Img(:,:,1);
% fG = Img(:,:,2);
% fB = Img(:,:,3);
% G = fspecial('gaussian', width, sigma);
% fR_filtered = conv2(double(fR),G,'same');
% fG_filtered = conv2(double(fG),G,'same');
% fB_filtered = conv2(double(fB),G,'same');
% I = uint8(cat(3,fR_filtered,fG_filtered,fB_filtered));\
I = Img;
meanshift_filtered = cv.myfunc_meanshift(I, w_s_1, w_s_2, 3);

I_gray = rgb2gray(meanshift_filtered);
% I_gray = conv2(double(I_gray),G,'same');

% threshold the image into binary
% mask = uint8(I_gray < thrd*255);
mask = (I_gray < 150) .* (I_gray > 100);
% Ir = meanshift_filtered(:,:,1);
% 
% Ib = meanshift_filtered(:,:,3);
% mask = (Ir >80).*(Ib < 77)|(Ir>120);
mask = imclearborder(mask);
mask = imfill(mask,'holes');

% if more than one objects exist keep the largest one.
[L,N] = bwlabel(mask,4);
if N > 1
    s = zeros(1,N);
    for j = 1:N
        s(j) = (sum(L(:)==j));
    end
    [~,ind] = max(s);
    finaL = (L==ind);
else
    finaL = mask;
end
se = strel('disk',5);
finaL = imclose(finaL,se);

seg = finaL;

% fill in the holes and clean the bumps at the tail part
% and dectect the direction of head
% [~,y] = find(finaL>0);
% [~,c] = size(finaL);
% y_right = max(y);
% y_left = min(y);
% W = sum(finaL,1);
% [~, head_pos] = find(W == max(W));
% mean_in = mean(double(I_gray(finaL>0)));
% mean_out = mean(double(I_gray(finaL==0)));
% if head_pos(1) < c/2
%     middle_point = y_right - 100 + 1;
%     head = finaL(:,1:middle_point-1);
%     tail = finaL(:,middle_point:end);
%     head_ = I_gray(:,1:middle_point-1);
%     tail_ = I_gray(:,middle_point:end);
%     [x,~] = find(tail > 0);
%     x1 = find(tail(:,1)>0);
%     tail_top = min(x1);
%     tail_bot = max(x1);
%     min_x = min(x);
%     max_x = max(x);
%     for i = tail_top:tail_bot
%         p = tail(i,:);
%         l = find(double(p)>0);
%         tail(i,min(l):max(l)) = 1;
%         tail_(i,min(l):max(l)) = tail_(i,min(l));
%     end
%     if tail_top > min_x
%         tail(min_x:tail_top-1,:) = 0;
%         tail_(min_x:tail_top-1,:) = mean_out;
%     end
%     if tail_bot < max_x
%         tail(tail_bot+1:max_x,:) = 0;
%         tail_(tail_bot+1:max_x,:) = mean_out;
%     end
%     seg = [head, tail];
%     I_gray = [head_,tail_];
% else
%     middle_point = y_left + 100 - 1;
%     tail = finaL(:,1:middle_point-1);
%     head = finaL(:,middle_point:end);
%     tail_ = I_gray(:,1:middle_point-1);
%     head_ = I_gray(:,middle_point:end);
%     [x,~] = find(tail > 0);
%     x1 = find(tail(:,end)>0);
%     tail_top = min(x1);
%     tail_bot = max(x1);
%     min_x = min(x);
%     max_x = max(x);
%     for i = tail_top:tail_bot
%         p = tail(i,:);
%         l = find(double(p)>0);
%         tail(i,min(l):max(l)) = 1;
%         tail_(i,min(l):max(l)) = tail_(i,min(l));
%     end
%     if tail_top > min_x
%         tail(min_x:tail_top-1,:) = 0;
%         tail_(min_x:tail_top-1,:) = mean_out;
%     end
%     if tail_bot < max_x
%         tail(tail_bot+1:max_x,:) = 0;
%         tail_(tail_bot+1:max_x,:) = mean_out;
%     end
%     seg = [tail, head];
%     I_gray = [tail_,head_];
% end
end

function image_no_capillary = delete_capillary( I, thre )

[h,w,c] = size( I );
I_gray = rgb2gray(I);

for j = 1:w
    for m = 420:h
        if I_gray(m,j) <= thre && I_gray(m+8,j) <= thre
            I(m-2:m+3,j,:) = I(3:8,j,:);
            break;
        end
        
        % the capillary associated with fish
        if I_gray(m,j) <= thre
            I(m-4:m+4,j,:) = I(3:11,j,:);
            break;
        end
    end
    
    for m = h-430:-1:1
        if I_gray(m,j) <= thre && I_gray(m-8,j) <= thre
            I(m-3:m+2,j,:) = I(end-5:end,j,:);
            break;
        end
        
        if I_gray(m,j) <= thre
            I(m-4:m+4,j,:) = I(end-8:end,j,:);
            break;
        end
    end
end
image_no_capillary = I;
% imshow(image_no_capillary,[]);
end

function ind = get_ind_f(seg)
    [H,W] = size(seg);
    se = strel('disk',40);
    seg2 = imerode(seg,se);

    [x,y] = find(seg2>0);
    [~,xmin] = min(x);
    [~,xmax] = max(x);
    x_start = x(xmin);
    y_start = y(xmin);
    x_end = x(xmax);
    y_end = y(xmax);
    
    X = x_start:2:x_end;
    x = [x_start x_end];
    y = [y_start y_end];
    Y = interp1(x,y,X);
    r = round(Y);
    
    ind = sub2ind([H,W],X,r);
    
%     e = edge(seg2);
%     
%     surr = find(e>0)';
%     ind = [ind,surr(1:1:end)];
%     ind = surr;
end

function ind = get_ind_b(seg)
    [H,W] = size(seg);
    se = strel('disk',40);
    seg2 = imdilate(seg,se);
    ind = find(seg2 == 0);
    [x y] = find(seg2 > 0);
    [~,ymax] = max(y);

    y_start = y(ymax);
    x_start = x(ymax);
    
    Y = y_start:2:W;
    X = repmat(x_start,1,length(Y));
%     X = 100:3:(H-100);
%     Y = repmat(round((y_start+W)/2),1,length(X));
    ind = sub2ind([H,W],X,Y);
%     e = edge(seg2);
%     surrounding = find(e>0)';
%     
%     surrounding = surrounding(1:1:end);
%     ind = [ind,surrounding];                  %pig
%     ind = surrounding;
    
end


