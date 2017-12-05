#!/bin/bash
# runs matlab script to create parameter files
# this can be run within this directory structure
# but in my workflow, I called it from "submit_ens"

if [ ! -d "paramfiles" ]; then
    mkdir paramfiles
fi

#needed on yellowstone
#source /etc/profile.d/modules.sh
#module load matlab/R2015b

matlab -nodisplay -nojvm -nosplash -nodesktop -r "run('make_paramfiles.m');exit"

