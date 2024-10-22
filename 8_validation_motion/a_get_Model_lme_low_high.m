%% prepare LME models for low- and high-motion data

clc;clear
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis/
Model2=readtable('Model_N2180_accsleep.txt');

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410
meanFD = load('meanFD_N2180.txt');

stage=Model2.Var5;
bin=Model2.sw_history_2bins;
index_WE = contains(stage,'stage0').*contains(bin,'oneless');
index_WL = contains(stage,'stage0') - (contains(stage,'stage0').*contains(bin,'oneless'));
index_SE = contains(bin,'oneless') - index_WE;
index_SL = contains(bin,'onemore') - index_WL;



%% low-motion
ID_WE_low=(meanFD<median(meanFD(index_WE>0))) .* (index_WE); 
ID_WL_low=(meanFD<median(meanFD(index_WL>0))) .*(index_WL) ; 
ID_SE_low=(meanFD<median(meanFD(index_SE>0))) .* (index_SE); 
ID_SL_low=(meanFD<=median(meanFD(index_SL>0))) .* (index_SL); 
ID_low = ID_WE_low + ID_WL_low + ID_SE_low + ID_SL_low;

sum(ID_low) % N = 1090 low motion with smaller meanFD

Model_low=[];

clear sub stage session sw_history_2bins age gender edu

%%%
subj=array2table([Model2.Var1(ID_low>0)]);
subj.Properties.VariableNames{1} = 'subj';
stage=array2table([Model2.Var5(ID_low>0)]);
stage.Properties.VariableNames{1} = 'stage';
session=array2table([Model2.sess(ID_low>0)]);
session.Properties.VariableNames{1} = 'session';

sw_history_2bins=array2table([Model2.sw_history_2bins(ID_low>0)]);
sw_history_2bins.Properties.VariableNames{1} = 'sw_history_2bins';

%%%
age=array2table([Model2.Var2(ID_low>0)]);
age.Properties.VariableNames{1} = 'age';
gender=array2table([Model2.Var3(ID_low>0)]);
gender.Properties.VariableNames{1} = 'gender';
edu=array2table([Model2.Var4(ID_low>0)]);
edu.Properties.VariableNames{1} = 'edu';

%%%
filename=array2table([Model2.Var8(ID_low>0)]);
filename.Properties.VariableNames{1} = 'filename';

Model_low=[subj,age,gender,edu,stage,session, filename];

Model_low_accsleep=[subj,age,gender,edu,stage,session,sw_history_2bins, filename];

%%
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/8_validation_motion
writetable(Model_low,'Model_low_N2180.txt','Delimiter',' ')

%%
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/8_validation_motion
writetable(Model_low_accsleep,'Model_low_accsleep_N2180.txt','Delimiter',' ')




%% high-motion
ID_WE_high=(meanFD>=median(meanFD(index_WE>0))) .* (index_WE); 
ID_WL_high=(meanFD>=median(meanFD(index_WL>0))) .*(index_WL) ; 
ID_SE_high=(meanFD>=median(meanFD(index_SE>0))) .* (index_SE); 
ID_SL_high=(meanFD>median(meanFD(index_SL>0))) .* (index_SL); 
ID_high = ID_WE_high + ID_WL_high + ID_SE_high + ID_SL_high;

sum(ID_high) % N = 1090 high motion with smaller meanFD

Model_high=[];

clear sub stage session sw_history_2bins age gender edu

%%%
subj=array2table([Model2.Var1(ID_high>0)]);
subj.Properties.VariableNames{1} = 'subj';
stage=array2table([Model2.Var5(ID_high>0)]);
stage.Properties.VariableNames{1} = 'stage';
session=array2table([Model2.sess(ID_high>0)]);
session.Properties.VariableNames{1} = 'session';

sw_history_2bins=array2table([Model2.sw_history_2bins(ID_high>0)]);
sw_history_2bins.Properties.VariableNames{1} = 'sw_history_2bins';

%%%
age=array2table([Model2.Var2(ID_high>0)]);
age.Properties.VariableNames{1} = 'age';
gender=array2table([Model2.Var3(ID_high>0)]);
gender.Properties.VariableNames{1} = 'gender';
edu=array2table([Model2.Var4(ID_high>0)]);
edu.Properties.VariableNames{1} = 'edu';

%%%
filename=array2table([Model2.Var8(ID_high>0)]);
filename.Properties.VariableNames{1} = 'filename';

Model_high=[subj,age,gender,edu,stage,session, filename];

Model_high_accsleep=[subj,age,gender,edu,stage,session,sw_history_2bins, filename];

%%
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/8_validation_motion
writetable(Model_high,'Model_high_N2180.txt','Delimiter',' ')

writetable(Model_high_accsleep,'Model_high_accsleep_N2180.txt','Delimiter',' ')


ID_low_high(ID_low>0,1) = 1;
ID_low_high(ID_high>0,1) = 2;

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/8_validation_motion
save ID_low_high_N2180.1D ID_low_high '-ascii'



%%
%%%
sub_l=Model2.Var1;
c=sub_l(ID_low>0);
d=unique(c);
length(d) % 106 subjects in low group

c=sub_l(ID_high>0);
d=unique(c);
length(d) % 106 subjects in high group


%%%
stage_l=Model2.Var5;
c=stage_l(ID_low>0);
d=contains(c,'stage0');
sum(d) % 217 sessions
d=contains(c,'stage1');
sum(d) % 93 sessions
d=contains(c,'stage2');
sum(d) % 442 sessions
d=contains(c,'stage3');
sum(d) % 293 sessions
d=contains(c,'stage4');
sum(d) % 45 sessions


c=stage_l(ID_high>0);
d=contains(c,'stage0');
sum(d) % 217 sessions
d=contains(c,'stage1');
sum(d) % 99 sessions
d=contains(c,'stage2');
sum(d) % 501 sessions
d=contains(c,'stage3');
sum(d) % 247 sessions
d=contains(c,'stage4');
sum(d) % 26 sessions





