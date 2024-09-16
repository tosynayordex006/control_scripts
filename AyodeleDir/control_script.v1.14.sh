#!/bin/bash

# Function defination

f_d_backup()
{
	# creating a logging location
	LOG_LOC=${BASE_BACKUP_LOC}/${runner}/LOG/$TS
	mkdir -p ${LOG_LOC}
	echo "You selected the first option">>${LOG_LOC}/${LOG_FILE}
	echo "creating the logging location">>${LOG_LOC}/${LOG_FILE}
	echo "Welcome to file or directory backup function">>${LOG_LOC}/${LOG_FILE}
	echo "Starting Job at $TS">>${LOG_LOC}/${LOG_FILE}
	echo "The arguments passed into this function are ${CONTROL_FLAG} ${DECISION} ${SRC_FILE} ${BASE_BACKUP_LOC} ${runner} ${BK_TYPE} ${LOG_FILE}">>${LOG_LOC}/${LOG_FILE}
	echo "The first command line argument is: $1">>${LOG_LOC}/${LOG_FILE}
	echo "The second command line argument is: $2">>${LOG_LOC}/${LOG_FILE}
	echo "The third command line argument is: $3">>${LOG_LOC}/${LOG_FILE}
	echo "The fouth command line argument is: $4">>${LOG_LOC}/${LOG_FILE}
	echo "The fifth command line argument is: $5">>${LOG_LOC}/${LOG_FILE}
	echo "The sixth command line argument is: $6">>${LOG_LOC}/${LOG_FILE}
	echo "The seventh command line argument is: $7">>${LOG_LOC}/${LOG_FILE}
	echo "we have $# command line arguments for this conditional check">>${LOG_LOC}/${LOG_FILE}
# Ckecking to know the backup type
if [[ ${BK_TYPE} == f || ${BK_TYPE} == F ]]
then
	echo "The backup copy is a file">>${LOG_LOC}/${LOG_FILE}
	BK_TYPE="File"
else
	echo "The backup copy is a directory">>${LOG_LOC}/${LOG_FILE}
	BK_TYPE="Directory"
fi

# environmental variable
#PRACTICEDIR="/home/Cloudserver/scripts/practicedir_ayodele_aprill24"
BK_LOC=${BASE_BACKUP_LOC}/${runner}/${BK_TYPE}/${TS}

# Creating backup directory
#check if directory exist
if [[ -d ${BK_LOC} ]]
then 
	echo "directory already exist sleeping for 10 seconds">>${LOG_LOC}/${LOG_FILE}
	sleep 10
else
	echo "directoy does not exist, creating a new directory">>${LOG_LOC}/${LOG_FILE}
	mkdir -p "${BK_LOC}"

	# Checking exit status mission command  for mkidr

	if (( $? == 0 ))
	then
		echo "mkdir commad ran succesfully">>${LOG_LOC}/${LOG_FILE}
	else	
		echo "Mkdir command failed">>${LOG_LOC}/${LOG_FILE}
		exit
	fi	
fi


# Copy a file into backupdir  directory
echo "Copying ${SRC_FILE} to ${BK_LOC}">>${LOG_LOC}/${LOG_FILE}
cp -r ${SRC_FILE} ${BK_LOC}


# Checking exit status mission command  for cp

if (( $? == 0 ))
then
        echo "cp commad ran succesfully">>${LOG_LOC}/${LOG_FILE}
else
        echo "cp command failed">>${LOG_LOC}/${LOG_FILE}
        exit
fi

# listing the contents of files in backupdir directory
echo "Listing the content of files in ${BK_LOC}">>${LOG_LOC}/${LOG_FILE}
ls -ltr "${BK_LOC}">>${LOG_LOC}/${LOG_FILE}


# Counting the contents of files in backupdir directory
echo "Counting te contents of file in  ${BK_LOC}">>${LOG_LOC}/${LOG_FILE}
ls -ltr ${BK_LOC} | wc -l>>${LOG_LOC}/${LOG_FILE}

}

f_d_delete()
{
	LOG_LOC=${BASE_BACKUP_LOC}/${runner}/LOG/$TS
	mkdir -p ${LOG_LOC}
	echo "You selected the first option">>${LOG_LOC}/${LOG_FILE}
	echo "creating the logging location">>${LOG_LOC}/${LOG_FILE}
	echo "Welcome to the file or directory function">>${LOG_LOC}/${LOG_FILE}
	echo "Starting Job at $TS">>${LOG_LOC}/${LOG_FILE}
	echo "the arguments passed into this function are ${CONTROL_FLAG} ${DECISION} ${SRC_FILE} ${BASE_BACKUP_LOC} ${runner} ${BK_TYPE} ${LOG_FILE}">>${LOG_LOC}/${LOG_FILE}
	echo "The first command line argument is: $1">>${LOG_LOC}/${LOG_FILE}
	echo "The second command line argument is: $2">>${LOG_LOC}/${LOG_FILE}
	echo "The third command line argument is: $3">>${LOG_LOC}/${LOG_FILE}
	echo "The fourth command line argument is: $4">>${LOG_LOC}/${LOG_FILE}
	echo "The fifth command line argument is: $5">>${LOG_LOC}/${LOG_FILE}
	echo "The sixth command line argument is: $6">>${LOG_LOC}/${LOG_FILE}
	echo "The seventh command line argument is: $7">>${LOG_LOC}/${LOG_FILE}
	echo "we have $# command line arguments for this conditional check">>${LOG_LOC}/${LOG_FILE}

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
}

scp_f_d()
{
#Copying file or directory into on premise server
LOG_LOC=${BASE_BACKUP_LOC}/${runner}/LOG/$TS
mkdir -p ${LOG_LOC}
echo "You selected the first option">>${LOG_LOC}/${LOG_FILE}
echo "creating the logging location">>${LOG_LOC}/${LOG_FILE}
echo "Welcome to secure copy">>${LOG_LOC}/${LOG_FILE}
echo "starting job at $TS">>${LOG_LOC}/${LOG_FILE}
echo "The argument passed into this function are ${CONTROL_FLAG} ${DECISION} ${SRC_FILE} ${BASE_BACKUP_LOC} ${runner} ${BK_TYPE} ${DST} ${LOG_FILE}">>${LOG_LOC}/${LOG_FILE}
echo "The first command line argument is: $1">>${LOG_LOC}/${LOG_FILE}
echo "The second command line argument is: $2">>${LOG_LOC}/${LOG_FILE}
echo "The third command line argument is: $3">>${LOG_LOC}/${LOG_FILE}
echo "The fourth command line argument is: $4">>${LOG_LOC}/${LOG_FILE}
echo "The fifth command line argument is: $5">>${LOG_LOC}/${LOG_FILE}
echo "The sixth command line argument is: $6">>${LOG_LOC}/${LOG_FILE}
echo "The seventh command line argument is: $7">>${LOG_LOC}/${LOG_FILE}
echo "The eighth command line argument is: $8">>${LOG_LOC}/${LOG_FILE}
echo "we have $# command line arguments for this conditional check">>${LOG_LOC}/${LOG_FILE}

# Conditional check for backup_type
if [[ ${BK_TYPE} == f ]]
then
        echo "Backup type is a file">>${LOG_LOC}/${LOG_FILE}
        BK_TYPE='File'
else
        echo "Backup type is a directory">>${LOG_LOC}/${LOG_FILE}
        BK_TYPE='Directory'
        fi

#copying file or directory into on premise sever
echo "SSHing into on premise server to create directory" >>${LOG_LOC}/${LOG_FILE}
ssh -p 22 ${DST} "${SCRIPTS}/create_tosyn_dir.sh ${BASE_BACKUP_LOC} ${RUNNER} $TS">>${LOG_LOC}/${LOG_FILE}
#scp the file into destination folder in the on prem server
echo "copying file or directory into on premise server ${DST}">>${LOG_LOC}/${LOG_FILE}
scp -rP 22 ${SRC_FILE} ${DST}:${BASE_BACKUP_LOC}/${RUNNER}/${TS}
echo "Hi, the code is used to copy file into my on prem server">>${LOG_LOC}/${LOG_FILE}

}


# Main body

TS=`date +"%d%m%y%H%M%S"` 

CONTROL_FLAG=$1
DECISION=$2
SCRIPTS="/home/localhost/scripts"


if [[ ${CONTROL_FLAG} == "scheduled" ]] 
then 
	DECISION=$2
	SRC_FILE=$3
	BASE_BACKUP_LOC=$4
	runner=$5
	BK_TYPE=$6
	DST=$7
	LOG_FILE=$8

	if [[ ${DECISION} == 1 ]]
	then 
		CONTROL_FLAG=$1
		DECISION=$2
		SRC_FILE=$3
		BASE_BACKUP_LOC=$4
		runner=$5
		BK_TYPE=$6
		LOG_FILE=$7
		if (( $# != 7 ))
		then 
			echo "We have $# command line arguments">>${LOG_LOC}/${LOG_FILE}
			echo "FAILED!!!
			USAGE:To run this script,you need these command line arguments:
			CONTROL_FLAG: which is used to select either scheduled or non scheduled,declared as Cl arg1
			DECISION: which is used to choose the desired function you want to call,declared as Cl arg2
			BACKUP SOURCE: which is the file that should be backed up,declared as CL arg3
			BACKUP TYPE: seperating files from directory declared as CL arg4
			BACKUP DESTINATION: path which is the location the source file will be copied to declared as Cl arg5
			RUNNER: which is the name in whose the backup should be referenced declared as CL arg6
			example: ./(scripts) CL arg1 CL arg2 CL arg3 CL arg4 CL arg5 CL arg6">>${LOG_LOC}/${LOG_FILE}
			exit
		fi
	fi
	if  [[ ${DECISION} == 2 ]]
	then 
		CONTROL_FLAG=$1
		DECISION=$2
		SRC_FILE=$3
		BASE_BACKUP_LOC=$4
		runner=$5
		BK_TYPE=$6
		LOG_FILE=$7
		if (( $# != 7 ))
		then
        		echo "We have $# command line arguments">>${LOG_LOC}/${LOG_FILE}
        		echo "FAILED!!!
        		USAGE:To run this script,you need these command line arguments:
        		CONTROL_FLAG: which is used to select either scheduled or non scheduled,declared as Cl arg1
        		DECISION: which is used to choose the desired function you want to call,declared as Cl arg2
        		BACKUP SOURCE: which is the file that should be backed up,declared as CL arg3
        		BACKUP TYPE: seperating files from directory declared as CL arg4
        		BACKUP DESTINATION: path which is the location the source file will be copied to declared as Cl arg5
        		RUNNER: which is the name in whose the backup should be referenced declared as CL arg6
        		example: ./(scripts) CL arg1 CL arg2 CL arg3 CL arg4 CL arg5 CL arg6">>${LOG_LOC}/${LOG_FILE}
        		exit
		fi
	fi
	if 	[[ ${DECISION} == 3 ]]
	then
		CONTROL_FLAG=$1
		DECISION=$2
		SRC_FILE=$3
		BASE_BACKUP_LOC=$4
		runner=$5
		BK_TYPE=$6
		DST=$7
		LOG_FILE=$8
		if (( $# != 8 ))
		then
			echo "We have $# command line arguments">>${LOG_LOC}/${LOG_FILE}
			echo "FAILED!!!
			USAGE:To run this script,you need these command line arguments:
			CONTROL_FLAG: which is used to select either scheduled or non scheduled,declared as Cl arg1
			DECISION: which is used to choose the desired function you want to call,declared as Cl arg2
			BACKUP SOURCE: which is the file that should be backed up,declared as CL arg3
			BACKUP TYPE: seperating files from directory declared as CL arg4
			BACKUP DESTINATION: path which is the location the source file will be copied to declared as Cl arg5
			RUNNER: which is the name in whose the backup should be referenced declared as CL arg6
			example: ./(scripts) CL arg1 CL arg2 CL arg3 CL arg4 CL arg5 CL arg6">>${LOG_LOC}/${LOG_FILE}
			exit
		fi
	fi 

elif [[ ${CONTROL_FLAG} == nonscheduled ]]
then 
	echo "Welcome onboard!! we'll like to run an interview session with you based on what you'd like to do with this code"
	read -p "what do you want to do?
	enter 1 for file or directory backup
	enter 2 for file or directory delete
	enter 3 for SCP intpo cloud server to create directory
	entry: " DECISION
	if [[ ${DECISION} == 1 ]]
	then
		echo "WElcome to file, directory backup function" 
		read -p "Enter source file or directroy: " SRC_FILE
		read -p "Enter Base backup location: " BASE_BACKUP_LOC
		read -p "Enter the runner directory: " runner
		read -p "Enter backup type file or directory: " BK_TYPE
		read -p "Enter log file or directory: " LOG_FILE
		control=`echo ${DECISION}`
	fi
	if [[ ${DECISION} == 2 ]]
	then
		echo "WElcome to file, directory delete function"
		read -p "Enter source file or directroy: " SRC_FILE
		read -p "Enter Base backup location: " BASE_BACKUP_LOC
		read -p "Enter the runner directory: " runner
		read -p "Enter backup type file or directory: " BK_TYPE
		read -p "Enter LOG file or directory: " LOG_FILE
		control=`echo ${DECISION}`
	fi
	if [[ ${DECISION} == 3 ]]
	then	
		echo "WElcome to file, directory delete function"
		read -p "Enter source file or directroy: " SRC_FILE
		read -p "Enter Base backup location: " BASE_BACKUP_LOC
		read -p "Enter the runner directory: " runner
		read -p "Enter backup type file or directory: " BK_TYPE
		read -p "Enter Destination server: " DST
		read -p "Enter LOG file or directory: " LOG_FILE
		control=`echo ${DECISION}`
	fi
fi


case "${DECISION}" in
	1) echo "You selected the first option"
	#Calling file or directory backup function 
	f_d_backup ${CONTROL_FLAG} ${DECISION} ${SRC_FILE} ${BASE_BACKUP_LOC} ${runner} ${BK_TYPE} ${LOG_FILE}
	;;

	2) echo "You selected the second option"
	#Calling file or directory delete function
	f_d_delete ${CONTROL_FLAG} ${DECISION} ${SRC_FILE} ${BASE_BACKUP_LOC} ${runner} ${BK_TYPE} ${LOG_FILE}
	;;

	3) echo "You selected the third option"
	#Calling scp function to create directory in Cloudserver
	scp_f_d ${CONTROL_FLAG} ${DECISION} ${SRC_FILE} ${BASE_BACKUP_LOC} ${runner} ${BK_TYPE} ${DST} ${LOG_FILE}
	;;
	
	4) echo "Invalid option";;
esac

# end of scripts
TS=`date +"%d%m%y%H%M%S"`
echo "ending backup Job at $TS......">>${LOG_LOC}/${LOG_FILE}
