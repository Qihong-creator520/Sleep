%% get 2 stage by 2 sw_history bin model for all the included 5-minute epochs

%%
clc;clear
Model_N2180=readtable('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/Model_N2180.txt');
filename=Model_N2180.Var7;
Model_N2461_accsleep=readtable('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/Model_sleep_wake_N2461.txt');
SW_history_N2461=load('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/SW_history_N2461.txt');

for jj = 1:length(Model_N2180.Var7)
    filename1 = Model_N2180.Var7(jj);
    filename = filename1{1}(1:22);

    index = contains(Model_N2461_accsleep.Var8,filename);
    index_N2180(jj,1) = find(index>0);

end

SW_history_N2180 = SW_history_N2461(index_N2180,:);
Model_N2180_accsleep = Model_N2461_accsleep(index_N2180,:);

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis
save -ascii SW_history_N2180.txt SW_history_N2180

writetable(Model_N2180_accsleep,'Model_N2180_accsleep.txt','Delimiter',',')



%% run 3dLMEr in afni

      

        
