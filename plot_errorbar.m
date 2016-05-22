bar(M,1.2)

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
% ylim([1 4.5]);
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