function display_seg(phi, data, voxels2image)
n = numel(data);
[H,W,C] = size(data(1).Image);
figure;
for i = 1:n;
    cord = voxels2image(i).cord;
    I = data(i).Image;
    %I = ones(H,W);
    in_obj = cord(phi(:)>0.9,:);
    imshow(I,[]);
    hold on;
    plot(in_obj(:,2), in_obj(:,1), 'r.', 'MarkerSize', 2);
    hold off;
    
    %     seg(in_index) = 1;
    %     imshow(seg,[]);
    %     [L, N] = bwlabel(seg, 4);
    %     if N > 1
    %         s = zeros(1,N);
    %         for j = 1:N
    %             s(j) = (sum(L(:)==j));
    %         end
    %         [~,ind] = max(s);
    %         final_seg = (L==ind);
    %     else
    %         final_seg = seg;
    %     end
    %
    %     B = bwboundaries(final_seg, 8, 'noholes');
    %     C = B{1};
    %     imshow(I,[]);
    %     hold on;
    %     plot(C(:,2), C(:,1), 'Color', 'r', 'LineWidth', 2);
    %     drawnow;
    %     hold off;
    pause(0.5);
end
end