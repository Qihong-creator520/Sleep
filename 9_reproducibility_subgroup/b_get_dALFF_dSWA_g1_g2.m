%% get dALFF and dSWA for two subgroups

clc;clear
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/EEG/
Model_N2180_power_n_all=readtable('Model_N2180_power_n_all.txt');
Meanpower = table2array(Model_N2180_power_n_all(:,8:146));
SWA = sum(Meanpower(:,2:15),2);

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/EEG/
Model_SWA_N2180=readtable('Model_sleep_wake_accsleep_2bins_SWA_6validations_N2180_n.txt');
index = Model_SWA_N2180.ID_g1>0;


%%
sub=Model_SWA_N2180.Var1;
stage=Model_SWA_N2180.stage_n;
sub_u=unique(sub);

outpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats';
cd(outpath)
clear ALFF ALFF1
ALFFfile1 = ['all2180-volreg_MNI_bbr-dt-noGSR-residual-blur6_ALFF-ctx-z.nii.gz'];
ALFF10 = load_nifti(ALFFfile1);
dim4=size(ALFF10.vol);
ALFF1 = reshape(ALFF10.vol,[dim4(1)*dim4(2)*dim4(3) dim4(4)]);

%%
maskfile1 = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks/CHCP_Yeo2011_2mm_mask.nii.gz'];
mask10 = load_nifti(maskfile1);
dim=size(mask10.vol);
mask1 = reshape(mask10.vol,[dim(1)*dim(2)*dim(3) 1]);
mask1(mask1>0)=1;

ALFF1_mask = ALFF1(find(mask1>0),:);
k=0;
l=0;

%% g1
for ii = 1:length(sub_u)
    disp( strtrim(sub_u{ii}) )
    data_W_g1=contains(stage,'wake') .* contains(sub,sub_u{ii}) .* index;
    data_S_g1 = contains(sub,sub_u{ii}) .* index - data_W_g1;
    ll(ii,1)=sum(data_W_g1);
    ll(ii,2)=sum(data_S_g1);


    if ll(ii,1) > 0 && ll(ii,2) > 0 
        k = k +1;
        clear ALFF_W_g1  ALFF_S_g1
        ALFF_W_g1 = mean(ALFF1_mask(:,data_W_g1>0),2);
        ALFF_S_g1 = mean(ALFF1_mask(:,data_S_g1>0),2);
        ALFF_SW_g1(:,k) = ALFF_S_g1 - ALFF_W_g1;
        SWA_SW_g1(k) = mean(SWA(data_S_g1>0))-mean(SWA(data_W_g1>0));

    end

end


%% save Sleep-Wake maps N = 39
%% g1
cd(outpath)
resultsmap = ALFF10;

results1 = zeros(dim4(1)*dim4(2)*dim4(3), k);
results1(mask1>0,:) = ALFF_SW_g1;

resultsmap.vol = reshape(results1,[dim(1) dim(2) dim(3) k]);
resultsfile= ['all_ALFF-ctx-z-v2_Sleep-Wake_g1.nii.gz'];
err = save_nifti(resultsmap,resultsfile);

cd(outpath)
save all_SWA_SW_g1.1D SWA_SW_g1 '-ascii'




%% g2
index = Model_SWA_N2180.ID_g2>0;
for ii = 1:length(sub_u)
    disp( strtrim(sub_u{ii}) )
    data_W_g2=contains(stage,'wake') .* contains(sub,sub_u{ii}) .* index;
    data_S_g2 = contains(sub,sub_u{ii}) .* index - data_W_g2;
    ll(ii,1)=sum(data_W_g2);
    ll(ii,2)=sum(data_S_g2);


    if ll(ii,1) > 0 && ll(ii,2) > 0 
        l = l +1;
        clear ALFF_W_g2  ALFF_S_g2
        ALFF_W_g2 = mean(ALFF1_mask(:,data_W_g2>0),2);
        ALFF_S_g2 = mean(ALFF1_mask(:,data_S_g2>0),2);
        ALFF_SW_g2(:,l) = ALFF_S_g2 - ALFF_W_g2;
        SWA_SW_g2(l) = mean(SWA(data_S_g2>0))-mean(SWA(data_W_g2>0));

    end

end


%% save Sleep-Wake maps N = 42
%% g2
cd(outpath)
resultsmap = ALFF10;

results2 = zeros(dim4(1)*dim4(2)*dim4(3), l);
results2(mask1>0,:) = ALFF_SW_g2;

resultsmap.vol = reshape(results2,[dim(1) dim(2) dim(3) l]);
resultsfile= ['all_ALFF-ctx-z-v2_Sleep-Wake_g2.nii.gz'];
err = save_nifti(resultsmap,resultsfile);

cd(outpath)
save all_SWA_SW_g2.1D SWA_SW_g2 '-ascii'

