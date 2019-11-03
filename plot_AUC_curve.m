function plot_AUC_curve( x,AUC_Share,AUC_Individual1,AUC_Individual2,AUC_Individual3,param )
%% Extract all variables from Data
strNames = fieldnames(param);
for i = 1:length(strNames), eval([strNames{i} '= param.' strNames{i} ';']); end
%%
figure(1111)
plot(x,AUC_Share,'r-*');
xlabel(P1); ylabel('AUC')
legend('HOGMSS','Location','SouthEast');
axis([min(x),max(x),0.4,1]);
str=[file_path,'AUC_Share.fig'];
saveas(gcf,str,'fig');

figure(2222)
plot(x,AUC_Individual1,'r-*');
xlabel(P1); ylabel('AUC')
legend('HOGMSS','Location','SouthEast');
axis([min(x),max(x),0.4,1]);
str=[file_path,'AUC_Individual1.fig'];
saveas(gcf,str,'fig');

figure(3333)
plot(x,AUC_Individual2,'r-*');
xlabel(P1); ylabel('AUC')
legend('HOGMSS','Location','SouthEast');
axis([min(x),max(x),0.4,1]);
str=[file_path,'AUC_Individual2.fig'];
saveas(gcf,str,'fig');

figure(4444)
plot(x,AUC_Individual3,'r-*');
xlabel(P1); ylabel('AUC')
legend('HOGMSS','Location','SouthEast');
axis([min(x),max(x),0.4,1]);
str=[file_path,'AUC_Individual3.fig'];
saveas(gcf,str,'fig');
close all
end

