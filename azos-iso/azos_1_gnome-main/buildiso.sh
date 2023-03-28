#!/bin/bash

#BY RED FIRE SOFTWARE ENTERTAINMENT
#
#DO NOT MODIFY OR REDISTRIBUTE WITHOUT PERMISSION FROM
#RED FIRE SOFTWARE ENTERTAINMENT
#
#run this as ROOT or mkarchiso will NOT WORK!

clear
echo ==================
echo  AZOS ISO BUILDER.
echo ==================
read -n 1 -r -s -p $'Press any key to continue...\n'
clear
echo ==================
echo  AZOS ISO BUILDER.
echo ==================
echo Making Directory "work"
mkdir work
echo Successfully created "work" directory.
echo Making Directory "out"
mkdir out
echo Sucessfully created "out" directory.
echo Preparing to execute "mkarchiso"
echo Executing "mkarchiso"
echo The following process of "mkarchiso" may take up to 30-40 minutes to complete. 
sleep 3
clear
mkarchiso -v -w ./work -o ./out ./
echo Giving 60 seconds of extra troubleshoot time...
#clear
sleep 60
clear
echo ==================
echo  AZOS ISO BUILDER.
echo ==================
echo Successfully executed "mkarchiso"
echo Attempting to remove work directory...
rm -rf ./work
echo Removed work.
echo AZOS ISO Builder is done!
echo Exiting in 5...
sleep 1
clear
echo ==================
echo  AZOS ISO BUILDER.
echo ==================
echo Successfully executed "mkarchiso"
echo Attempting to remove work directory...
echo Successfully removed work.
echo AZOS ISO Builder is done!
echo Exiting in 4...
sleep 1
clear
echo ==================
echo  AZOS ISO BUILDER.
echo ==================
echo Done with "mkarchiso"
echo Attempting to remove work directory...
echo Successfully removed work.
echo AZOS ISO Builder is done!
echo Exiting in 3...
sleep 1
clear
echo ==================
echo  AZOS ISO BUILDER.
echo ==================
echo Successfully executed "mkarchiso"
echo Attempting to remove work directory...
echo Successfully removed work.
echo AZOS ISO Builder is done!
echo Exiting in 2...
sleep 1
clear
echo ==================
echo  AZOS ISO BUILDER.
echo ==================
echo Successfully executed "mkarchiso"
echo Attempting to remove work directory...
echo Successfully removed work.
echo AZOS ISO Builder is done!
echo Exiting in 1...
sleep 1
clear
exit
