%% for Fig. 2
% scatter plots between network-level dALFF and dSWA

%% get data
clc;clear  

outpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats';
cd(outpath)
dSWA = load('all_SWA_SW_all.1D');

% mask used for the main analysis
maskfile1 = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks/CHCP_Yeo2011_2mm_mask.nii.gz'];
mask10 = load_nifti(maskfile1);
dim=size(mask10.vol);
mask1 = reshape(mask10.vol,[dim(1)*dim(2)*dim(3) 1]);


% mask from CHCP
maskfile2 = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks/CHCP_Yeo7_2mm.nii.gz'];
mask20 = load_nifti(maskfile2);
dim=size(mask20.vol);
mask2 = reshape(mask20.vol,[dim(1)*dim(2)*dim(3) 1]);


mask12 = (mask1>0).*mask2;


%%% ALFF
ALFFfile1 = ['all_ALFF-ctx-z-v2_Sleep-Wake_all.nii.gz'];
ALFF10 = load_nifti(ALFFfile1);
ALFF1 = reshape(ALFF10.vol,[dim(1)*dim(2)*dim(3) 81]);



%% CHCP7
for roi = 1 : 7

    Y_data_mean(roi,:) = mean(ALFF1(mask12==roi,:),1);
    s = regstats(Y_data_mean(roi,:),dSWA,'linear',{'beta','tstat'});
    beta(1,roi) = s.beta(2);
    beta(2,roi) = s.beta(1);
    beta(3,roi) = s.tstat.pval(2);  
    [r_real p]=corr(Y_data_mean(roi,:)',dSWA','type','spearman');
    beta(4,roi) = r_real;  
    beta(5,roi) = p;  

end

CHCP7 = Y_data_mean';

Colors7=[120,18,134;70,130,180;0,118,14;196,58,250;220,248,164;230,148,34;205,62,78]./255;
%% colors for Vis, SM, DAN, VAN, Aud, FP, DMN

shown_yeo7=[6     7     4     3     5     1     2];

label={'Vis','SM','DAN','VAN','Aud','FP','DMN'};



figure
set(gcf,'Units','Centimeters','position',[1 1 17.5 5])


%% SWA_ALFF_DMN
hold on;
plot(dSWA+0.8,CHCP7(:,7),...,
        'o','MarkerSize',3,'MarkerEdgeColor',Colors7(7,:),'MarkerFaceColor',Colors7(7,:));hold on;

yfit = polyval([beta(1,7) beta(2,7)-0.8*beta(1,7)],dSWA+0.8);
hold on;plot(dSWA+0.8,yfit,'--','color','k','LineWidth',1);

txt={'{\beta} = -0.31'};
t=text(0.8,1.05,txt,'left');
t.FontSize=7;t.FontName='Arial';t.Color='k'


%% SWA_ALFF_FP

hold on;
plot(dSWA,CHCP7(:,6),...,
        'o','MarkerSize',3,'MarkerEdgeColor',Colors7(6,:),'MarkerFaceColor',Colors7(6,:));hold on;

yfit = polyval([beta(1,6) beta(2,6)],dSWA);
hold on;plot(dSWA,yfit,'--','color','k','LineWidth',1);

txt={'{\beta} = -0.50'};
t=text(0,1.05,txt,'left');
t.FontSize=7;t.FontName='Arial';t.Color='k'




%% SWA_ALFF_VAN
hold on;
plot(dSWA+1.6,CHCP7(:,4),...,
        'o','MarkerSize',3,'MarkerEdgeColor',Colors7(4,:),'MarkerFaceColor',Colors7(4,:));hold on;

yfit = polyval([beta(1,4) beta(2,4)-1.6*beta(1,4)],dSWA+1.6);
hold on;plot(dSWA+1.6,yfit,'--','color','k','LineWidth',1);

txt={'{\beta} = -0.16'};
t=text(1.6,1.05,txt,'left');
t.FontSize=7;t.FontName='Arial';t.Color='k'



%% SWA_ALFF_DAN
hold on;
plot(dSWA+2.4,CHCP7(:,3),...,
        'o','MarkerSize',3,'MarkerEdgeColor',Colors7(3,:),'MarkerFaceColor',Colors7(3,:));hold on;

yfit = polyval([beta(1,3) beta(2,3)-2.4*beta(1,3)],dSWA+2.4);
hold on;plot(dSWA+2.4,yfit,'--','color','k','LineWidth',1);

txt={'{\beta} = 0.05'};
t=text(2.4,1.05,txt,'left');
t.FontSize=7;t.FontName='Arial';t.Color='k'




%% SWA_ALFF_Aud
hold on;
plot(dSWA+3.2,CHCP7(:,5),...,
        'o','MarkerSize',3,'MarkerEdgeColor',Colors7(5,:),'MarkerFaceColor',Colors7(5,:));hold on;

yfit = polyval([beta(1,5) beta(2,5)-3.2*beta(1,5)],dSWA+3.2);
hold on;plot(dSWA+3.2,yfit,'--','color','k','LineWidth',1);

txt={'{\beta} = 0.51'};
t=text(3.2,1.05,txt,'left');
t.FontSize=7;t.FontName='Arial';t.Color='k'




%% SWA_ALFF_SM
hold on;
plot(dSWA+4.8,CHCP7(:,2),...,
        'o','MarkerSize',3,'MarkerEdgeColor',Colors7(2,:),'MarkerFaceColor',Colors7(2,:));hold on;

yfit = polyval([beta(1,2) beta(2,2)-4.8*beta(1,2)],dSWA+4.8);
hold on;plot(dSWA+4.8,yfit,'--','color','k','LineWidth',1);

txt={'{\beta} = 0.74'};
t=text(4.8,1.05,txt,'left');
t.FontSize=7;t.FontName='Arial';t.Color='k'


%% SWA_ALFF_Vis
hold on;
plot(dSWA+4,CHCP7(:,1),...,
        'o','MarkerSize',3,'MarkerEdgeColor',Colors7(1,:),'MarkerFaceColor',Colors7(1,:));hold on;

yfit = polyval([beta(1,1) beta(2,1)-4*beta(1,1)],dSWA+4);
hold on;plot(dSWA+4,yfit,'--','color','k','LineWidth',1);

txt={'{\beta} = 0.74'};
t=text(4,1.05,txt,'left');
t.FontSize=7;t.FontName='Arial';t.Color='k'


set(gca,'fontname','Arial','fontsize',7,'box','off','TickDir','out')
ylabel('Network-level {\Delta} ALFF','fontname','Arial','fontsize',7);
xlabel(' {\Delta} SWA','fontname','Arial','fontsize',7);
set(gca,'XLim',[-0.2 5.4])
set(gca,'xtick',[0 0.4 0.8 1.2 1.6 2.0 2.4 2.8 3.2 3.6 4.0 4.4 4.8 5.2],'xticklabel',{'0','0.4','0','0.4','0','0.4','0','0.4','0','0.4','0','0.4','0','0.4'},'FontName','Arial','fontsize',7,'Tickdir','out')
set(gca,'YLim',[-0.55 1.1],'ytick',[-0.5:0.5:1])
set(gca,'looseInset',[0.05 0.02 0.05 0.02])

hold on
plot([-0.2 -0.1],[-0.55 -0.55],'-','color','w','LineWidth',1);
hold on
plot([0.5 0.7],[-0.55 -0.55],'-','color','w','LineWidth',1);
hold on
plot([1.3 1.5],[-0.55 -0.55],'-','color','w','LineWidth',1);
hold on
plot([2.1 2.3],[-0.55 -0.55],'-','color','w','LineWidth',1);
hold on
plot([2.9 3.1],[-0.55 -0.55],'-','color','w','LineWidth',1);
hold on
plot([3.7 3.9],[-0.55 -0.55],'-','color','w','LineWidth',1);
hold on
plot([4.5 4.7],[-0.55 -0.55],'-','color','w','LineWidth',1);
hold on
plot([5.3 5.4],[-0.55 -0.55],'-','color','w','LineWidth',1);



outpath = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/4_SWA_association'];
cd(outpath)

print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['dALFF_dSWA_CHCP7_N81.pdf'];
movefile(oldname,newname);    

close all;





