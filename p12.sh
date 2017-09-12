#/bin/bash
# Daniel Kennedy - djk2120@columbia.edu
# Sept 12, 2017

# extract 10 years with most earthquakes
years=`tail +2 Year_Mag_Country.tsv | cut -f 1 | uniq -c | sort -nr | head | cut -d ' ' -f 4`

# loop through the years, writing EQs from that year to file
for year in $years
do
    echo `head -n 1 Year_Mag_Country.tsv` > $year-earthquakes.txt #header
    grep $year Year_Mag_Country.tsv >> $year-earthquakes.txt
done