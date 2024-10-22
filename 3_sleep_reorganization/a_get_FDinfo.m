clc;clear 
fid=fopen('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/filelist-all2461.txt');
session=textscan(fid,'%s');
fclose(fid);

rtpath='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/motion';
cd(rtpath);


for x = 1:length(session{1})
    disp( strtrim(session{1}{x}) )
    cd(rtpath);
    infile = [strtrim(session{1}{x}) '-motion.1D'];
    [meanFD1 numFD1 maxHM1] = FDinfo(infile);
    meanFD(x)=meanFD1; 
    numFD(x)=numFD1; 
    maxHM(x) = maxHM1;
end

cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/
save -ascii meanFD_N2461.txt meanFD
save -ascii numFD_N2461.txt numFD
save -ascii maxHM_N2461.txt maxHM
