#!/bin/bash

source /etc/profile.d/modules.sh
module load matlab/R2015b
matlab -nodisplay -nojvm -nosplash -nodesktop -r "run('make_paramfiles.m');exit"

