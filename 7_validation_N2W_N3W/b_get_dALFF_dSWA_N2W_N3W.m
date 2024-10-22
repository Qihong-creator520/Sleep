%% get dALFF and dSWA for single sleep stage validation

clc;clear
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/EEG/
Model_N2180_power_n_all=readtable('Model_N2180_power_n_all.txt');
Meanpower = table2array(Model_N2180_power_n_all(:,8:146));
SWA = sum(Meanpower(:,2:15),2);

%%
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410
Model2=readtable('Model_N2180.txt');
sub=Model2.Var1;
stage=Model2.Var5;
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

%% N2W
for ii = 1:length(sub_u)
    disp( strtrim(sub_u{ii}) )
    data_W_all=contains(stage,'stage0') .* contains(sub,sub_u{ii});
    data_N2_all=contains(stage,'stage2') .* contains(sub,sub_u{ii});
    ll(ii,1)=sum(data_W_all);
    ll(ii,2)=sum(data_N2_all);


    if ll(ii,1) > 0 && ll(ii,2) > 0 
        k = k +1;
        clear ALFF_W_all  ALFF_N2_all
        ALFF_W_all = mean(ALFF1_mask(:,data_W_all>0),2);
        ALFF_N2_all = mean(ALFF1_mask(:,data_N2_all>0),2);
        ALFF_N2W_all(:,k) = ALFF_N2_all - ALFF_W_all;
        SWA_N2W_all(k) = mean(SWA(data_N2_all>0))-mean(SWA(data_W_all>0));

    end

end


%% save N2-Wake maps N = 72
%% all
cd(outpath)
resultsmap = ALFF10;

results1 = zeros(dim4(1)*dim4(2)*dim4(3), k);
results1(mask1>0,:) = ALFF_N2W_all;

resultsmap.vol = reshape(results1,[dim(1) dim(2) dim(3) k]);
resultsfile= ['all_ALFF-ctx-z-v2_N2-Wake_all.nii.gz'];
err = save_nifti(resultsmap,resultsfile);

cd(outpath)
save all_SWA_N2W_all.1D SWA_N2W_all '-ascii'



%% N3W
for ii = 1:length(sub_u)
    disp( strtrim(sub_u{ii}) )
    data_W_all=contains(stage,'stage0') .* contains(sub,sub_u{ii});
    data_N3_all=contains(stage,'stage3') .* contains(sub,sub_u{ii});
    ll(ii,1)=sum(data_W_all);
    ll(ii,2)=sum(data_N3_all);


    if ll(ii,1) > 0 && ll(ii,2) > 0 
        l = l +1;
        clear ALFF_W_all  ALFF_N3_all
        ALFF_W_all = mean(ALFF1_mask(:,data_W_all>0),2);
        ALFF_N3_all = mean(ALFF1_mask(:,data_N3_all>0),2);
        ALFF_N3W_all(:,l) = ALFF_N3_all - ALFF_W_all;
        SWA_N3W_all(l) = mean(SWA(data_N3_all>0))-mean(SWA(data_W_all>0));

    end

end


%% save N3-Wake maps N = 53
%% all
cd(outpath)
resultsmap = ALFF10;

results2 = zeros(dim4(1)*dim4(2)*dim4(3), l);
results2(mask1>0,:) = ALFF_N3W_all;

resultsmap.vol = reshape(results2,[dim(1) dim(2) dim(3) l]);
resultsfile= ['all_ALFF-ctx-z-v2_N3-Wake_all.nii.gz'];
err = save_nifti(resultsmap,resultsfile);

cd(outpath)
save all_SWA_N3W_all.1D SWA_N3W_all '-ascii'

