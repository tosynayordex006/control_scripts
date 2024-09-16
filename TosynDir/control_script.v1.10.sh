#!/bin/bash

# Command line argument
SOURCE=$1
BASE_BACKUP_LOC=$2
RUNNER=$3
BK_TYPE=$4

# Conditional check
if [[ ${BK_TYPE} == f || ${BK_TYPE} == F ]]
then 
	echo "BK_TYPE is a file"
	BK_TYPE='File'
else
	echo "BK_TYPE is a directory"
	BK_TYPE='Directory'
fi

#Environmental variables
TS=`date +"%d%m%y%H%M%S"`
#PRACTICEDIR="/home/localhost/scripts/practicedir_tosyn_aprill24"
BK_LOC=${BASE_BACKUP_LOC}/${RUNNER}/${BK_TYPE}

echo "we have $# command line arg in the backup scripts"

# Checking usage of command line argmemnts

if (( $# != 4 ))
then 
	echo "FAILED!!!
	      USAGE:To run this script,you need these command line arguments:
	      BACKUP SOURCE: which is the file that should be backed up,declared as CL arg1
	      BACKUP DESTINATION: path which is the location the source file will be copied to declared as CL arg2
              RUNNER: which is the name in whose the backup should be referenced declared as CL arg3
	      BACKUP TYPE: seperating files from directory declared as CL arg4
              example: ./(script) CL arg1 CL arg2 CL arg3 CL arg4"
	      exit
fi

# creating the backup directory
if [[ -d ${BK_LOC} ]]
then
	echo "Directory already exist, sleeping for 10seconds."
	sleep 10
else
	echo "Directory does not exist, creating a new directroy"
	mkdir -p ${BK_LOC}
fi
# Check for exit mission critical command Mkdir
if (( $? == 0 ))
then
	echo "Mkdir command ran successfully"
else
	echo "Mkdir command failed"
exit
fi

# copy a file into backup directory
echo "copy ${SOURCE} to  ${BK_LOC}"
cp -r ${SOURCE} ${BK_LOC}

# Check for exit mission critical command cp
if (( $? == 0 ))
then
	echo "cp command ran successful"
else
	echo "cpmmand failed"
exit
fi

#listing the contents of files in firstdir directory
echo "listing the content of files in ${BK_LOC}"
ls -ltr ${BK_LOC}

# Counting the content of files in firstdir directory
echo "counting the content of files in ${BK_LOC}"
ls -ltr ${BK_LOC} | wc -l

# end of scripts
echo "Ending backup job...."

