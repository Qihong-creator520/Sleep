%% for fig. S1
%% plot light sleep - deep sleep - REM sleep - wake probability during whole sleep recordingby PSG and portable sleep device

clc;clear
figure
set(gcf,'Units','Centimeters','position',[1 1 17 6])
set(gca,'looseInset',[0 0 0.05 0.05])

Color4=[156,197,217; 196,105,95; 89,18,29; 52,100,165]./255;

%%% plot sleep structure of psg/umind
%%%
subplot('position',[0.05 0.15  0.30  0.75])

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/0_sleep_demonstration
load wholenight_sleep_duration.mat

a(:,1)=wholenight_sleep_duration{1};
a(:,2)=wholenight_sleep_duration{2};
a(:,3)=wholenight_sleep_duration{3};
a(:,4)=wholenight_sleep_duration{4};
mean(sum(a,2))
%    7.1035
mean(a)./sum(mean(a))
%    0.0848    0.5803    0.1573    0.1777

gretna_plot_violin(wholenight_sleep_duration,{'W','N1/N2','N3','REM'},{' '},'meanstdfill')

set(gca,'FontName','Arial','fontsize',7,'Tickdir','out')
set(gca,'Ylim',[0 420]./60,'ytick',[0:1:7])
set(gca,'xtick',1:1:4,'xticklabel',{'W','N1/N2','N3','REM'})
xlabel('Sleep stage','FontName','Arial','fontsize',7);
ylabel('Duration (hour)','FontName','Arial','fontsize',7)
legend('off')



%%%
% plot 4 stages with N1 and N2 combined
subplot('position',[0.45 0.15  0.50 0.75])
cd('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/0_sleep_demonstration');
load wholenight_sleep_prob_stgs.txt


W=plot(wholenight_sleep_prob_stgs(1,1:60:1020)*100','-','color',Color4(1,:),'linewidth',1);%W
hold on;N1N2=plot(wholenight_sleep_prob_stgs(2,1:60:1020)*100','-','color',Color4(2,:),'linewidth',1);%N1N2
hold on;N3=plot(wholenight_sleep_prob_stgs(3,1:60:1020)*100','-','color',Color4(3,:),'linewidth',1);%N3
hold on;REM=plot(wholenight_sleep_prob_stgs(4,1:60:1020)*100','-','color',Color4(4,:),'linewidth',1);%R



set(gca,'FontName','Arial','fontsize',7,'box','off','Tickdir','out');
set(gca,'Ylim',[0 100],'ytick',[0:15:90])
set(gca,'Xlim',[0.5 16.5],'xtick',[2:2:16],'xticklabel',{'1','2','3','4','5','6','7','8'})
xlabel('Time (hour)','FontName','Arial','fontsize',7);
ylabel('Probability (%)','FontName','Arial','fontsize',7);
hl=legend('W','N1/N2','N3','REM','FontName','Arial','fontsize',7);
set(hl,'Box','off');






cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/

print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['wholenight_sleep_structure_probability.pdf'];
movefile(oldname,newname);    

close all;
