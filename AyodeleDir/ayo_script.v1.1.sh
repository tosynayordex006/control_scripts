#!/bin/bash

PRACTICEDIR="/home/Cloudserver/scripts/practicedir_ayodele_aprill24"
SRC_FILE="/home/Cloudserver/scripts/first_file.txt"
backup="firstdir"


# Creating backup directory
echo "Starting backup job...."
mkdir "${PRACTICEDIR}/${backup}"

# Copy a file into backupdir  directory
echo "Copying ${SRC_FILE} to ${PRACTICEDIR}/${backup}"
cp ${SRC_FILE} ${PRACTICEDIR}/${backup}

# listing the contents of files in backupdir directory
echo "Listing the content of files in ${PRACTICEDIR}/${backup}"
ls -ltr "${PRACTICEDIR}/${backup}"


# Counting the contents of files in backupdir directory
echo "Counting te contents of file in  ${PRACTICEDIR}/${backup}"
ls -ltr ${PRACTICEDIR}/${backup} | wc -l

