%% get LME model

clc;clear 
fid=fopen('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/filelist-all2461.txt');
session=textscan(fid,'%s');
fclose(fid);

rtpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410';
cd(rtpath);
meanFD=load('meanFD_N2461.txt');
numFD=load('numFD_N2461.txt');
maxHM=load('maxHM_N2461.txt');

coverage = load('/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/Five-min-sessions/check_coverage/overlap_CHCP_Yeo2011_mask_all2461.1D');

Demo=readtable('Demo_N130.txt');
Inc=zeros(length(session{1}),1);
y=1;z=1;

for x = 1:length(session{1})

    if ( (numFD(x) <= 150*0.3) && (meanFD(x) <= 0.4) && (maxHM(x) <= 3) && (coverage(x) >= 0.95) )
        Inc(x,1) = 1;
      
       session_in{y} = session{1}{x};
       
       ID(y)=x;
       subj_in{y}=session_in{y}(1:7);
       
       for d=1:size(Demo,1)
           if  strcmp(subj_in{y},Demo(d,1).Var1)
               Demo(d,1).Var1
               age_in{y}=Demo(d,2).Var2;
               if Demo(d,3).Var3==0 % gender as categorical variable
                   gender_in{y}='female';
               else
                   gender_in{y}='male';
               end
               edu_in{y}=Demo(d,4).Var4; 
           end
       end
       
       stage_in{y}=session_in{y}(9:14);
       sess_in{y}=session_in{y}(15:end);

       session_in_fn{y} = [session{1}{x} '.nii.gz'];
       y = y +1;
       
       
    else

        session_out{z} = session{1}{x};

        z = z +1;   

    end % a included session
       
end

session_in = session_in';
session_out = session_out';

subj_u = unique(subj_in);
subj_u = subj_u';


%% num70FD40max30, additionally constrained by coverage >= 95%
% 2461 sessions in total: 2180 included, 281 excluded.
% 130 subj
meanFD_N2180 = meanFD(Inc>0);
meanFD_N2180 = meanFD_N2180';
save meanFD_N2180.txt meanFD_N2180 -ascii

writecell(session_in,'filelist-all2180.txt','Delimiter',' ')

%%
Model_N2180=table(subj_in',age_in',gender_in',edu_in',stage_in',sess_in',session_in_fn');
cd(rtpath);
writetable(Model_N2180,'Model_N2180.txt','Delimiter',' ')
%% then generate 3dLMEr model and run in afni


%% 2180
aa=0;bb=0;cc=0;dd=0;ee=0;
for ii=1:length(session_in)
    if contains(session_in{ii},'stage0')
        aa=aa+1;
        subj_stage0{aa}=subj_in{ii};
    elseif contains(session_in{ii},'stage1')
        bb=bb+1;
        subj_stage1{bb}=subj_in{ii};
    elseif contains(session_in{ii},'stage2')
        cc=cc+1;
        subj_stage2{cc}=subj_in{ii};
    elseif contains(session_in{ii},'stage3')
        dd=dd+1;
        subj_stage3{dd}=subj_in{ii};
    else
        ee=ee+1;
        subj_stage4{ee}=subj_in{ii};
    end
end

[length(subj_stage4) length(unique(subj_stage4))]
%%       #session        #subj
% W           434              87
% N1          192              79       
% N2          943              112
% N3          540              85
% REM         71               23

