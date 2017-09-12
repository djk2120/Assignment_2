#/bin/bash

n=`tail +1 Year_Mag_Country.tsv |  grep -i $1 | wc -l`
echo 'earthquakes in' $1 ':' $n