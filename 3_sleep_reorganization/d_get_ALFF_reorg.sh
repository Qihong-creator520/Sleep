### 5stage and 2stage LME analysis as well as post hoc comparisons in AFNI

rtpath="/nd_disk2/qihong/Sleep_PKU/brain_restoration"


###############
### 5 stages
cd ${rtpath}/processed/ALFF

# with age, gender, edu as covariates
chmod +x 3dlmer_5stages-age-gender-edu_ALFF-ctx-z-s-N2180.txt
./3dlmer_5stages-age-gender-edu_ALFF-ctx-z-s-N2180.txt





###
### etimate clustersize using the same mask as 3dLMEr
cd ${rtpath}/processed/ALFF/stats
rm -f 3dFWHMx.1D*
rm -f resid_ALFF-ctx-z_5stages-N2180-CHCP_Yeo2011_2mm_mask.txt
3dFWHMx -dset resid_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz \
-mask ${rtpath}/processed/masks/CHCP_Yeo2011_2mm_mask.nii.gz \
-detrend -unif -acf \
> resid_ALFF-ctx-z_5stages-N2180-CHCP_Yeo2011_2mm_mask.txt


# the first row in the txt file represents FWHM
# the second row represents acf (three parameters), which is what we need
1d_tool.py -infile resid_ALFF-ctx-z_5stages-N2180-CHCP_Yeo2011_2mm_mask.txt -select_rows '1' \
-write resid_ALFF-ctx-z_5stages-N2180-CHCP_Yeo2011_2mm_mask_acf.txt


### acf parameters from resid_ALFF-ctx-z_5stages-N2180-CHCP_Yeo2011_2mm_mask_acf.txt
rm -f resid_ALFF-ctx-z_5stages-N2180-CHCP_Yeo2011_2mm_mask_3dClustSim.txt
3dClustSim -mask ${rtpath}/processed/masks/CHCP_Yeo2011_2mm_mask.nii.gz \
-acf 0.453191 5.20581 15.6015 -iter 10000 \
-prefix resid_ALFF-ctx-z_5stages-N2180-CHCP_Yeo2011_2mm_mask_3dClustSim.txt




# correction
cd ${rtpath}/processed/ALFF/stats
3dcalc -prefix ALFF-ctx-z-main-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[0] -expr 'a'

rm -f ALFF-ctx-z-main-N2180-p001.nii.gz
3dcalc -prefix ALFF-ctx-z-main-N2180-p001.nii.gz \
-a ALFF-ctx-z-main-N2180.nii.gz -expr 'a*step(a-13.718)'

# read the minimum cluster size for uncorrected p < 0.001 and corrected p < 0.05 from:
# resid_ALFF-ctx-z_2stages-CHCP_Yeo2011_2mm_mask_3dClustSim.txt.NN2_1sided.1D
###
# cluster size from 2stage model is larger than 5stage model.
# using the larger cluster size from 2stage model for main effect and all the post-hoc maps, for consistentency 
###
rm -f ALFF-ctx-z-main-N2180-correctp05.nii.gz
3dmerge -1thresh 0.00001 -dxyz=1 -1clust 1.5  141  \
-prefix ALFF-ctx-z-main-N2180-correctp05.nii.gz \
ALFF-ctx-z-main-N2180-p001.nii.gz




###
3dcalc -prefix W_ALFF-ctx-z_mean-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[4] -expr 'a'
3dcalc -prefix N1_ALFF-ctx-z_mean-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[6] -expr 'a'
3dcalc -prefix N2_ALFF-ctx-z_mean-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[8] -expr 'a'
3dcalc -prefix N3_ALFF-ctx-z_mean-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[10] -expr 'a'
3dcalc -prefix REM_ALFF-ctx-z_mean-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[12] -expr 'a'


###
3dcalc -prefix meanmap_N1-W-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[14] -expr 'a'
3dcalc -prefix meanmap_N2-W-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[16] -expr 'a'
3dcalc -prefix meanmap_N3-W-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[18] -expr 'a'
3dcalc -prefix meanmap_REM-W-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[20] -expr 'a'

3dcalc -prefix Zmap_N1-W-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[15] -expr 'a'
3dcalc -prefix Zmap_N2-W-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[17] -expr 'a'
3dcalc -prefix Zmap_N3-W-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[19] -expr 'a'
3dcalc -prefix Zmap_REM-W-N2180.nii.gz -a lme_ALFF-ctx-z_5stages_age_gender_edu_N2180-s.nii.gz[21] -expr 'a'

for data in N1-W N2-W N3-W REM-W ; do

rm -f meanmap_${data}-N2180-p001.nii.gz
3dcalc -prefix meanmap_${data}-N2180-p001.nii.gz \
-a meanmap_${data}-N2180.nii.gz \
-b Zmap_${data}-N2180.nii.gz \
-expr 'a*step(abs(b)-2.2768)'

# read the minimum cluster size for uncorrected p < 0.001 and corrected p < 0.05 from:
# resid_ALFF-ctx-z_2stages-CHCP_Yeo2011_2mm_mask_3dClustSim.txt.NN2_2sided.1D
###
# cluster size from 2stage model is larger than 5stage model.
# using the larger cluster size from 2stage model for main effect and all the post-hoc maps, for consistentency
###
rm -f meanmap_${data}-N2180-correctp05.nii.gz
3dmerge -1thresh 0.00001 -dxyz=1 -1clust 1.5 121  \
-prefix meanmap_${data}-N2180-correctp05.nii.gz \
meanmap_${data}-N2180-p001.nii.gz

done





###############
### 2 stages
rtpath="/nd_disk2/qihong/Sleep_PKU/brain_restoration"
cd ${rtpath}/processed/ALFF

# with age, gender, edu as covariates
chmod +x 3dlmer_2stages-age-gender-edu_ALFF-ctx-z-s-N2180.txt
./3dlmer_2stages-age-gender-edu_ALFF-ctx-z-s-N2180.txt





###
### etimate clustersize using the same mask as 3dLMEr
rtpath="/nd_disk2/qihong/Sleep_PKU/brain_restoration"
cd ${rtpath}/processed/ALFF/stats
rm -f 3dFWHMx.1D*
rm -f resid_ALFF-ctx-z_2stages_age_gender_edu_N2180-s-CHCP_Yeo2011_2mm_mask.txt
3dFWHMx -dset resid_ALFF-ctx-z_2stages_age_gender_edu_N2180-s.nii.gz \
-mask ${rtpath}/processed/masks/CHCP_Yeo2011_2mm_mask.nii.gz \
-detrend -unif -acf \
> resid_ALFF-ctx-z_2stages_age_gender_edu_N2180-s-CHCP_Yeo2011_2mm_mask.txt


# the first row in the txt file represents FWHM
# the second row represents acf (three parameters), which is what we need
1d_tool.py -infile resid_ALFF-ctx-z_2stages_age_gender_edu_N2180-s-CHCP_Yeo2011_2mm_mask.txt -select_rows '1' \
-write resid_ALFF-ctx-z_2stages_age_gender_edu_N2180-s-CHCP_Yeo2011_2mm_mask_acf.txt


### acf parameters from resid_ALFF-ctx-z_2stages_age_gender_edu_N2180-s-CHCP_Yeo2011_2mm_mask_acf.txt
rm -f resid_ALFF-ctx-z_2stages_age_gender_edu_N2180-s-CHCP_Yeo2011_2mm_mask_3dClustSim.txt
3dClustSim -mask ${rtpath}/processed/masks/CHCP_Yeo2011_2mm_mask.nii.gz \
-acf 0.466413 5.15469 17.3589 -iter 10000 \
-prefix resid_ALFF-ctx-z_2stages_age_gender_edu_N2180-s-CHCP_Yeo2011_2mm_mask_3dClustSim.txt



cd ${rtpath}/processed/ALFF/stats

3dcalc -prefix meanmap_Sleep-W-N2180.nii.gz -a lme_ALFF-ctx-z_2stages_age_gender_edu_N2180-s.nii.gz[8] -expr 'a'

3dcalc -prefix Zmap_Sleep-W-N2180.nii.gz -a lme_ALFF-ctx-z_2stages_age_gender_edu_N2180-s.nii.gz[9] -expr 'a'


rm -f meanmap_Sleep-W-N2180-p001.nii.gz
3dcalc -prefix meanmap_Sleep-W-N2180-p001.nii.gz \
-a meanmap_Sleep-W-N2180.nii.gz \
-b Zmap_Sleep-W-N2180.nii.gz \
-expr 'a*step(abs(b)-2.2768)'

# read the minimum cluster size for uncorrected p < 0.001 and corrected p < 0.05 from:
# resid_ALFF-ctx-z_2stages-CHCP_Yeo2011_2mm_mask_3dClustSim.txt.NN2_2sided.1D
rm -f meanmap_Sleep-W-N2180-correctp05.nii.gz
3dmerge -1thresh 0.00001 -dxyz=1 -1clust 1.5 121  \
-prefix meanmap_Sleep-W-N2180-correctp05.nii.gz \
meanmap_Sleep-W-N2180-p001.nii.gz




### for scatter plots
rm -f lme_ALFF-ctx-z_2stages_age_gender_edu_N2180-s-v6.nii.gz
3dresample -dxyz 6 6 6 -prefix lme_ALFF-ctx-z_2stages_age_gender_edu_N2180-s-v6.nii.gz \
-inset lme_ALFF-ctx-z_2stages_age_gender_edu_N2180-s.nii.gz

