%% get normalized SWA for the 5-minute epochs included in the final analysis
%%
clc;clear

for_EEG_N2180=readtable('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/EEG/for_EEG_N2180.txt');
rtpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/EEG/sorted/';
L_frame = 30; % 30-second for each frame, unit for the onset
ep_length = 300; % epoch length = 300 seconds
chan_select = [3 4 5 6 9 10]; % F3, F4, C3, C4, O1, O2

previous='';


for ii = 1:length(for_EEG_N2180.filenames_a)

    name = cell2mat(for_EEG_N2180.filenames_a(ii));

    subj = name(1:7);

    N_ss = for_EEG_N2180.N_ss(ii);
    onset_ss = for_EEG_N2180.onset_ss(ii);

    subpath = [rtpath subj];
    cd(subpath);
    
    %% EEG data have been preprocessed in BP analyzer
    EEGname = [label subj '_sleep' num2str(N_ss) '.vhdr'];
    %% the earliest 20-second data of each session has been removed before sleep staging to match fMRI
    %% additional 14-second data of the 2nd session of sub3055 have been removed before sleep staging, 7 more fMRI volumes need to be removed
    %% additional 10-second data of the 2nd session of sub3100 have been removed before sleep staging, 5 more fMRI volumes need to be removed
    disp(EEGname)

    if ~strcmp(EEGname,previous)

        clear EEG0 data start0 finish0 data_e
        EEG0 = pop_loadbv(subpath,EEGname, [], []);
    
        EEG1 = pop_eegfiltnew(EEG0,15.5,17.5,[],1,[],0); % notch 16.5 Hz
        EEG0_n = pop_eegfiltnew(EEG1,32,34,[],1,[],0); % notch 33 Hz
    
        data=EEG0_n.data;

        previous = EEGname;
    end


    start0 = (onset_ss-1)*L_frame*EEG0.srate+1;
    finish0 = start0 + ep_length*EEG0.srate - 1;

    data_epoch = data(chan_select,start0:finish0);


    clear power_epoch_all*
    for n = 1:size(chan_select,2)
        clear data_frame pxx f index* power_frame*

        for m=1:10 %i=frame_index
            data_frame{m}=data_epoch(n, (L_frame*EEG0.srate*(m-1)+1) : (L_frame*EEG0.srate*m));
            warning('off');
            [pxx,f]=pwelch(data_frame{m},hanning(2000),0.5,2000,500);%4s,overlap2s
            warning('on');
            
            index_s2=find(f==0.5); % 0.3 Hz - 35 Hz
            index_e2=find(f==35); % temporal filter range
            power_frame_all(m,:)=(pxx(index_s2:index_e2))./sum(pxx(index_s2:index_e2),1);% 0.3 Hz to 35 Hz, normalized
        end

        power_epoch_all(n,:)=mean(power_frame_all,1); % average across the 10 frames

    end

    power_epoch_all_mean=mean(power_epoch_all,1); % average across the channels

    power_epoch_N2180_all(ii,:) = [power_epoch_all_mean reshape(power_epoch_all',1,numel(power_epoch_all))];

end


%%%
e=array2table([power_epoch_N2180_all]);
for ii=1:size(e,2)
    e.Properties.VariableNames{ii} = ['power_epoch_N2180_all' num2str(ii)];
end


Model_N2180=readtable('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/Model_N2180.txt');

Model_N2180_power_n_all = [Model_N2180(:,1), Model_N2180(:,2), ...
                              Model_N2180(:,3), Model_N2180(:,4), ...
                              Model_N2180(:,5), Model_N2180(:,6), ...
                              Model_N2180(:,7), e];



cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/EEG/
writetable(Model_N2180_power_n_all,'Model_N2180_power_n_all.txt','Delimiter',',')

