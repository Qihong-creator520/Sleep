%% for Fig. 1
%% plot sleep-wake probability during the sleep EEG-fMRI scan 

clc;clear
figure
set(gcf,'Units','Centimeters','position',[1 1 11 6])
Color=[156,197,217; 230,169,140; 162,42,49; 89,18,29; 52,100,165]./255;
Colors2=[156,197,217; mean([230,169,140; 162,42,49; 89,18,29; 52,100,165])]./255;

%%%
subplot('position',[0.07 0.1  0.30  0.8])

cd('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/0_sleep_demonstration');
load duration_sleep_stages.mat

duration_sleep_2stages(1,1) = duration_sleep_stages(:,1);
Sleep = cell2mat(duration_sleep_stages(:,2))+cell2mat(duration_sleep_stages(:,3))+cell2mat(duration_sleep_stages(:,4))+cell2mat(duration_sleep_stages(:,5));
duration_sleep_2stages(1,2) = mat2cell(Sleep,130);

gretna_plot_violin(duration_sleep_2stages,{'W','Sleep'},{' '},'meanstdfill')

set(gca,'FontName','Arial','fontsize',7,'Tickdir','out')
set(gca,'Ylim',[0 300]./60,'ytick',[0:1:5])
ylabel('Duration (hour)','FontName','Arial','fontsize',7)
legend('off')

set(gca,'xtick',1:1:2,'xticklabel',{'W','Sleep'})



%%

subplot('position',[0.47 0.15  0.50  0.8])
cd('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/0_sleep_demonstration');
load prob_stgs.txt

W=plot(prob_stgs(1,1:60:660)*100','-','color',Colors2(1,:),'linewidth',1);%W
hold on;Sleep=plot((sum(prob_stgs(2:5,1:60:660),1)*100)','-','color',Colors2(2,:),'linewidth',1);%Sleep



set(gca,'FontName','Arial','fontsize',7,'box','off','Tickdir','out');
xlabel('Time (hour)','FontName','Arial','fontsize',7);ylabel('Probability (%)','FontName','Arial','fontsize',7);
set(gca,'Ylim',[0 100],'ytick',[0:15:90])
set(gca,'Xlim',[0.5 11.5],'xtick',[2:2:10],'xticklabel',{'1','2'})
hl=legend('W','Sleep','FontName','Arial','fontsize',7,'NumColumns',2);
set(hl,'Box','off');
hl.ItemTokenSize(1) = 8;




cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410

print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['sleep_structure_probability_2stages.pdf'];
movefile(oldname,newname);    

close all;

