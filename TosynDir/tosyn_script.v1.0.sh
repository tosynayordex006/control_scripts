#!/bin/bash

# create backup directory
echo "Starting the backup Job..."
mkdir '/home/localhost/scripts/practicedir_tosyn_aprill24/firstdir'

# copy a file into backup directory
echo "copy /home/localhost/scripts/first_file.txt to  /home/localhost/scripts/practicedir_tosyn_aprill24/firstdir"
cp /home/localhost/scripts/first_file.txt /home/localhost/scripts/practicedir_tosyn_aprill24/firstdir

#listing the contents of files in firstdir directory
echo "listing the content of files in /home/localhost/scripts/practicedir_tosyn_aprill24/firstdir"
ls -ltr /home/localhost/scripts/practicedir_tosyn_aprill24/firstdir

# Counting the content of files in firstdir directory
echo "counting the content of files in /home/localhost/scripts/practicedir_tosyn_aprill24/firstdir"
ls -ltr | /home/localhost/scripts/practicedir_tosyn_aprill24/firstdir wc -l

# end of scripts
echo "Ending backup job...."

