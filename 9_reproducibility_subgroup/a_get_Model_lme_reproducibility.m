%% prepare LME models for two-subgroups

clc;clear
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis
Model_N2180_accsleep=readtable('Model_N2180_accsleep.txt');

sub=Model_N2180_accsleep.Var1;
sub_n=unique(sub);
count_W_S_E_L = zeros(length(sub_n),10);

for ii = 1:length(sub_n)
    ID_sub_n = contains(Model_N2180_accsleep.Var1,sub_n(ii)); 
    index = find(ID_sub_n>0);
    count_W_S_E_L(ii,5) = table2array(Model_N2180_accsleep(index(1),2));
    count_W_S_E_L(ii,6) = strcmp(table2cell(Model_N2180_accsleep(index(1),3)), 'female');
    count_W_S_E_L(ii,7) = table2array(Model_N2180_accsleep(index(1),4));
    
    for jj = 1:length(index)
        if strcmp(table2cell(Model_N2180_accsleep(index(jj),5)), 'stage0') 
            if strcmp(table2cell(Model_N2180_accsleep(index(jj),6)), 'oneless')
    
                count_W_S_E_L(ii,1) = count_W_S_E_L(ii,1) +1;
            else
                count_W_S_E_L(ii,3) = count_W_S_E_L(ii,3) +1;
            end
        else
            if strcmp(table2cell(Model_N2180_accsleep(index(jj),6)), 'oneless')
    
                count_W_S_E_L(ii,2) = count_W_S_E_L(ii,2) +1;
            else
                count_W_S_E_L(ii,4) = count_W_S_E_L(ii,4) +1;
            end
    
        end

    end

end

count_W_S_E_L(:,8) = count_W_S_E_L(:,1) + count_W_S_E_L(:,3);
count_W_S_E_L(:,9) = count_W_S_E_L(:,2) + count_W_S_E_L(:,4);
count_W_S_E_L(:,10) = count_W_S_E_L(:,8) + count_W_S_E_L(:,9);

[mm nn] = sort(count_W_S_E_L(:,6));
count_W_S_E_L_m = [count_W_S_E_L(nn(1:52),:) nn(1:52)];
count_W_S_E_L_f = [count_W_S_E_L(nn(53:end),:) nn(53:end)];

[mmm nnm] = sort(count_W_S_E_L_m(:,10));
count_W_S_E_L_m_order = count_W_S_E_L_m(nnm,:);

for k = 1:floor(length(nnm)/8)
    count_W_S_E_L_m_order_g1(4*k-3,:) = count_W_S_E_L_m_order(8*k-7,:);
    count_W_S_E_L_m_order_g1(4*k-2,:) = count_W_S_E_L_m_order(8*k-6,:);
    count_W_S_E_L_m_order_g1(4*k-1,:) = count_W_S_E_L_m_order(8*k-1,:);
    count_W_S_E_L_m_order_g1(4*k,:) = count_W_S_E_L_m_order(8*k,:);

    count_W_S_E_L_m_order_g2(4*k-3,:) = count_W_S_E_L_m_order(8*k-5,:);
    count_W_S_E_L_m_order_g2(4*k-2,:) = count_W_S_E_L_m_order(8*k-4,:);
    count_W_S_E_L_m_order_g2(4*k-1,:) = count_W_S_E_L_m_order(8*k-3,:);
    count_W_S_E_L_m_order_g2(4*k,:) = count_W_S_E_L_m_order(8*k-2,:);
end

k = k+1;

    count_W_S_E_L_m_order_g1(4*k-3,:) = count_W_S_E_L_m_order(8*k-7,:);
    count_W_S_E_L_m_order_g1(4*k-2,:) = count_W_S_E_L_m_order(8*k-6,:);

    count_W_S_E_L_m_order_g2(4*k-3,:) = count_W_S_E_L_m_order(8*k-5,:);
    count_W_S_E_L_m_order_g2(4*k-2,:) = count_W_S_E_L_m_order(8*k-4,:);




[mmf nnf] = sort(count_W_S_E_L_f(:,10));
count_W_S_E_L_f_order = count_W_S_E_L_f(nnf,:);

for k = 1:floor(length(nnf)/8)
    count_W_S_E_L_f_order_g1(4*k-3,:) = count_W_S_E_L_f_order(8*k-7,:);
    count_W_S_E_L_f_order_g1(4*k-2,:) = count_W_S_E_L_f_order(8*k-4,:);
    count_W_S_E_L_f_order_g1(4*k-1,:) = count_W_S_E_L_f_order(8*k-3,:);
    count_W_S_E_L_f_order_g1(4*k,:) = count_W_S_E_L_f_order(8*k,:);

    count_W_S_E_L_f_order_g2(4*k-3,:) = count_W_S_E_L_f_order(8*k-6,:);
    count_W_S_E_L_f_order_g2(4*k-2,:) = count_W_S_E_L_f_order(8*k-5,:);
    count_W_S_E_L_f_order_g2(4*k-1,:) = count_W_S_E_L_f_order(8*k-2,:);
    count_W_S_E_L_f_order_g2(4*k,:) = count_W_S_E_L_f_order(8*k-1,:);
end

k = k+1;

    count_W_S_E_L_f_order_g1(4*k-3,:) = count_W_S_E_L_f_order(8*k-7,:);
    count_W_S_E_L_f_order_g1(4*k-2,:) = count_W_S_E_L_f_order(8*k-4,:);
    count_W_S_E_L_f_order_g1(4*k-1,:) = count_W_S_E_L_f_order(8*k-3,:);

    count_W_S_E_L_f_order_g2(4*k-3,:) = count_W_S_E_L_f_order(8*k-6,:);
    count_W_S_E_L_f_order_g2(4*k-2,:) = count_W_S_E_L_f_order(8*k-5,:);
    count_W_S_E_L_f_order_g2(4*k-1,:) = count_W_S_E_L_f_order(8*k-2,:);


clear count_W_S_E_L_order_g*
count_W_S_E_L_order_g1 = [count_W_S_E_L_m_order_g1(1:2:end,:); count_W_S_E_L_m_order_g2(2:2:end,:); count_W_S_E_L_f_order_g1(1:2:end,:); count_W_S_E_L_f_order_g2(2:2:end,:)];
count_W_S_E_L_order_g2 = [count_W_S_E_L_m_order_g1(2:2:end,:); count_W_S_E_L_m_order_g2(1:2:end,:); count_W_S_E_L_f_order_g1(2:2:end,:); count_W_S_E_L_f_order_g2(1:2:end,:)];
sum(count_W_S_E_L_order_g1)
sum(count_W_S_E_L_order_g2)

[h p c t]=ttest2(count_W_S_E_L_order_g1,count_W_S_E_L_order_g2)
%  0.3958    0.3838    0.1852    0.8967    0.5789    1.0000    0.7333    0.9680    0.8674    0.8831    0.4240


[aa1 bb1] = sort(count_W_S_E_L_order_g1(:,11));
count_W_S_E_L_g1 = count_W_S_E_L_order_g1(bb1,:);

[aa2 bb2] = sort(count_W_S_E_L_order_g2(:,11));
count_W_S_E_L_g2 = count_W_S_E_L_order_g2(bb2,:);

sum(count_W_S_E_L_g1)
%    1.0e+03 *
%     0.1260    0.3990    0.0690    0.4750    1.5010    0.0390    1.0655    0.1950    0.8740    1.0690    4.6510

sum(count_W_S_E_L_g2)
%    1.0e+03 *
%     0.1260    0.4410    0.0990    0.4210    1.4460    0.0390    1.0445    0.2250    0.8620    1.0870    3.8640

[h p c t]=ttest2(count_W_S_E_L_g1,count_W_S_E_L_g2)


%%
ID_sub_g1 = count_W_S_E_L_g1(:,11);
Model_accsleep_g1 = [];
index_g1=[];

for aa = 1:length(ID_sub_g1)
    ID_sub_n = contains(Model_N2180_accsleep.Var1,sub_n(ID_sub_g1(aa))); 
    index = find(ID_sub_n>0);
    index_g1 = [index_g1; index];
    Model_accsleep_g1 = [Model_accsleep_g1; Model_N2180_accsleep(index,:)];
end

ID_sub_g2 = count_W_S_E_L_g2(:,11);
Model_accsleep_g2 = [];
index_g2=[];

for aa = 1:length(ID_sub_g2)
    ID_sub_n = contains(Model_N2180_accsleep.Var1,sub_n(ID_sub_g2(aa))); 
    index = find(ID_sub_n>0);
    index_g2 = [index_g2; index];
    Model_accsleep_g2 = [Model_accsleep_g2; Model_N2180_accsleep(index,:)];
end

ID_g1_g2(ID_sub_g1,1) = 1;
ID_g1_g2(ID_sub_g2,1) = 2;

index_g1_g2(index_g1,1) = 1;
index_g1_g2(index_g2,1) = 2;

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/9_reproducibility_subgroup
save ID_g1_g2_N2180.1D ID_g1_g2 '-ascii'
save index_g1_g2_N2180.1D index_g1_g2 '-ascii'

Model_g1 = Model_accsleep_g1(:,[1 2 3 4 5 7 8]);
Model_g2 = Model_accsleep_g2(:,[1 2 3 4 5 7 8]);

writetable(Model_g1,'Model_g1_N2180.txt','Delimiter',' ')
writetable(Model_accsleep_g1,'Model_accsleep_g1_N2180.txt','Delimiter',' ')
writetable(Model_g2,'Model_g2_N2180.txt','Delimiter',' ')
writetable(Model_accsleep_g2,'Model_accsleep_g2_N2180.txt','Delimiter',' ')
