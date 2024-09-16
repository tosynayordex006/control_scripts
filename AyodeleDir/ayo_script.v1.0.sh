#!/bin/bash
# Creating backup directory
echo "Starting backup job...."
mkdir "/home/Cloudserver/scripts/practicedir_ayodele_aprill24/backupdir"

# Copy a file into backupdir  directory
echo "Copying /home/Cloudserver/scripts/first_file.txt to /home/Cloudserver/scripts/practicedir_ayodele_aprill24/backupdir"
cp /home/Cloudserver/scripts/first_file.txt /home/Cloudserver/scripts/practicedir_ayodele_aprill24/backupdir

# listing the contents of files in backupdir directory
echo "Listing the content of files in /home/Cloudserver/scripts/practicedir_ayodele_aprill24/backupdir"
ls -ltr "/home/Cloudserver/scripts/practicedir_ayodele_aprill24/backupdir"


# Counting the contents of files in backupdir directory
echo "Counting te contents of file in  /home/Cloudserver/scripts/practicedir_ayodele_aprill24/backupdir"
ls -ltr /home/Cloudserver/scripts/practicedir_ayodele_aprill24/backupdir | wc -l

