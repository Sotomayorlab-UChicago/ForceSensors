#!/bin/sh

# run analysis procedure for SMD constant velocity 
#extracting forces from log files
for FILE in *.log
do
cat $FILE | awk '{if($1=="SMD")print $0}' > $FILE.smd
cat $FILE | awk '{if($1=="TCL:")print $0}' > $FILE.smd2
sed -i '1,2d' $FILE.smd2 
done
cat *.log.smd > ALL_SMD.log.smd
cat *.log.smd2 > ALL_SMD.log.smd2
vmd -dispdev text -e distance.tcl # calculates distances between SMD atoms
cat ALL_SMD.log.smd| awk '{ print $6 }' > force_SMD.txt
paste ALL_SMD.log.dist force_SMD.txt > SMD_force-end_end.txt 




