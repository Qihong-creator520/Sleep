%% get dALFF and dSWA for low- and high-motion data

clc;clear
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/EEG/
Model_N2180_power_n_all=readtable('Model_N2180_power_n_all.txt');
Meanpower = table2array(Model_N2180_power_n_all(:,8:146));
SWA = sum(Meanpower(:,2:15),2);

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/EEG/
Model_SWA_N2180=readtable('Model_sleep_wake_accsleep_2bins_SWA_6validations_N2180.txt');
index = Model_SWA_N2180.ID_low>0;


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

%% low
for ii = 1:length(sub_u)
    disp( strtrim(sub_u{ii}) )
    data_W_low=contains(stage,'wake') .* contains(sub,sub_u{ii}) .* index;
    data_S_low = contains(sub,sub_u{ii}) .* index - data_W_low;
    ll(ii,1)=sum(data_W_low);
    ll(ii,2)=sum(data_S_low);


    if ll(ii,1) > 0 && ll(ii,2) > 0 
        k = k +1;
        clear ALFF_W_low  ALFF_S_low
        ALFF_W_low = mean(ALFF1_mask(:,data_W_low>0),2);
        ALFF_S_low = mean(ALFF1_mask(:,data_S_low>0),2);
        ALFF_SW_low(:,k) = ALFF_S_low - ALFF_W_low;
        SWA_SW_low(k) = mean(SWA(data_S_low>0))-mean(SWA(data_W_low>0));

    end

end


%% save Sleep-Wake maps N = 51
%% low
cd(outpath)
resultsmap = ALFF10;

results1 = zeros(dim4(1)*dim4(2)*dim4(3), k);
results1(mask1>0,:) = ALFF_SW_low;

resultsmap.vol = reshape(results1,[dim(1) dim(2) dim(3) k]);
resultsfile= ['all_ALFF-ctx-z-v2_Sleep-Wake_low.nii.gz'];
err = save_nifti(resultsmap,resultsfile);

cd(outpath)
save all_SWA_SW_low.1D SWA_SW_low '-ascii'




%% high
index = Model_SWA_N2180.ID_high>0;
for ii = 1:length(sub_u)
    disp( strtrim(sub_u{ii}) )
    data_W_high=contains(stage,'wake') .* contains(sub,sub_u{ii}) .* index;
    data_S_high = contains(sub,sub_u{ii}) .* index - data_W_high;
    ll(ii,1)=sum(data_W_high);
    ll(ii,2)=sum(data_S_high);


    if ll(ii,1) > 0 && ll(ii,2) > 0 
        l = l +1;
        clear ALFF_W_high  ALFF_S_high
        ALFF_W_high = mean(ALFF1_mask(:,data_W_high>0),2);
        ALFF_S_high = mean(ALFF1_mask(:,data_S_high>0),2);
        ALFF_SW_high(:,l) = ALFF_S_high - ALFF_W_high;
        SWA_SW_high(l) = mean(SWA(data_S_high>0))-mean(SWA(data_W_high>0));

    end

end


%% save Sleep-Wake maps N = 48
%% high
cd(outpath)
resultsmap = ALFF10;

results2 = zeros(dim4(1)*dim4(2)*dim4(3), l);
results2(mask1>0,:) = ALFF_SW_high;

resultsmap.vol = reshape(results2,[dim(1) dim(2) dim(3) l]);
resultsfile= ['all_ALFF-ctx-z-v2_Sleep-Wake_high.nii.gz'];
err = save_nifti(resultsmap,resultsfile);

cd(outpath)
save all_SWA_SW_high.1D SWA_SW_high '-ascii'

