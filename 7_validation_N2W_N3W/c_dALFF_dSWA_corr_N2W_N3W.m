%% calculate dALFF-dSWA correlation for single sleep stage validation

%% N2W
clc;clear

outpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats';
cd(outpath)
dSWA = load('all_SWA_N2W_all.1D');

% mask used for the main analysis
maskfile1 = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks/CHCP_Yeo2011_2mm_mask.nii.gz'];
mask10 = load_nifti(maskfile1);
dim=size(mask10.vol);
mask1 = reshape(mask10.vol,[dim(1)*dim(2)*dim(3) 1]);
mask1(mask1>0)=1;


%%% ALFF
ALFFfile1 = ['all_ALFF-ctx-z-v2_N2-Wake_all.nii.gz'];
ALFF10 = load_nifti(ALFFfile1);
ALFF1 = reshape(ALFF10.vol,[dim(1)*dim(2)*dim(3) 72]);


%% voxel-wise
ALFF1_mask = ALFF1(find(mask1>0),:);
for kkk = 1:sum(mask1)
    kkk
    s = regstats(ALFF1_mask(kkk,:),dSWA,'linear',{'beta','tstat'});
    beta_all(kkk,1) = s.beta(2);
    beta_all(kkk,2) = s.tstat.pval(2);
end


%% save beta map
%% 
cd(outpath)
resultsmap = ALFF10;

results1 = zeros(dim(1)*dim(2)*dim(3), 2);
results1(mask1>0,:) = beta_all;

resultsmap.vol = reshape(results1,[dim(1) dim(2) dim(3) 2]);
resultsfile= ['all_ALFF-v2_N2-Wake_all_SWA_N2W_all_beta.nii.gz'];
err = save_nifti(resultsmap,resultsfile);


%% N3W
clc;clear

outpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats';
cd(outpath)
dSWA = load('all_SWA_N3W_all.1D');

% mask used for the main analysis
maskfile1 = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks/CHCP_Yeo2011_2mm_mask.nii.gz'];
mask10 = load_nifti(maskfile1);
dim=size(mask10.vol);
mask1 = reshape(mask10.vol,[dim(1)*dim(2)*dim(3) 1]);
mask1(mask1>0)=1;


%%% ALFF
ALFFfile1 = ['all_ALFF-ctx-z-v2_N3-Wake_all.nii.gz'];
ALFF10 = load_nifti(ALFFfile1);
ALFF1 = reshape(ALFF10.vol,[dim(1)*dim(2)*dim(3) 53]);


%% voxel-wise
ALFF1_mask = ALFF1(find(mask1>0),:);
for kkk = 1:sum(mask1)
    kkk
    s = regstats(ALFF1_mask(kkk,:),dSWA,'linear',{'beta','tstat'});
    beta_all(kkk,1) = s.beta(2);
    beta_all(kkk,2) = s.tstat.pval(2);
end


%% save beta map
%% 
cd(outpath)
resultsmap = ALFF10;

results1 = zeros(dim(1)*dim(2)*dim(3), 2);
results1(mask1>0,:) = beta_all;

resultsmap.vol = reshape(results1,[dim(1) dim(2) dim(3) 2]);
resultsfile= ['all_ALFF-v2_N3-Wake_all_SWA_N3W_all_beta.nii.gz'];
err = save_nifti(resultsmap,resultsfile);

