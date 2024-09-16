#!/bin/bash
# command line argument
SRC_FILE=$1
BASE_BACKUP_LOC=$2
runner=$3
BK_TYPE=$4
LOGS=$5
DST=$6


TS=`date +"%d%m%y%H%M%S"`
echo "Starting backup job at $TS...."
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
SCRIPTS="/home/localhost/scripts"

# To check usage of command line arguments

if (( $# != 6 ))
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

# deleting a file or directory
read -p "which directory do you want to delete a folder or file in:" INPUT
chosen=`ls | nl -s '. ' | grep ${INPUT}`
echo "You selected ${INPUT}"
cd ${INPUT}

ls | nl -s '. '
read -p "which directory do you want to delete?:" INPUT2
chosen2=`ls | nl -s '. ' | grep ${INPUT2}`
echo "You selected to delete ${INPUT2}"
chosen_last=`echo "${chosen2}" | cut -f 2 -d ' '`

# prompting the user on verification to delete
read -p "Are you sure you want to delete ${chosen_last}? Yes{y} or No{n}:" INPUT3
if [[ ${INPUT3} == y || ${INPUT3} == Y ]]
then 
	rm -r ${chosen_last}
	echo "Deleting ${chosen_last}"
	ls | nl -s '. '
elif [[ ${INPUT3} == n || ${INPUT3} == N ]]
then 
	echo "File not deleted...."
else
	echo "Ivalid option"

fi

#copying file or directory into on premise sever
echo "SSHing into on premise server to create directory" 
ssh -p 22 ${DST} "${SCRIPTS}/create_tosyn_dir.sh ${BASE_BACKUP_LOC} ${RUNNER} ${TS}"

#scp the file into destination folder in the on prem server
echo "copying file or directory into on premise server ${DST}"
scp -rP 22 ${SRC_FILE} ${DST}:${BASE_BACKUP_LOC}/${RUNNER}/${TS}

# Ending script
TS=`date +"%d%m%Y%H%M%S"`
echo "ending backup Job at $TS......">>${LOG_LOC}/${LOGS}
