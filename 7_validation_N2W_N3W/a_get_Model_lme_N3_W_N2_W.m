%% prepare LME models for single sleep stage validation

clc;clear
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis/
Model2=readtable('Model_N2180_accsleep.txt');

%%
ID_N3_W = strcmp(table2cell(Model2(:,5)),'stage3') + strcmp(table2cell(Model2(:,5)),'stage0'); % ID_N3 + ID_W
Model_N3_W=[];

clear sub stage session sw_history_2bins age gender edu

%%%
subj=array2table([Model2.Var1(ID_N3_W>0)]);
subj.Properties.VariableNames{1} = 'subj';
stage=array2table([Model2.Var5(ID_N3_W>0)]);
stage.Properties.VariableNames{1} = 'stage';
session=array2table([Model2.sess(ID_N3_W>0)]);
session.Properties.VariableNames{1} = 'session';

sw_history_2bins=array2table([Model2.sw_history_2bins(ID_N3_W>0)]);
sw_history_2bins.Properties.VariableNames{1} = 'sw_history_2bins';

%%%
age=array2table([Model2.Var2(ID_N3_W>0)]);
age.Properties.VariableNames{1} = 'age';
gender=array2table([Model2.Var3(ID_N3_W>0)]);
gender.Properties.VariableNames{1} = 'gender';
edu=array2table([Model2.Var4(ID_N3_W>0)]);
edu.Properties.VariableNames{1} = 'edu';

%%%
filename=array2table([Model2.Var8(ID_N3_W>0)]);
filename.Properties.VariableNames{1} = 'filename';

Model_N3_W=[subj,age,gender,edu,stage,session, filename];

Model_N3_W_accsleep=[subj,age,gender,edu,stage,session,sw_history_2bins, filename];

%%
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/7_validation_N2W_N3W
writetable(Model_N3_W,'Model_N3_W_N2180.txt','Delimiter',' ')

writetable(Model_N3_W_accsleep,'Model_N3_W_accsleep_N2180.txt','Delimiter',' ')



