#!/bin/bash

#Environmental variables
PRACTICEDIR="/home/localhost/scripts"
SOURCE="/home/localhost/scripts/first_file.txt"
backup="firstdir_bk"

# create backup directory
echo "Starting the backup Job..."
mkdir ${PRACTICEDIR}/${backup}

# copy a file into backup directory
echo "copy ${SOURCE} to  ${PRACTICEDIR}/${backup}"
cp ${SOURCE} ${PRACTICEDIR}/${backup}

#listing the contents of files in firstdir directory
echo "listing the content of files in ${PRACTICEDIR}/${backup}"
ls -ltr ${PRACTICEDIR}/${backup}

# Counting the content of files in firstdir directory
echo "counting the content of files in ${PRACTICEDIR}/${backup}"
ls -ltr ${PRACTICEDIR}/${backup} | wc -l

# end of scripts
echo "Ending backup job...."

