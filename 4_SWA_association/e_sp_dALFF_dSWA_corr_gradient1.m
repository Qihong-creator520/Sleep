%% for Fig. 2
%% scatter plot between inter-individual dALFF-dSWA correlation and the principal gradient

%% downsample for plot
clc;clear

% 5378 voxels
maskfile1 = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks/CHCP_Yeo2011_6mm_mask.nii.gz'];
mask10 = load_nifti(maskfile1);
dim=size(mask10.vol);
mask1 = reshape(mask10.vol,[dim(1)*dim(2)*dim(3) 1]);

% mask of gradient1 from Daniel S. Margulies PNAS 2016
maskfile2 = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/Gradients_Margulies2016/volumes/masks/grad_1/sum_All20-6mm.nii.gz'];
mask20 = load_nifti(maskfile2);
mask2 = reshape(mask20.vol,[dim(1)*dim(2)*dim(3) 1]);

mask12 = mask1.*mask2;



%% load beta
outpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats';
cd(outpath)
%%% beta
betafile1 = ['all_ALFF-v6_Sleep-Wake_all_SWA_SW_all_beta.nii.gz'];
beta10 = load_nifti(betafile1);
beta1 = reshape(beta10.vol,[dim(1)*dim(2)*dim(3) 2]);

beta1_mask = beta1(find(mask12>0),1);


%% load gradient1 from Daniel S. Margulies PNAS 2016
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/Gradients_Margulies2016/volumes
real=load('grad1_CHCP_Yeo2011_6mm.txt');


[r_real p]=corr(beta1_mask,real,'type','spearman');
% [r_real p]
% ans =
% 
%    -0.6835         0 % PNAS 2016 v6

%% load surrogate maps 
load surrogate_maps_grad1_CHCP_Yeo2011_6mm_resample.mat;

[r_surr p_surr]=corr(beta1_mask,surrogate_maps','type','spearman');

p1=mean((r_real)>(r_surr));
p2=p1;
p2(find(p2>0.5))=1-p2(find(p2>0.5))
% 0




[beta_sorted, beta_order] = sort(beta1_mask);

beta_deciles = prctile(beta_sorted,1:1:99);
range= [min(beta_sorted) beta_deciles max(beta_sorted)+0.0001];


% scatter plot
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410
color = COOL_WARM(256); % Colormap 
color_deciles = prctile(1:1:256,100/99:100/99:9800/99);
color_range=floor([1 color_deciles 256]);


figure
set(gcf,'Units','Centimeters','position',[1 1 5 5.5])


for i = 1:100
    
    index = find(beta1_mask<range(102-i) & beta1_mask>=range(101-i));
    X_data = real(index);
    Y_data = beta1_mask(index);

    plot(X_data,Y_data,'o','MarkerSize',3,'MarkerEdgeColor',color(color_range(i),:),'MarkerFaceColor',color(color_range(i),:));hold on;

end

p = polyfit(real,beta1_mask,1);
yfit = polyval(p,real);
hold on;plot(real,yfit,'-w','LineWidth',1.5);


set(gca,'fontname','Arial','fontsize',7)
ax = gca;
set(ax, 'xtick',-6:3:6, 'ytick',-3:3:3);
xlabel('Principal functional gradient','fontname','Arial','fontsize',7);
ylabel('{\beta}','fontname','Arial','fontsize',7);
set(gca,'Box','off');
set(gca,'XLim',[-6 7.4])
set(gca,'YLim',[-4 5.5])
set(gca,'box','off','TickDir','out')




% from spin model
txt={'{\it{r}} = -0.68','{\it{P}} < 0.0001'}; % use r from v6 data
t=text(3.0,4.8,txt,'left');
t.FontSize=7;t.FontName='Arial';t.Color='k'


outpath = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/4_SWA_association'];
cd(outpath)


print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['dALFF_dSWA_corr_gradient1_Margulies_v6_100prctiles.pdf'];
movefile(oldname,newname);    

close all;

