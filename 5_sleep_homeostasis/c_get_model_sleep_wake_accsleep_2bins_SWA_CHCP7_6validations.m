%% get 2 stage by 2 bin model for SWA and average ALFF in 7 canonical networks
%% as well as the 6 validation analysis 

clc;clear
%% get SWA
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/EEG/
Model_N2180_power_n_all=readtable('Model_N2180_power_n_all.txt');
Meanpower = table2array(Model_N2180_power_n_all(:,8:146)); % average power over 6 channels
meanSWA = sum(Meanpower(:,2:15),2); % SWA range (0.75 - 4 Hz)


% get ALFF in CHCP7
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


%%
outpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats';
cd(outpath)
clear ALFF ALFF1
ALFFfile1 = ['all2180-volreg_MNI_bbr-dt-noGSR-residual-blur6_ALFF-ctx-z.nii.gz'];
ALFF10 = load_nifti(ALFFfile1);
dim4=size(ALFF10.vol);
ALFF1 = reshape(ALFF10.vol,[dim4(1)*dim4(2)*dim4(3) dim4(4)]);

label={'Vis','SM','DAN','VAN','Aud','FP','DMN'};

for roi = 1 : 7
    
    CHCP7(roi,:) = mean(ALFF1(mask12==roi,:),1);
end



%% 2 stages
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis
Model_N2180=readtable('Model_N2180_accsleep.txt');

for jj = 1:length(Model_N2180.Var1)

    if ~strcmp(table2cell(Model_N2180(jj,5)), 'stage0')
        stage_n{jj,1}='sleep';
    else
        stage_n{jj,1}='wake';
    end
end


%% 6 validations
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/8_validation_motion
load ID_low_high_N2180.1D
ID_low=(ID_low_high_N2180==1); sum(ID_low) % N = 1090 low motion 
ID_high=(ID_low_high_N2180==2); sum(ID_high) % N= 1090 high motion
ID_N2 = contains(Model_N2180.Var5,'stage2'); sum(ID_N2) % 943
ID_N3 = contains(Model_N2180.Var5,'stage3'); sum(ID_N3) % 540
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/9_reproducibility_subgroup
load index_g1_g2_N2180.1D
ID_g1 = (index_g1_g2_N2180==1); sum(ID_g1) % 1081
ID_g2 = (index_g1_g2_N2180==2); sum(ID_g2) % 1099


clear Model_sleep_wake_accsleep
Model_sleep_wake_accsleep=table(table2cell(Model_N2180(:,1)), ...,
                                                   table2array(Model_N2180(:,2)), ...,
                                                   table2cell(Model_N2180(:,3)), ...,
                                                   table2array(Model_N2180(:,4)), ...,
                                                   table2cell(Model_N2180(:,6)), ...,
                                                   stage_n, table2cell(Model_N2180(:,7)), ...,
                                                   meanSWA, CHCP7', ...,
                                                   ID_low, ID_high, ID_N2,ID_N3, ...,
                                                   ID_g1, ID_g2);

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis
writetable(Model_sleep_wake_accsleep,['Model_sleep_wake_accsleep_2bins_SWA_CHCP7_6validations_N2180.txt'],'Delimiter',',')

