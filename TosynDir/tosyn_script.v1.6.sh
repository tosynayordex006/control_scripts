#!/bin/bash

# Command line argument
SOURCE=$1
SOURCE2=$4
backup=$2
Runner=$3

#Environmental variables
TS=`date +"%d%m%y%H%M%S"`
PRACTICEDIR="/home/localhost/scripts/practicedir_tosyn_aprill24"
BK_LOC=${PRACTICEDIR}/${backup}/${Runner}/$TS

# create backup directory
echo "Starting the backup Job..."
mkdir -p ${BK_LOC}

# copy a file into backup directory
echo "copy ${SOURCE} to  ${BK_LOC}"
cp -r ${SOURCE} ${BK_LOC}
cp -r ${SOURCE2} ${BK_LOC}

#listing the contents of files in firstdir directory
echo "listing the content of files in ${BK_LOC}"
ls -ltr ${BK_LOC}

# Counting the content of files in firstdir directory
echo "counting the content of files in ${BK_LOC}"
ls -ltr ${BK_LOC} | wc -l

# end of scripts
echo "Ending backup job...."

