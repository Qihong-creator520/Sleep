%% for fig. S3
%% demonstrate six motion profiles of a 5-minute epoch

clc;clear
rtpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/tSNR/';
cd(rtpath);
dirs=dir('sub*');

for dirn=99 % sub3085
    dirn
    cd(rtpath);
    cd(dirs(dirn).name);
    
    f=dir('*motion*1D');
    
    lf =length(f);
    
        for file_n = 2 % sleep2

            a=load(f(file_n).name);
            
            for ns = 12 % the 12th epoch
                mc_f1 = a(((ns-1)*150+1):ns*150,:);
                
            end

        end

end



% For demonstration
figure
set(gcf,'Units','Centimeters','position',[1 1 6 3])

%%%
subplot('position',[0.095 0.62  0.88  0.35])
plot(mc_f1(:,1:3),'linewidth',1);
ylabel('Tra (mm)','FontSize',5,'FontName','Arial');
set(gca,'linewidth',0.5,'box','off');
set(gca,'Xlim',[0 150]);set(gca,'Ylim',[-0.7 0.5]);
set(gca,'xTick',[],'xcolor','w');
% axis off
set(gca,'FontName','Arial','FontSize',5,'box','off','Tickdir','out');


%%%
subplot('position',[0.095 0.2  0.88  0.4])
plot(mc_f1(:,4:6),'linewidth',1);
xlabel('Time (s)','FontSize',5,'FontName','Arial');
ylabel('Rot (deg)','FontSize',5,'FontName','Arial');
set(gca,'linewidth',0.5,'box','off');
set(gca,'Xlim',[0 150]);set(gca,'Ylim',[-1 0.2]);
% axis off

set(gca,'FontName','Arial','FontSize',5,'box','off','Tickdir','out');

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410

print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['sub3085_sleep2_12_Translation_Rotation.pdf'];
movefile(oldname,newname);    

close all;

