#/bin/bash
# Daniel Kennedy - djk2120@columbia.edu
# Sept 12, 2017

if [ -z "$*" ] 
then 
    #Handle missing command line argument
    echo " **** error no args"
else
    # Count the number of earthquakes in $1, the country specified on command line
    n=`tail +1 Year_Mag_Country.tsv |  grep -i $1 | wc -l`
    # Report the largest magnitude earthquake in $1, the country specified on command line
    mag=`tail +1 Year_Mag_Country.tsv | grep -i $1 | sort -rnk 2 | head -n 1 | cut -f 2`
    yr=`tail +1 Year_Mag_Country.tsv | grep -i $1 | sort -rnk 2 | head -n 1 | cut -f 1`

    echo earthquakes 'in' $1: $n
    echo largest magnitude: $mag 'in' $yr
fi