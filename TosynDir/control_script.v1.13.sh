#!/bin/bash

# Function Definition

f_d_backup()
{
	echo "Welcome to the file or directory backup function"
	echo "Starting Job at $TS"
	echo "the arguments passed into this function are ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE}"
        echo "The first command line argument is: $1"
        echo "The second command line argument is: $2"
        echo "The third command line argument is: $3"
	echo "The fourth command line argument is: $4"
	echo "The fifth command line argument is: $5"
	echo "The sixth command line argument is: $6"
	echo "we have $# command line arguments in this backup scripts"

	 # Creating logging location
	 
#=`date +"%d%m%y%H%M%S"`
#LOG_LOCATION=${BASE_BACKUP_LOC}/${RUNNER}/LOG/$TS
#mkdir -p ${LOG_LOCATION}
#echo "Starting backup job at $....">>${LOG_LOCATION}/${LOG_FILE}
#echo "Creating a log location.....">>${LOG_LOCATION}/${LOG_FILE}
#echo "Log location is ${LOG_LOCATION}">>${LOG_LOCATION}/${LOG_FILE}
#echo "we have $# command line arg in the backup scripts">>${LOG_LOCATION}/${LOG_FILE}

	# Conditional check
	if [[ ${BK_TYPE} == f || ${BK_TYPE} == F ]]
	then 
		echo "BK_TYPE is a file"
		BK_TYPE='File'
	else
		echo "BK_TYPE is a directory"
		BK_TYPE='Directory'
	fi


	# creating the backup directory
	BK_LOC=${BASE_BACKUP_LOC}/${RUNNER}/${BK_TYPE}/$TS
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
}

f_d_delete()
{
	echo "Welcome to the file or directory function"
	echo "Starting Job at $TS"
	echo "the arguments passed into this function are ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE}"
	echo "The first command line argument is: $1"
	echo "The second command line argument is: $2"
	echo "The third command line argument is: $3"
	echo "The fourth command line argument is: $4"
	echo "The fifth command line argument is: $5"
	echo "The sixth command line argument is: $6"
	echo "we have $# command line arguments for this conditional check"

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
}

scp_f_d()
{
#Copying file or directory into cloud server
echo "Welcome to secure copy"
echo "starting job at $TS"
echo "The argument passed into this function are ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE} ${DST}"
echo "The first command line argument is: $1"
echo "The second command line argument is: $2"
echo "The third command line argument is: $3"
echo "The fourth command line argument is: $4"
echo "The fifth command line argument is: $5"
echo "The sixth command line argument is: $6"
echo "The seventh command line argument is: $7"
echo "we have $# command line arguments for this conditional check"
echo "SSHing into cloud server to create directory"
# conditional check for backup_type
if [[ ${BK_TYPE} == f ]]
then
        echo "Backup type is a file"
        BK_TYPE='File'
else
        echo "Backup type is a directory"
        BK_TYPE='Directory'
	fi
echo "sshing into cloud server"
#checking if the destination directory exist

ssh -p 2222 ${DST} "${SCRIPTS}/create_tosyn_dir.sh ${BASE_BACKUP_LOC} ${RUNNER} $TS"

echo "Copying a file into destination cloud server ${DST}"
scp -rP 2222 ${SOURCE} ${DST}:${BASE_BACKUP_LOC}/${RUNNER}/$TS
echo "Hi, the code is used to copy file to my cloud server"

}
# Main Body

TS=`date +"%d%m%y%H%M%S"`
CONTROL_FLAG=$1
DECISION=$2
SCRIPTS="/home/linuxuser/scripts"

if [[ ${CONTROL_FLAG} == "scheduled" ]]
then
	DECISION=$2
	SOURCE=$3
	BASE_BACKUP_LOC=$4
	RUNNER=$5
	BK_TYPE=$6
	DST=$7
	if [[ ${DECISION} == 1 ]]
	then
		CONTROL_FLAG=$1
		DECISION=$2
		SOURCE=$3
		BASE_BACKUP_LOC=$4
		RUNNER=$5
		BK_TYPE=$6
		if (( $# != 6 ))
		then 
			echo "We have $# command line arguments"
			echo "FAILED!!!
			USAGE:To run this script,you need these command line arguments:
			CONTROL_FLAG: which is used to select either scheduled or non scheduled,declared as Cl arg1
			DECISION: which is used to choose the desired function you want to call,declared as Cl arg2
			BACKUP SOURCE: which is the file that should be backed up,declared as CL arg3
			BACKUP TYPE: seperating files from directory declared as CL arg4
			BACKUP DESTINATION: path which is the location the source file will be copied to declared as Cl arg5
			RUNNER: which is the name in whose the backup should be referenced declared as CL arg6
			example: ./(scripts) CL arg1 CL arg2 CL arg3 CL arg4 CL arg5 CL arg6"
			exit
		fi
	fi
	if [[ ${DECISION} == 2 ]]
	then
		CONTROL_FLAG=$1
		DECISION=$2
		SOURCE=$3
		BASE_BACKUP_LOC=$4
		RUNNER=$5
		BK_TYPE=$6
		if (( $# != 6 ))
		then 
			echo echo "We have $# command line arguments"
			echo "FAILED!!!
			USAGE:To run this script,you need these command line arguments:
			CONTROL_FLAG: which is used to select either scheduled or non scheduled,declared as Cl arg1
			DECISION: which is used to choose the desired function you want to call,declared as Cl arg2
			BACKUP SOURCE: which is the file that should be backed up,declared as CL arg3
			BACKUP DESTINATION: path which is the location the source file will be copied to declared as Cl arg4
			BACKUP TYPE: seperating files from directory declared as CL arg5
			RUNNER: which is the name in whose the backup should be referenced declared as CL arg6
			example: ./(scripts) CL arg1 CL arg2 CL arg3 CL arg4 CL arg5 CL arg6"
			exit
		fi
	fi
	if [[ ${DECISION} == 3 ]]
	then
		CONTROL_FLAG=$1
		DECISION=$2
		SOURCE=$3
		BASE_BACKUP_LOC=$4
		RUNNER=$5
		BK_TYPE=$6
		DST=$7
		if (( $# != 7 ))
		then
			echo echo "We have $# command line arguments"
			echo "FAILED!!!
			USAGE:To run this script,you need these command line arguments:
			CONTROL_FLAG: which is used to select either scheduled or non scheduled,declared as Cl arg1
			DECISION: which is used to choose the desired function you want to call,declared as Cl arg2
			BACKUP SOURCE: which is the file that should be backed up,declared as CL arg3
			BACKUP DESTINATION: path which is the location the source file will be copied to declared as Cl arg4
			BACKUP TYPE: seperating files from directory declared as CL arg5
			RUNNER: which is the name in whose the backup should be referenced declared as CL arg6
			DST: Which is the name of the server we want to server declared as CL arg7
			example: ./(scripts) CL arg1 CL arg2 CL arg3 CL arg4 CL arg5 CL arg6 CL arg7"
			exit
		fi	
	fi
elif [[ ${CONTROL_FLAG} == nonscheduled ]]
then
	echo "welcome onboard!! we'll like to run an interview session with you"
	read -p "What do you want to do?
	Enter 1 for file or directroy backup
	Enter 2 for file or directory delete
	Enter 3 for SCP into cloud server to create directory
	Enter 4 for database logical backup
	entry: " DECISION
	if [[ ${DECISION} == 1 ]]
	then
		echo "welcome to file, directory backup function"
		read -p "Enter source file or directory:" SOURCE
		read -p "Enter Base Backup location:" BASE_BACKUP_LOC
		read -p "Enter the runner directory:" RUNNER
		read -p "Enter backup type file or directory:" BK_TYPE
		control=`echo ${DECISION}`
	fi
	if [[ ${DECISION} == 2 ]]
	then
		echo "welcome to file, directory delete function"
		read -p "Enter source file or directory: " SOURCE
		read -p "Enter Base Backup location: " BASE_BACKUP_LOC
		read -p "Enter the runner directory: " RUNNER
		read -p "Enter backup type file or directory: " BK_TYPE
		control=`echo ${DECISION}`
	fi
	if [[ ${DECISION} == 3 ]]
	then
		echo "welcome to file, directory scp function"
		read -p "Enter source file or directory: " SOURCE
		read -p "Enter Base Backup location: " BASE_BACKUP_LOC
		read -p "Enter the runner directory: " RUNNER
		read -p "Enter backup type file or directory: " BK_TYPE
		read -p "Enter destination server: " DST
		control=`echo ${DECISION}`
	fi
fi

case "${DECISION}" in
	1) echo "You selected the first option"
	   #Calling file or directory backup function
	   f_d_backup ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE}	
    	   ;;
        2) echo "You selected the second option"
           #Calling file or directory delete function
	   f_d_delete ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE}
	   ;;
        3) echo "You selected the third option"
           #Calling scp function
           scp_f_d ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE} ${DST}
 	   ;;
        *) echo "invalid option";;
esac

# end of scripts
TS=`date +"%%d%m%y%H%M%S"`
