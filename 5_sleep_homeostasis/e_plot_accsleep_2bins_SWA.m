%% for Fig. 3
%% plot 2 stage by 2 bin interaction effect on SWA

%%
clc;clear
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis
% load mean and se resutls from R
data1=csvread('out_sleep_wake_accsleep_2bins_SWA_CHCP7_N2180.csv',1,0);
data=data1(3:6,1);
colormap1 = SPECTRAL(256); % Colormap 
Colors2=colormap1([210 40],:);



%% SWA
Gname={'Early','Late'};
Numgroup=2;
Numregion=1;
Numlname  = 1;
Numgname  = size(Gname, 2);

figure
set(gcf,'Units','Centimeters','position',[1 1 2 5])
yMean = reshape(data(1:2,1), Numgroup, Numregion)';
yse  = reshape(data(3:4,1), Numgroup, Numregion)';

groupwidth = min(0.8, Numgroup/(Numgroup+1.5));

        yMean_new = diag(yMean);
        H = bar(yMean_new, 'stack');
        
        for i = 1:Numgroup
            set(H(i), 'FaceColor', Colors2(i,:), 'BarWidth', 0.66); 
        end
        
        hold on;
        
        for i = 1:Numgroup
             yErr = yse;
              yErrBar=zeros(Numregion, 2);
            for nr=1:Numregion
                yOneMean=yMean(nr, i);
                if yOneMean >=0
                    yErrBar(nr, 1)=yOneMean;
                    yErrBar(nr, 2)=yOneMean + yErr(nr, i);
                else
                    yErrBar(nr, 1)=yOneMean - yErr(nr, i);
                    yErrBar(nr, 2)=yOneMean;            
                end
            end
            plot([i; i], yErrBar',  'color', Colors2(i,:), 'LineWidth', 2);
        end
        
        set(gca, 'Xlim', [0.38 Numgroup + 0.62], 'xtick', 1:5, 'xticklabel',Gname, 'YGrid', 'off', 'box', 'off', 'TickDir', 'out','FontName','Arial','fontsize',7);

xtickangle(45)

ylabel('{\Delta} SWA','fontname','Arial','fontsize',7);

set(gca, 'Ylim', [0 0.35]);
set(gca, 'ytick', [0:0.1:0.3])
set(gca,'looseInset',[0.05 0.02 0 0.02])


cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis/


print(gcf,'-dpdf','-r400')
oldname=['figure1.pdf'];
newname=['sleep_wake_accsleep_2bins_SWA.pdf'];
movefile(oldname,newname);    

close all;

