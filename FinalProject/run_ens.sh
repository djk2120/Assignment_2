#!/bin/bash
#  loops through the parameter files
#  setting up and submitting a simulation for each
#  called by job script "submit_ens"
#  n.b. not configured to run in this github

base="rc_ens/BR-CAX_I1PTCLM50_r251e_"
clone_case="BR-CAX_I1PTCLM50_r251_k4g7"
tmp="/glade/p/work/djk2120/clm4_5_16_r251/cime/scripts/BR-CAX_I1PTCLM50_r251_k4g7/user_nl_clm.tmp"
pdir="/glade/p/work/djk2120/clm4_5_16_r251/cime/scripts/rc_ens/paramfiles/"

cd ..

for i in $(ls /glade/p/work/djk2120/clm4_5_16_r251/cime/scripts/rc_ens/paramfiles/)
do
    
    a_case="BR-CAX_I1PTCLM50_r251e_"${i%.*}
    if [ ! -f '/glade2/scratch2/djk2120/rc_ens/'$a_case'.clm2.h1.2001-01-01-00000.nc' ]; then
	new_case=$base${i%.*}
	echo "BR-CAX_I1PTCLM50_r251e_"${i%.*}

	./create_clone --case $new_case --clone $clone_case

	cd $new_case
	./case.setup
	./xmlchange --file env_build.xml --id BUILD_COMPLETE --val "TRUE"  
	./xmlchange --file env_build.xml --id EXEROOT --val "/glade2/scratch2/djk2120/BR-CAX_I1PTCLM50_r251_k4g7/bld"  
	
	cp $tmp "user_nl_clm"
	echo "paramfile = '"$pdir$i"'" >> "user_nl_clm"
	./case.submit
	cd -
	
	sleep 30 #shared cluster
    fi
done
