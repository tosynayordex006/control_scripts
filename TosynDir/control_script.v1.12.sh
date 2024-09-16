#!/bin/bash

# Command line argument
SOURCE=$1
BASE_BACKUP_LOC=$2
RUNNER=$3
BK_TYPE=$4
LOG_FILE=$5
DST=$6

# Creating logging location

TS=`date +"%d%m%y%H%M%S"`
LOG_LOCATION=${BASE_BACKUP_LOC}/${RUNNER}/LOG/$TS
mkdir -p ${LOG_LOCATION}
echo "Starting backup job at $TS....">>${LOG_LOCATION}/${LOG_FILE}
echo "Creating a log location.....">>${LOG_LOCATION}/${LOG_FILE}
echo "Log location is ${LOG_LOCATION}">>${LOG_LOCATION}/${LOG_FILE}
echo "we have $# command line arg in the backup scripts">>${LOG_LOCATION}/${LOG_FILE}

# Conditional check
if [[ ${BK_TYPE} == f || ${BK_TYPE} == F ]]
then 
	echo "BK_TYPE is a file">>${LOG_LOCATION}/${LOG_FILE}
	BK_TYPE='File'
else
	echo "BK_TYPE is a directory">>${LOG_LOCATION}/${LOG_FILE}
	BK_TYPE='Directory'
fi

#Environmental variables
TS=`date +"%d%m%y%H%M%S"`
#PRACTICEDIR="/home/localhost/scripts/practicedir_tosyn_aprill24"
BK_LOC=${BASE_BACKUP_LOC}/${RUNNER}/${BK_TYPE}/$TS
SCRIPTS="/home/linuxuser/scripts"

# Checking usage of command line argmemnts

if (( $# != 6 ))
then 
	echo "FAILED!!!
	      USAGE:To run this script,you need these command line arguments:
	      BACKUP SOURCE: which is the file that should be backed up,declared as CL arg1
	      BACKUP DESTINATION: path which is the location the source file will be copied to declared as CL arg2
              RUNNER: which is the name in whose the backup should be referenced declared as CL arg3
	      BACKUP TYPE: seperating files from directory declared as CL arg4
              example: ./(script) CL arg1 CL arg2 CL arg3 CL arg4">>${LOG_LOCATION}/${LOG_FILE}
	      exit
fi

# creating the backup directory
if [[ -d ${BK_LOC} ]]
then
	echo "Directory already exist, sleeping for 10seconds.">>${LOG_LOCATION}/${LOG_FILE}
	sleep 10
else
	echo "Directory does not exist, creating a new directroy">>${LOG_LOCATION}/${LOG_FILE}
	mkdir -p ${BK_LOC}
fi
# Check for exit mission critical command Mkdir
if (( $? == 0 ))
then
	echo "Mkdir command ran successfully">>${LOG_LOCATION}/${LOG_FILE}
else
	echo "Mkdir command failed">>${LOG_LOCATION}/${LOG_FILE}
exit
fi

# copy a file into backup directory
echo "copy ${SOURCE} to  ${BK_LOC}">>${LOG_LOCATION}/${LOG_FILE}
cp -r ${SOURCE} ${BK_LOC}

# Check for exit mission critical command cp
if (( $? == 0 ))
then
	echo "cp command ran successful">>${LOG_LOCATION}/${LOG_FILE}
else
	echo "cpmmand failed">>${LOG_LOCATION}/${LOG_FILE}
exit
fi

#listing the contents of files in firstdir directory
echo "listing the content of files in ${BK_LOC}">>${LOG_LOCATION}/${LOG_FILE}
ls -ltr ${BK_LOC}>>${LOG_LOCATION}/${LOG_FILE}

# Counting the content of files in firstdir directory
echo "counting the content of files in ${BK_LOC}">>${LOG_LOCATION}/${LOG_FILE}
ls -ltr ${BK_LOC} | wc -l

# Deleting a file or directory

read -p "which directory do you want to delete a folder or file in:" INPUT
chosen=`ls | nl -s '. ' | grep ${INPUT}`
echo "You selected ${INPUT}"
cd ${INPUT}

ls | nl -s '. '
read -p "which directory or file do you want to delete?:" INPUT2
chosen2=`ls | nl -s '. ' | grep ${INPUT2}`
echo "You selected to delete ${INPUT2}"
chosen_last=`echo ${chosen2} | cut -f 2 -d ' '`

# prompting user on verification to delete 
read -p "Are u sure you want to delete ${chosen_last}? Yes(y) or No(n):" INPUT3
if [[ ${INPUT3} == Y || ${INPUT3} == y ]] 
then
	rm -r ${chosen_last}
	echo "deleting ${chosen_last}"
	ls | nl -s '. '
elif [[ ${INPUT3} == N || ${INPUT3} == n ]]
then
	echo "File not deleted..."
	ls | nl -s '. '
else
	echo "Invalid option"
fi

#Copying file or directory into cloud server

echo "SSHing into cloud server to create directory">>${LOG_LOCATION}/${LOG_FILE}
ssh -p 2222 ${DST} "${SCRIPTS}/create_tosyn_dir.sh ${BASE_BACKUP_LOC} ${RUNNER} ${TS}"

echo "Copying a file into destination cloud server ${DST}">>${LOG_LOCATION}/${LOG_FILE}
scp -rP 2222 ${SOURCE} ${DST}:${BASE_BACKUP_LOC}/${RUNNER}/${TS}

# end of scripts
TS=`date +"%d%m%Y%H%M%S"`
echo "Ending backup job at $TS....">>${LOG_LOCATION}/${LOG_FILE}

