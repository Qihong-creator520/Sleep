%% for Fig. 1
%% violin plot of sleep-related changes in 7 canonical networks, using GRETNA
%% https://www.nitrc.org/projects/gretna/

clc;clear
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


outpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats';
cd(outpath)
%%% lme
lmefile1 = ['lme_ALFF-ctx-z_2stages_age_gender_edu_N2180-s.nii.gz'];
lme10 = load_nifti(lmefile1);
lme1 = reshape(lme10.vol,[dim(1)*dim(2)*dim(3) 10]);

beta=lme1(:,9); % Sleep vs. W

for roi = 1 : 7

    Y_data{1,roi} = beta(mask12==roi,1);
    Y_data_mean(roi) = mean(beta(mask12==roi,:),1);

end

% % sorted by average beta values in CHCP7
% [tmp order_yeo7] = sort(Y_data_mean,'ascend');
% sorted by Sleep vs. W contrast
order_yeo7=[7     6     4     3     5     2     1];

label={'Vis','SM','DAN','VAN','Aud','FP','DMN'};



figure
set(gcf,'Units','Centimeters','position',[1 1 6 5.5])
hold on;
plot(0:8,zeros(1,9),'--','color',[0.8 0.8 0.8],'linewidth',1);

%% first config gretna_plot_violin 'Color' as colors for the reordered 7 networks
%% then run
gretna_plot_violin(Y_data(order_yeo7),label(order_yeo7),{' '},'meanstdfill')

set(gca,'FontName','Arial','fontsize',7,'Tickdir','out')
set(gca,'Ylim',[-1 1.3],'ytick',[-1:1:1])
ylabel('{\Delta} ALFF','FontName','Arial','fontsize',7)
legend('off')

set(gca,'xtick',1:1:7,'xticklabel',label(order_yeo7))
set(gca,'looseInset',[0.05 0.02 0 0.02])

outpath = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/3_sleep_reorganization'];
cd(outpath)


print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['Sleep_W_ALFF_CHCP7.pdf'];
movefile(oldname,newname);    

close all;


