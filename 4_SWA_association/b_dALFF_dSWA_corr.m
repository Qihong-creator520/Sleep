%% get voxel-wise regression beta values between dALFF and dSWA
%% also save residuals for cluster size estimation in afni
clc;clear

outpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats';
cd(outpath)
dSWA = load('all_SWA_SW_all.1D');

% mask used for the main analysis
maskfile1 = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks/CHCP_Yeo2011_2mm_mask.nii.gz'];
mask10 = load_nifti(maskfile1);
dim=size(mask10.vol);
mask1 = reshape(mask10.vol,[dim(1)*dim(2)*dim(3) 1]);
mask1(mask1>0)=1;


%%% ALFF
ALFFfile1 = ['all_ALFF-ctx-z-v2_Sleep-Wake_all.nii.gz'];
ALFF10 = load_nifti(ALFFfile1);
ALFF1 = reshape(ALFF10.vol,[dim(1)*dim(2)*dim(3) 81]);


%% voxel-wise
ALFF1_mask = ALFF1(find(mask1>0),:);
for kkk = 1:sum(mask1)
    kkk
    s = regstats(ALFF1_mask(kkk,:),dSWA,'linear',{'beta','tstat','r'});
    beta_all(kkk,1) = s.beta(2);
    beta_all(kkk,2) = s.tstat.pval(2);
    resid(kkk,:) = s.r;
end


%% save beta map
%% 
cd(outpath)
resultsmap = ALFF10;

results1 = zeros(dim(1)*dim(2)*dim(3), 2);
results1(mask1>0,:) = beta_all;

resultsmap.vol = reshape(results1,[dim(1) dim(2) dim(3) 2]);
resultsfile= ['all_ALFF-v2_Sleep-Wake_all_SWA_SW_all_beta.nii.gz'];
err = save_nifti(resultsmap,resultsfile);


%% save residual map for cluster size estimation
%%
residmap = ALFF10;

resid1 = zeros(dim(1)*dim(2)*dim(3), 81);
resid1(mask1>0,:) = resid;

residmap.vol = reshape(resid1,[dim(1) dim(2) dim(3) 81]);
residfile= ['all_ALFF-v2_Sleep-Wake_all_SWA_SW_all_resid.nii.gz'];
err = save_nifti(residmap,residfile);



