#/bin/bash

n=`tail +1 Year_Mag_Country.tsv |  grep -i $1 | wc -l`
mag=`tail +1 Year_Mag_Country.tsv | grep -i $1 | cut -f 2 | sort -rn | head -n 1`

echo 'earthquakes in' $1 ':' $n
echo 'largest magnitude :' $mag