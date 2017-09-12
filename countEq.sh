#/bin/bash
# Daniel Kennedy - djk2120@columbia.edu
# Sept 12, 2017

if [ -z "$*" ] 
then 
    #Handle missing command line argument
    echo " **** error no args"
else
    #Count the number of earthquakes in $1, the country specified on command line
    n=`tail +1 Year_Mag_Country.tsv |  grep -i $1 | wc -l`
    echo earthquakes 'in' $1: $n
fi