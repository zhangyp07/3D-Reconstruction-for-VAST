imshow(I);
hold on
[y_o x_o] = ind2sub([H W],ind1);
[y_b x_b] = ind2sub([H W],ind2);
plot(x_o, y_o,'r','MarkerSize',2);
plot(x_b, y_b,'b','MarkerSize',2);