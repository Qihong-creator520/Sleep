## extract all the ALFF maps
## get prepared for LME analysis

rtpath="/nd_disk2/qihong/Sleep_PKU/brain_restoration"

###
# 2180 sessions (300 s) from 130 subjects
Sessions=`cat ${rtpath}/Sleep_EEG_fMRI-main_v202410/filelist-all2180.txt`


cd ${rtpath}/processed/ALFF

for session in ${Sessions}
do

cd ${rtpath}/processed/ALFF

rm -f ${session}-volreg_MNI_bbr-dt-noGSR-residual-blur6_ALFF-ctx-z.nii.gz
cp ${rtpath}/processed/Five-min-sessions/${session}/${session}-volreg_MNI_bbr-dt-noGSR-residual-blur6_ALFF-ctx-z.nii.gz ./
done



# prepare for dALFF calculation
cd ${rtpath}/processed/ALFF/stats
rm -f all2180-volreg_MNI_bbr-dt-noGSR-residual-blur6_ALFF-ctx-z.nii.gz
3dTcat -prefix all2180-volreg_MNI_bbr-dt-noGSR-residual-blur6_ALFF-ctx-z.nii.gz ../sub*ALFF-ctx-z.nii.gz

