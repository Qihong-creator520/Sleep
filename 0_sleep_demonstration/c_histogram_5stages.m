%% for Fig. 1
%% histogram of the all 5-minute epochs included in the final analysis

clc;clear
%% 
figure
set(gcf,'Units','Centimeters','position',[1 1 6 6])


Counts5=[434; 192; 943; 540; 71];

HH=bar([1],Counts5);

Color=[156,197,217; 230,169,140; 162,42,49; 89,18,29; 52,100,165]./255;

for ii=1:5
    set(HH(ii),'FaceColor',Color(ii,:))
end


ylabel('Count','FontName','Arial','fontsize',7);

set(gca, 'Xlim', [0.5 1.5],'TickDir','out','XTick', [0.68 0.85 1 1.15 1.31],'XTickLabel',{'W','N1','N2','N3','REM'});
set(gca,  'YGrid', 'off', 'box', 'off', 'TickDir', 'out','FontName','Arial','fontsize',7);


cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410

print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['histogram_5stages.pdf'];
movefile(oldname,newname);    

close all;
