%% nuisance regression

clc;clear
fid=fopen('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/filelist-all2461.txt');
session=textscan(fid,'%s');
fclose(fid);

rtpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/Five-min-sessions';
cd(rtpath);


%%%
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/2_ALFF_calculation
residual(rtpath,session,'nuisance_regressors.1D')


