%% for fig. S4
%% plot sleep structure of a representative participant

clc;clear
Color_5stages=[156,197,217; 230,169,140; 162,42,49; 89,18,29; 52,100,165]./255;

stagename = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/sub3117/stages/sub3117_sleep1.txt'];
    
stage_a  = load(stagename);
xlabels={'0', '0.5', '1', '1.5', '2', '2.5', '3', '3.5', '4', '4.5', '5', '5.5', '6'};

figure
set(gcf,'Units','Centimeters','position',[1 1 17.5 3])
sleep_stage=repmat(floor(stage_a),1,5);
subplot('position',[0.02    0.35    0.96    0.15])
imagesc(sleep_stage')
set(gca,'CLim',[0 4],'Colormap',Color_5stages)
box off;
axis off



ax=subplot('position',[0.02    0.349    0.96    0.001])
set(ax,'Xlim',[0 length(stage_a)+0.5],'xtick',[0:60:floor(length(stage_a)/60)*60],'xticklabel',xlabels(1:ceil(length(stage_a)/60)),'TickDir','out','fontname','Arial','fontsize',7,'color','k')
set(ax,'ylim',[0 0.001],'ytick',[0.5])
xlabel('Time (hour)','fontname','Arial','fontsize',7,'color','k'); 
    

%% set onset of each five-minute epoch according to the 'for_EEG_N2180.txt'
ax1=subplot('position',[0.02    0.53    0.96    0.25])
% W
plot(82:92,zeros(11,1),'-','color',Color_5stages(1,:),'LineWidth',1);
hold on;
plot(127:147,zeros(21,1),'-','color',Color_5stages(1,:),'LineWidth',1);
hold on;
plot(251:261,zeros(11,1),'-','color',Color_5stages(1,:),'LineWidth',1);
hold on;

% N1
plot(162:172,ones(11,1),'-','color',Color_5stages(2,:),'LineWidth',1);
hold on;

% N2
plot(13:23,2*ones(11,1),'-','color',Color_5stages(3,:),'LineWidth',1);
hold on;
plot(68:78,2*ones(11,1),'-','color',Color_5stages(3,:),'LineWidth',1);
hold on;
plot(173:203,2*ones(31,1),'-','color',Color_5stages(3,:),'LineWidth',1);
hold on;
plot(213:233,2*ones(21,1),'-','color',Color_5stages(3,:),'LineWidth',1);
hold on;

% N3
plot(31:51,3*ones(21,1),'-','color',Color_5stages(4,:),'LineWidth',1);
hold on;
plot(239:249,3*ones(11,1),'-','color',Color_5stages(4,:),'LineWidth',1);
hold on;

set(ax1,'Xlim',[0 length(stage_a)])
set(ax1,'ylim',[-0.5 3.5])

box off;
axis off

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410

print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['sub3117_stage_epoch.pdf'];
movefile(oldname,newname);    
