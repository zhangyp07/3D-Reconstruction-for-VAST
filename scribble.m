function [x_obj, y_obj, x_bck, y_bck, mu_in, sigma_in, mu_out, sigma_out, I_scrib] = scribble( data,sigma, width, w_s_1, w_s_2, thrd )
%SCRIBBLE Summary of this function goes here
%   Detailed explanation goes here

fprintf('Please draw the object\n');
[x_obj, y_obj, mu_in, sigma_in] = scribble_a_line(data);

fprintf('Please draw the background\n');
[x_bck, y_bck, mu_out, sigma_out] = scribble_a_line(data);

I_scrib = data(5).Image;
figure(4);
imshow(I_scrib);
hold on;
plot(x_obj, y_obj, 'Color','r','LineWidth',2);
hold on;
plot(x_bck, y_bck, 'Color','b','LineWidth',2);
hold off;
F = getframe(gcf);
I_scrib = F.cdata;

end

function [xs, ys, mu, sigma] = scribble_a_line(data)
I = data(5).Image;

[H,W,~] = size(I);

figure(3)
imshow(I);
hold on;
[~,xs, ys] = freehanddraw;

ind = sub2ind([H,W],int16(ys), int16(xs));

I_r = double(reshape(I(:,:,1),H,W));
I_g = double(reshape(I(:,:,2),H,W));
I_b = double(reshape(I(:,:,3),H,W));

mu(1,1) = mean(I_r(ind));
mu(2,1) = mean(I_g(ind));
mu(3,1) = mean(I_b(ind));

I_rgb = zeros(length(ind),3);
I_rgb(:,1) = I_r(ind);
I_rgb(:,2) = I_g(ind);
I_rgb(:,3) = I_b(ind);

sigma = cov(I_rgb,1);
close(3);
end

