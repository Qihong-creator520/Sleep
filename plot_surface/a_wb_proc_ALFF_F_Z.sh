### for Fig. 1
### generate surface maps for sleep-related changes in cortical fluctuations
### 
# main effect
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb

for data in ALFF-ctx-z-main-N2180-correctp05 ALFF-ctx-z-main-N2180 ; do
# map volume to surface
wb_command -volume-to-surface-mapping ../${data}.nii.gz Conte69.L.midthickness.32k_fs_LR.surf.gii ./${data}.Conte69.l.func.gii -enclosing

wb_command -volume-to-surface-mapping ../${data}.nii.gz Conte69.R.midthickness.32k_fs_LR.surf.gii ./${data}.Conte69.r.func.gii -enclosing 


# transform to a cifti file
wb_command -cifti-create-dense-scalar ${data}.Conte69.l.dscalar.nii -left-metric ${data}.Conte69.l.func.gii 
wb_command -cifti-create-dense-scalar ${data}.Conte69.r.dscalar.nii -right-metric ${data}.Conte69.r.func.gii 

done

# sudo usermod -s /bin/bash qihong

# mask out subcortical
infolder='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
outfolder='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
mask_path='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks';
python_path='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
cd ${outfolder}

for data in ALFF-ctx-z-main-N2180-correctp05 ALFF-ctx-z-main-N2180 ; do
   for hemi in l r ; do

    indata_name=${data}.Conte69.${hemi}.dscalar.nii;
    outdata_name=${data}.Conte69.${hemi}.mask.func.gii;
    mask_name=iter15.thickness.${hemi}.AVERAGE.shape.gii;
    temp_name=${data}.Conte69.${hemi}.func.gii

  
    python3 /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/plot_surface/test.py ${infolder} ${indata_name} ${outfolder} ${outdata_name} ${mask_path} ${mask_name} ${temp_name}

  done
done



###
# combine left and right hemi
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb
for data in ALFF-ctx-z-main-N2180-correctp05 ALFF-ctx-z-main-N2180 ; do
wb_command -cifti-create-dense-scalar ${data}.Conte69.mask.dscalar.nii -left-metric ${data}.Conte69.l.mask.func.gii -right-metric ${data}.Conte69.r.mask.func.gii
done

rm -f *.l.* *.r.*











# post-hoc contrast maps
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb

for data in meanmap_N1-W-N2180 meanmap_N2-W-N2180 meanmap_N3-W-N2180 meanmap_REM-W-N2180 meanmap_Sleep-W-N2180 ; do
# map volume to surface
wb_command -volume-to-surface-mapping ../${data}.nii.gz Conte69.L.midthickness.32k_fs_LR.surf.gii ./${data}.Conte69.l.func.gii -enclosing

wb_command -volume-to-surface-mapping ../${data}.nii.gz Conte69.R.midthickness.32k_fs_LR.surf.gii ./${data}.Conte69.r.func.gii -enclosing 


# transform to a cifti file
wb_command -cifti-create-dense-scalar ${data}.Conte69.l.dscalar.nii -left-metric ${data}.Conte69.l.func.gii 
wb_command -cifti-create-dense-scalar ${data}.Conte69.r.dscalar.nii -right-metric ${data}.Conte69.r.func.gii 

done

# sudo usermod -s /bin/bash qihong

# mask out subcortical
infolder='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
outfolder='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
mask_path='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks';
python_path='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
cd ${outfolder}

for data in meanmap_N1-W-N2180 meanmap_N2-W-N2180 meanmap_N3-W-N2180 meanmap_REM-W-N2180 meanmap_Sleep-W-N2180 ; do
   for hemi in l r ; do

    indata_name=${data}.Conte69.${hemi}.dscalar.nii;
    outdata_name=${data}.Conte69.${hemi}.mask.func.gii;
    mask_name=iter15.thickness.${hemi}.AVERAGE.shape.gii;
    temp_name=${data}.Conte69.${hemi}.func.gii

  
    python3 /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/plot_surface/test.py ${infolder} ${indata_name} ${outfolder} ${outdata_name} ${mask_path} ${mask_name} ${temp_name}

  done
done



###
# combine left and right hemi
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb
for data in meanmap_N1-W-N2180 meanmap_N2-W-N2180 meanmap_N3-W-N2180 meanmap_REM-W-N2180 meanmap_Sleep-W-N2180 ; do
wb_command -cifti-create-dense-scalar ${data}.Conte69.mask.dscalar.nii -left-metric ${data}.Conte69.l.mask.func.gii -right-metric ${data}.Conte69.r.mask.func.gii
done

rm -f *.l.* *.r.*







# post-hoc contrast maps
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb

for data in meanmap_N1-W-N2180-correctp05 meanmap_N2-W-N2180-correctp05 meanmap_N3-W-N2180-correctp05 meanmap_REM-W-N2180-correctp05 meanmap_Sleep-W-N2180-correctp05 ; do
# map volume to surface
wb_command -volume-to-surface-mapping ../${data}.nii.gz Conte69.L.midthickness.32k_fs_LR.surf.gii ./${data}.Conte69.l.func.gii -enclosing

wb_command -volume-to-surface-mapping ../${data}.nii.gz Conte69.R.midthickness.32k_fs_LR.surf.gii ./${data}.Conte69.r.func.gii -enclosing 


# transform to a cifti file
wb_command -cifti-create-dense-scalar ${data}.Conte69.l.dscalar.nii -left-metric ${data}.Conte69.l.func.gii 
wb_command -cifti-create-dense-scalar ${data}.Conte69.r.dscalar.nii -right-metric ${data}.Conte69.r.func.gii 

done

# sudo usermod -s /bin/bash qihong

# mask out subcortical
infolder='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
outfolder='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
mask_path='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks';
python_path='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
cd ${outfolder}

for data in meanmap_N1-W-N2180-correctp05 meanmap_N2-W-N2180-correctp05 meanmap_N3-W-N2180-correctp05 meanmap_REM-W-N2180-correctp05 meanmap_Sleep-W-N2180-correctp05 ; do
   for hemi in l r ; do

    indata_name=${data}.Conte69.${hemi}.dscalar.nii;
    outdata_name=${data}.Conte69.${hemi}.mask.func.gii;
    mask_name=iter15.thickness.${hemi}.AVERAGE.shape.gii;
    temp_name=${data}.Conte69.${hemi}.func.gii

  
    python3 /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/plot_surface/test.py ${infolder} ${indata_name} ${outfolder} ${outdata_name} ${mask_path} ${mask_name} ${temp_name}

  done
done



###
# combine left and right hemi
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb
for data in meanmap_N1-W-N2180-correctp05 meanmap_N2-W-N2180-correctp05 meanmap_N3-W-N2180-correctp05 meanmap_REM-W-N2180-correctp05 meanmap_Sleep-W-N2180-correctp05 ; do
wb_command -cifti-create-dense-scalar ${data}.Conte69.mask.dscalar.nii -left-metric ${data}.Conte69.l.mask.func.gii -right-metric ${data}.Conte69.r.mask.func.gii
done

rm -f *.l.* *.r.*








# stage mean ALFF maps
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb

for data in W N1 N2 N3 REM ; do
# map volume to surface
wb_command -volume-to-surface-mapping ../${data}_ALFF-ctx-z_mean-N2180.nii.gz Conte69.L.midthickness.32k_fs_LR.surf.gii ./${data}_ALFF-ctx-z_mean-N2180.Conte69.l.func.gii -trilinear

wb_command -volume-to-surface-mapping ../${data}_ALFF-ctx-z_mean-N2180.nii.gz Conte69.R.midthickness.32k_fs_LR.surf.gii ./${data}_ALFF-ctx-z_mean-N2180.Conte69.r.func.gii -trilinear 


# transform to a cifti file
wb_command -cifti-create-dense-scalar ${data}_ALFF-ctx-z_mean-N2180.Conte69.l.dscalar.nii -left-metric ${data}_ALFF-ctx-z_mean-N2180.Conte69.l.func.gii 
wb_command -cifti-create-dense-scalar ${data}_ALFF-ctx-z_mean-N2180.Conte69.r.dscalar.nii -right-metric ${data}_ALFF-ctx-z_mean-N2180.Conte69.r.func.gii 

done



# mask out subcortical
infolder='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
outfolder='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
mask_path='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/masks';
python_path='/nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb';
cd ${outfolder}

for data in W N1 N2 N3 REM ; do
   for hemi in l r ; do

    indata_name=${data}_ALFF-ctx-z_mean-N2180.Conte69.${hemi}.dscalar.nii;
    outdata_name=${data}_ALFF-ctx-z_mean-N2180.Conte69.${hemi}.mask.func.gii;
    mask_name=iter15.thickness.${hemi}.AVERAGE.shape.gii;
    temp_name=${data}_ALFF-ctx-z_mean-N2180.Conte69.${hemi}.func.gii
  
    python3 /nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/plot_surface/test.py ${infolder} ${indata_name} ${outfolder} ${outdata_name} ${mask_path} ${mask_name} ${temp_name}

  done
done



###
# combine left and right hemi
cd /nd_disk2/qihong/Sleep_PKU/brain_restoration/processed/ALFF/stats/for_wb
for data in W N1 N2 N3 REM ; do
wb_command -cifti-create-dense-scalar ${data}_ALFF-ctx-z_mean-N2180.Conte69.mask.dscalar.nii -left-metric ${data}_ALFF-ctx-z_mean-N2180.Conte69.l.mask.func.gii -right-metric ${data}_ALFF-ctx-z_mean-N2180.Conte69.r.mask.func.gii
done


rm -f *.l.* *.r.*

