%% for fig. S1
%% get sleep structure during whole sleep recordingby PSG and portable sleep device

%%%
clc;clear
cd('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Wholenight_sleep')
dirs=dir('sub*4stages.1D');
Nstgs=5;%0-W,2-N1+N2,3-N3,4-R
prob_stgs=zeros(Nstgs,10000);
All_inds = zeros(length(dirs),Nstgs,10000);
All_acq =zeros(length(dirs),10000);

for dirn=1:length(dirs)
    dirn

    inds=zeros(Nstgs,10000);
    a=load(dirs(dirn).name);
    pred = a;
   

    for j=1:Nstgs
        inds(j,1:size(pred))=(pred==j-1);                
    end

    All_inds(dirn,:,:)=inds;
    All_acq(dirn,:)=sum(inds,1);

end

prob_stgs1 = squeeze(sum(All_inds,1))./sum(All_acq,1);
prob_stgs1 = squeeze(prob_stgs1);
prob_stgs1(:,min(find(sum(All_acq,1)==0)):end) = [];
prob_stgs = prob_stgs1([1 3:5],:); %% 0-W,2-N1+N2,3-N3,4-R

duration1 = sum(All_inds,3)/120; % in hour
duration = [duration1(:,1) duration1(:,3:5)]; %% 0-W,2-N1+N2,3-N3,4-R

Duration_sleep_stages=cell(1,4);
for j=1:4
    wholenight_sleep_duration{1,j}=duration(:,j); 
end



cd('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/0_sleep_demonstration');
save wholenight_sleep_prob_stgs.txt prob_stgs -ascii
save wholenight_sleep_duration.mat wholenight_sleep_duration


