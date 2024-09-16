#!/bin/bash
# command line argument
SRC_FILE=$1
backup=$2
runner=$3

# environmental variable
TS=`date +"%d%m%y%H%M%S"`
PRACTICEDIR="/home/Cloudserver/scripts/practicedir_ayodele_aprill24"
BK_LOC=${PRACTICEDIR}/${backup}/${runner}/${TS}

# Creating backup directory
echo "Starting backup job...."
mkdir -p "${BK_LOC}"

# Copy a file into backupdir  directory
echo "Copying ${SRC_FILE} to ${BK_LOC}"
cp -r ${SRC_FILE} ${BK_LOC}


# listing the contents of files in backupdir directory
echo "Listing the content of files in ${BK_LOC}"
ls -ltr "${BK_LOC}"


# Counting the contents of files in backupdir directory
echo "Counting te contents of file in  ${BK_LOC}"
ls -ltr ${BK_LOC} | wc -l

# Ending script
echo "ending backup Job......"
