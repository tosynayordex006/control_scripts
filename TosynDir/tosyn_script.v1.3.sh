#!/bin/bash

# Command line argument
SOURCE=$1
backup=$2
Runner=$3
BK_LOC2=$4

#Environmental variables
PRACTICEDIR="/home/localhost/scripts/practicedir_tosyn_aprill24"
BK_LOC=${PRACTICEDIR}/${backup}/${Runner}

# create backup directory
echo "Starting the backup Job..."
mkdir -p ${BK_LOC}

# create second backup directory
echo "Starting the second backup job"
mkdir -p ${BK_LOC2}

# copy a file into backup directory
echo "copy ${SOURCE} to  ${BK_LOC}"
cp -r ${SOURCE} ${BK_LOC}

# copy file(s) into the second backup directory
echo "copy ${SOURCE} ${BK_LOC2}"
cp -r ${SOURCE} ${BK_LOC2}

#listing the contents of files in firstdir directory
echo "listing the content of files in ${BK_LOC}"
ls -ltr ${BK_LOC}

#listing the contents of files in second backup directory
echo "listing the content of files in ${BK_LOC2}"
ls -ltr ${BK_LOC2}

# Counting the content of files in firstdir directory
echo "counting the content of files in ${BK_LOC}"
ls -ltr ${BK_LOC} | wc -l

# Counting the content of files in second backup directory
echo "counting the content of files in ${BK_LOC2}"
ls -ltr ${BK_LOC2} | wc -l

# end of scripts
echo "Ending backup job...."

