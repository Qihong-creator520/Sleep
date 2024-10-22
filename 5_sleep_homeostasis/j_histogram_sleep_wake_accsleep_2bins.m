%% for fig. S6
%% plot the histogram of data adoted in the stage by accumulated sleep LME analysis

clc;clear
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis
Model_N2180_accsleep=readtable('Model_N2180_accsleep.txt');


%% 2 bins
figure
set(gcf,'Units','Centimeters','position',[1 1 5 5])

sum(contains(Model_N2180_accsleep.Var5,'stage4').*contains(Model_N2180_accsleep.sw_history_2bins,'oneless'))
% 262
sum(contains(Model_N2180_accsleep.Var5,'stage4').*contains(Model_N2180_accsleep.sw_history_2bins,'onemore'))
% 172
Counts5=[262 172; 123 69; 351 592; 368 172; 3 68];

HH=bar([1 2],Counts5);
Gname={'Early','Late'};

Color=[156,197,217; 230,169,140; 162,42,49; 89,18,29; 52,100,165]./255;

for ii=1:5
    set(HH(ii),'FaceColor',Color(ii,:))
end


ylabel('Count','FontName','Arial','fontsize',7);
set(gca,  'xtick', 1:2, 'xticklabel',Gname, 'YGrid', 'off', 'box', 'off', 'TickDir', 'out','FontName','Arial','fontsize',7);

set(gca, 'Xlim', [0.3 2.8]);
hl=legend('W','N1','N2','N3','REM','FontName','Arial','fontsize',7);
set(hl,'Box','off');
hl.ItemTokenSize(1) = 6;
legend('Position',[0.80 0.66 0.1 0.1],'box','off','Orientation','Vertical', 'NumColumns',1)



cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis

print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['histogram_sw_history_2bins_5stages.pdf'];
movefile(oldname,newname);    

close all;




