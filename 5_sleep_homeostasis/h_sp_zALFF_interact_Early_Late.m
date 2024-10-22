%% for Fig. 3
%% scatter plot between sleep-related changes in late and early sleep periods

%% downsample for plot
clc;clear

% 5378 voxels
maskfile1 = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks/CHCP_Yeo2011_6mm_mask.nii.gz'];
mask10 = load_nifti(maskfile1);
dim=size(mask10.vol);
mask1 = reshape(mask10.vol,[dim(1)*dim(2)*dim(3) 1]);


outpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats';
cd(outpath)
%%% lme
lmefile1 = ['lme_ALFF-ctx-z_2stages_2bins-N2180_accsleep_age_gender_edu-s-v6.nii.gz'];
lme10 = load_nifti(lmefile1);
lme1 = reshape(lme10.vol,[dim(1)*dim(2)*dim(3) 14]);

lme1_mask = lme1(find(mask1>0),[11 13]);


[r_real p]=corr(lme1_mask(:,1),lme1_mask(:,2),'type','spearman');
% [r_real p]
% ans =
% 
%    0.9597         0 % v6 of Early vs. Late


s_real = regstats(lme1_mask(:,2),lme1_mask(:,1),'linear',{'beta','tstat'}); % real beta
s_real.beta
%     -0.0005
%     0.8219
s_real.tstat.pval(2)
%     0

s_1 = regstats(lme1_mask(:,2)-lme1_mask(:,1),lme1_mask(:,1),'linear',{'beta','tstat'}); % compared to beta = 1 
s_1.beta
%     -0.0005
%    -0.1781
s_1.tstat.pval(2)




[lme_sorted, lme_order] = sort(lme1_mask(:,2));

lme_deciles = prctile(lme_sorted,1:1:99);
range= [min(lme_sorted) lme_deciles max(lme_sorted)+0.0001];


% scatter plot
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410
color=ROY_BIG_BL(256);
color=flipud(color);
color_deciles = prctile(1:1:256,100/99:100/99:9800/99);
color_range=floor([1 color_deciles 256]);


figure
set(gcf,'Units','Centimeters','position',[1 1 5.5 5.5])


for i = 1:100
    
    index = find(lme1_mask(:,2)<range(102-i) & lme1_mask(:,2)>=range(101-i));
    X_data = lme1_mask(index,1);
    Y_data = lme1_mask(index,2);

    plot(X_data,Y_data,'o','MarkerSize',3,'MarkerEdgeColor',color(color_range(i),:),'MarkerFaceColor',color(color_range(i),:));hold on;

end

p = polyfit(lme1_mask(:,1),lme1_mask(:,2),1);
yfit = polyval(p,lme1_mask(:,1));
hold on;plot(lme1_mask(:,1),yfit,'-k','LineWidth',1.5);
hold on;plot(lme1_mask(:,1),lme1_mask(:,1),'-','LineWidth',1.5,'Color',[0.7 0.7 0.7]);


set(gca,'fontname','Arial','fontsize',7)
ax = gca;
set(ax, 'xtick',-1:1:2, 'ytick',-1:1:2);
xlabel('{\Delta} ALFF_{Early}','fontname','Arial','fontsize',7);
ylabel('{\Delta} ALFF_{Late}','fontname','Arial','fontsize',7);
set(gca,'Box','off');
set(gca,'XLim',[-1.6 2.1])
set(gca,'YLim',[-1.6 2.1])
set(gca,'box','off','TickDir','out')

txt={'{\it{y}} = 0.82{\it{x}}'}; %
t=text(1.3,0.7,txt,'left');
t.FontSize=7;t.FontName='Arial';t.Color='k'

txt={'{\it{y}} = {\it{x}}'}; %
t=text(0.9,1.6,txt,'left');
t.FontSize=7;t.FontName='Arial';t.Color=[0.7 0.7 0.7]


outpath = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis'];
cd(outpath)


print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['accsleep_ALFF_Early_Late_v6_100prctiles.pdf'];
movefile(oldname,newname);    

close all;

