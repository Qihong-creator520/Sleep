# generate surrogate maps, N = 10,000
from brainsmash.workbench.geo import volume
from brainsmash.mapgen.sampled import Sampled
import scipy.io as sio
import os

output_dir = "/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/raichle"
os.chdir(output_dir)

coord_file = "voxel_coordinates_CHCP_Yeo2011_6mm.txt"

filenames = volume(coord_file, output_dir)


brain_map = "glycolysis_CHCP_Yeo2011_6mm.txt"
gen = Sampled(x=brain_map, D=filenames['D'], index=filenames['index'], resample=True)
surrogate_maps = gen(n=10000)
sio.savemat('surrogate_maps_glycolysis_CHCP_Yeo2011_6mm_resample.mat',{'surrogate_maps':surrogate_maps})


brain_map = "cmro2_CHCP_Yeo2011_6mm.txt"
gen = Sampled(x=brain_map, D=filenames['D'], index=filenames['index'], resample=True)
surrogate_maps = gen(n=10000)
sio.savemat('surrogate_maps_cmro2_CHCP_Yeo2011_6mm_resample.mat',{'surrogate_maps':surrogate_maps})


brain_map = "cmrglc_CHCP_Yeo2011_6mm.txt"
gen = Sampled(x=brain_map, D=filenames['D'], index=filenames['index'], resample=True)
surrogate_maps = gen(n=10000)
sio.savemat('surrogate_maps_cmrglc_CHCP_Yeo2011_6mm_resample.mat',{'surrogate_maps':surrogate_maps})
