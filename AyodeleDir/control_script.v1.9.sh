#!/bin/bash
# command line argument
SRC_FILE=$1
BASE_BACKUP_LOC=$2
runner=$3
BK_TYPE=$4
LOGS=$5


TS=`date +"%d%m%y%H%M%S"`
# Creating Logging directory
LOG_LOC=${BASE_BACKUP_LOC}/${runner}/LOG/${TS}

mkdir -p ${LOG_LOC}

echo "we have $# command line argument in the script">>${LOG_LOC}/${LOGS}

# Ckecking to know the backup type
if [[ ${BK_TYPE} == f || ${BK_TYPE} == F ]]
then
	echo "The backup copy is a file">>${LOG_LOC}/${LOGS}
	BK_TYPE="File"
else
	echo "The backup copy is a directory">>${LOG_LOC}/${LOGS}
	BK_TYPE="Directory"
fi

# environmental variable
TS=`date +"%d%m%y%H%M%S"`
#PRACTICEDIR="/home/Cloudserver/scripts/practicedir_ayodele_aprill24"
BK_LOC=${BASE_BACKUP_LOC}/${runner}/${BK_TYPE}/${TS}


# To check usage of command line arguments

if (( $# != 5 ))
then
	echo "FAILED!!!
	USAGE:To run this script,you need these command line arguments:
	BACKUP SOURCE: which is the file that should be backed up,declared as CL arg1
	BACKUP DESTINATION: path which is the location the source file will be copied to declared as CL arg2
	RUNNER: which is the name in whose the backup should be referenced declared as CL arg3
	BACKUP TYPE: seperating files from directory declared as CL arg4
	example: ./(script) CL arg1 CL arg2 CL arg3 CL arg4">>${LOG_LOC}/${LOGS}
	exit
fi

# Creating backup directory
echo "Starting backup job....">>${LOG_LOC}/${LOGS}

#check if directory exist
if [[ -d ${BK_LOC} ]]
then 
	echo "directory already exist sleeping for 10 seconds">>${LOG_LOC}/${LOGS}
	sleep 10
else
	echo "directoy does not exist, creating a new directory">>${LOG_LOC}/${LOGS}
	mkdir -p "${BK_LOC}"

	# Checking exit status mission command  for mkidr

	if [[ $? == 0 ]]
	then
		echo "mkdir commad ran succesfully">>${LOG_LOC}/${LOGS}
	else	
		echo "Mkdir command failed">>${LOG_LOC}/${LOGS}
		exit
	fi	
fi


# Copy a file into backupdir  directory
echo "Copying ${SRC_FILE} to ${BK_LOC}">>${LOG_LOC}/${LOGS}
cp -r ${SRC_FILE} ${BK_LOC}


# Checking exit status mission command  for cp

if [[ $? == 0 ]]
then
        echo "cp commad ran succesfully">>${LOG_LOC}/${LOGS}
else
        echo "cp command failed">>${LOG_LOC}/${LOGS}
        exit
fi

# listing the contents of files in backupdir directory
echo "Listing the content of files in ${BK_LOC}">>${LOG_LOC}/${LOGS}
ls -ltr "${BK_LOC}"


# Counting the contents of files in backupdir directory
echo "Counting te contents of file in  ${BK_LOC}">>${LOG_LOC}/${LOGS}
ls -ltr ${BK_LOC} | wc -l

# Ending script
echo "ending backup Job......">>${LOG_LOC}/${LOGS}
