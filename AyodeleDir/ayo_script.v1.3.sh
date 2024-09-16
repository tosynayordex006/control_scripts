#!/bin/bash
# command line argument
SRC_FILE=$1
backup=$2
runner=$3
BK_LOC2=$4

# environmental variable
PRACTICEDIR="/home/Cloudserver/scripts/practicedir_ayodele_aprill24"
BK_LOC=${PRACTICEDIR}/${backup}/${runner}

# Creating backup directory
echo "Starting backup job...."
mkdir -p "${BK_LOC}"

# Creating backup directory2
echo "Starting the second backup job...."
mkdir -p "${BK_LOC2}"


# Copy a file into backupdir  directory
echo "Copying ${SRC_FILE} to ${BK_LOC}"
cp -r ${SRC_FILE} ${BK_LOC}

# Copy a directoru into backupdir  directory2
echo "Copying ${BK_LOC}to ${BK_LOC2}"
cp -r ${BK_LOC} ${BK_LOC2}


# listing the contents of files in backupdir directory
echo "Listing the content of files in ${BK_LOC}"
ls -ltr "${BK_LOC}"

# listing the contents of files in backupdir directory2
echo "Listing the content of files in ${BK_LOC2}"
ls -ltr "${BK_LOC2}"


# Counting the contents of files in backupdir directory
echo "Counting te contents of file in  ${BK_LOC}"
ls -ltr ${BK_LOC} | wc -l

# Counting the contents of files in backupdir directory2
echo "Counting te contents of file in  ${BK_LOC2}"
ls -ltr ${BK_LOC2} | wc -l

# Ending script
echo "ending backup Job......"
