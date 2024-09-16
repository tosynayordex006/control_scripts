#!/bin/bash
# command line argument
SRC_FILE=$1
BASE_BACKUP_LOC=$2
runner=$3
BK_TYPE=$4

echo "we have $# command line argument in the script"

# Ckecking to know the backup type
if [[ ${BK_TYPE} == f || F ]]
then
	echo "The backup copy is a file"
	BK_TYPE="file"
else
	echo "The backup copy is a directory"
	BK_TYPE="file"
fi

# environmental variable
TS=`date +"%d%m%y%H%M%S"`
#PRACTICEDIR="/home/Cloudserver/scripts/practicedir_ayodele_aprill24"
BK_LOC=${BASE_BACKUP_LOC}/${runner}/${BK_TYPE}/${TS}


# To check usage of command line arguments

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
