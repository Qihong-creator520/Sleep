%% preparation for stage by accumulated sleep LME model for all the 5-minute epochs, including stage, sw_history (2bins), age, gender, edu, session (epoch) and subject
clc;clear
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/EEG/
Model_N2461=readtable('Model_N2461_forEEG.txt');
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410
SW_history_N2461=load('SW_history_N2461.txt');

%% 2bins
sw_history = SW_history_N2461(:,7)./120;
for xx = 1:length(sw_history)
    if sw_history(xx) <= 1
        sw_history_2bins{xx,1} = 'oneless'; % 1253
    else
        sw_history_2bins{xx,1} = 'onemore'; % 1208
    end
end

for jj = 1:length(Model_N2461.age)

    sess1 = cell2mat(Model_N2461.filenames_a(jj));
    sess{jj,1} = sess1(end-7:end);
end

clear Model_sleep_wake_N2461
Model_sleep_wake_N2461=table(table2cell(Model_N2461(:,1)), ...,
                                                   table2array(Model_N2461(:,2)), ...,
                                                   table2cell(Model_N2461(:,3)), ...,
                                                   table2array(Model_N2461(:,4)), ...,
                                                   table2cell(Model_N2461(:,5)), ...,
                                                   sw_history_2bins, ...,
                                                   sess, ...,
                                                   table2cell(Model_N2461(:,9)));

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410
writetable(Model_sleep_wake_N2461,['Model_sleep_wake_N2461.txt'],'Delimiter',',')
