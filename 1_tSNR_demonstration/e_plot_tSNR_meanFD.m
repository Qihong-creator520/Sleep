%% fig. S3
%% relationship between tSNR and motion

clc;clear
cd('/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/tSNR')
dirs=dir('sub*');
All_tSNR = zeros(length(dirs),110);
All_acq =zeros(length(dirs),110);

for dirn=1:length(dirs)
    dirn
    cd('/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/tSNR')
    cd(dirs(dirn).name);
    f=dir('*tSNR*txt');% tSNR of 5-min sessions
    lf =length(f);% number of runs

    tSNR=[];

    for file_n = 1:lf
        
        a=load(f(file_n).name);
        tSNR = [tSNR;a];
        
    end
    
    All_tSNR(dirn,1:length(tSNR))=tSNR;
    All_acq(dirn,1:length(tSNR))=ones(1,length(tSNR));
    cd ..
end

tSNR_mean = sum(All_tSNR,1)./sum(All_acq,1);
tSNR_mean(min(find(sum(All_acq,1)<3)):end) = [];
% min(find(sum(All_acq,1)<3))
% 76
cd('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410');
save tSNR_mean.txt tSNR_mean -ascii




figure
set(gcf,'Units','Centimeters','position',[1 1 16 9])



%%% tSNR
subplot('position',[0.06    0.60   0.42    0.38])

for ii = 1:length(dirs)
    hold on; plot(1:length(find(All_acq(ii,:)>0)),All_tSNR(ii,1:length(find(All_acq(ii,:)>0))),'.','MarkerSize',4);
end


hold on;plot(tSNR_mean(1:75)','-','color','k','linewidth',1); 
hold on;plot(30,All_tSNR(99,30),'o','MarkerSize',6,'MarkerEdgeColor','k')
set(gca,'Tickdir','out','FontName','Arial','FontSize',7,'box','off');

xlabel('Time (hour)','FontSize',7,'FontName','Arial');ylabel('tSNR','FontSize',7,'FontName','Arial');
set(gca,'Ylim',[0 135],'ytick',[0:30:135])
% 75 valid data points (with at least 3 sessions)
set(gca,'Xlim',[0.5 75.5],'xtick',[12:12:72],'xticklabel',{'1','2','3','4','5','6'},'FontName','Arial','FontSize',7)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
All_meanFD = zeros(length(dirs),110);
All_acq =zeros(length(dirs),110);

cd('/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/tSNR')
for dirn=1:length(dirs)
    dirn
    cd(dirs(dirn).name);
    f=dir('*meanFD*txt');% meanFD of 5-min sessions
    lf =length(f);% number of runs

    meanFD=[];

    for file_n = 1:lf
        
        a=load(f(file_n).name);
        meanFD = [meanFD;a];
        
    end
    
    All_meanFD(dirn,1:length(meanFD))=meanFD;
    All_acq(dirn,1:length(meanFD))=ones(1,length(meanFD));
    cd ..
end

meanFD_mean = sum(All_meanFD,1)./sum(All_acq,1);
meanFD_mean(min(find(sum(All_acq,1)<3)):end) = [];

cd('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410');
save meanFD_mean.txt meanFD_mean -ascii

% meanFD
subplot('position',[0.56    0.60    0.42    0.38])
for ii = 1:length(dirs)
    hold on; plot(1:length(find(All_acq(ii,:)>0)),All_meanFD(ii,1:length(find(All_acq(ii,:)>0))),'.','MarkerSize',4);
end
hold on;plot(meanFD_mean(1:75)','-','color','k','linewidth',1);
hold on;plot(30,All_meanFD(99,30),'o','MarkerSize',6,'MarkerEdgeColor','k')
set(gca,'Tickdir','out','FontName','Arial','FontSize',7,'box','off');


xlabel('Time (hour)','FontSize',7,'FontName','Arial');ylabel('meanFD (mm)','FontSize',7,'FontName','Arial');
set(gca,'Ylim',[0 2.1],'ytick',[0:0.5:2.1])
set(gca,'Xlim',[0.5 75.5],'xtick',[12:12:72],'xticklabel',{'1','2','3','4','5','6'},'FontName','Arial','FontSize',7)



[r p]=corr(meanFD_mean(1:75)',tSNR_mean(1:75)','type','Spearman')
% ans =
% 
%    -0.7535    0.0000
   





%%%
subplot('position',[0.06    0.05    0.42    0.38])
plot(meanFD_mean(1:75)',tSNR_mean(1:75)','o','MarkerSize',5,'MarkerEdgeColor','k','MarkerFaceColor','k');
p = polyfit(meanFD_mean(1:75)',tSNR_mean(1:75)',1);
yfit = polyval(p,meanFD_mean(1:75)');
hold on;plot(meanFD_mean(1:75)',yfit,'-','Color','k','LineWidth',1)
set(gca,'Tickdir','out','FontName','Arial','FontSize',7)

xlabel('Average meanFD (mm)','FontName','Arial','FontSize',7);ylabel('Average tSNR','FontName','Arial','FontSize',7);
set(gca,'Box','off');
set(gca,'XLim',[0.08 0.28])
set(gca,'YLim',[60 110],'ytick',60:20:100);

txt={'{\it{r}} = -0.75','{\it{P}} < 0.0001'};
t=text(0.18,97,txt);
t.FontSize=7;t.FontName='Arial';t.Color='k'



%%%

rtpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/tSNR/';
tSNR_in = zeros(length(dirs),110);
tSNR_out =zeros(length(dirs),110);
tSNR =zeros(length(dirs),110);

Num_sessions=[];Num_runs=[];

for dirn=1:length(dirs)
    dirn
    cd(rtpath);
    cd(dirs(dirn).name);
    
    f1=dir('*numFD.txt');
    f2=dir('*meanFD.txt');
    f3=dir('*maxHM.txt');  
    f4=dir('*tSNR.txt');

    lf =length(f4);

    Num_runs(dirn,:)=[length(f1) length(f2) length(f3) length(f4)];

    a=[];b=[];c=[];d=[];
    for file_n = 1:lf

        a0=load(f1(file_n).name);
        b0=load(f2(file_n).name);
        c0=load(f3(file_n).name);
        d0=load(f4(file_n).name);

        a=[a;a0];
        b=[b;b0];
        c=[c;c0];
        d=[d;d0];

    end

    session_in=(a <= 150*.30).*(b <= 0.40).*(c <= 3);
    session_out=ones(length(a),1)-session_in;

    tSNR(dirn,1:length(a))=d;
    tSNR_in(dirn,find(session_in))=d(find(session_in));
    tSNR_out(dirn,find(session_out))=d(find(session_out));
end


tSNR_mean = sum(tSNR,1)./sum((tSNR>0),1);
tSNR_in_mean = sum(tSNR_in,1)./sum((tSNR_in>0),1);
tSNR_out_mean = sum(tSNR_out,1)./sum((tSNR_out>0),1);
                

indexo=~isnan(tSNR_out_mean);
indexi=~isnan(tSNR_in_mean);
index=indexo.*indexi;
sum(index)
% 70
[h  p c t]=ttest(tSNR_in_mean(index>0),tSNR_out_mean(index>0));
[t.tstat p]
% 49.5486    0.0000
tSNR_mean_in1 = tSNR_in_mean(index>0)';
tSNR_mean_final(1,1) =mat2cell(tSNR_mean_in1,70,1);

tSNR_mean_out1 = tSNR_out_mean(index>0)';
tSNR_mean_final(1,2) =mat2cell(tSNR_mean_out1,70,1);

%%%
subplot('position',[0.56    0.05    0.42    0.38])


gretna_plot_violin(tSNR_mean_final,{'Included', 'Excluded'},{''},'meanstdfill')
set(gca,'FontName','Arial','FontSize',7,'Tickdir','out')
set(gca,'Ylim',[20 110],'ytick',[20:50:110])
ylabel('Average tSNR','FontName','Arial','FontSize',7)
legend('off')
set(gca,'xtick',1:1:2,'xticklabel',{'Moderate','Excessive'})



outpath = ['/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410'];
cd(outpath)

print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['tSNR_meanFD_sp_corr.pdf'];
movefile(oldname,newname);    

close all;
