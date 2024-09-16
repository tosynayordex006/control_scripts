#!/bin/bash

# Function Definition

f_d_backup()
{
	# Creating logging location
	LOG_LOCATION=${BASE_BACKUP_LOC}/${RUNNER}/LOG/$TS
	mkdir -p ${LOG_LOCATION}
	echo "You selected the first option">>${LOG_LOCATION}/${LOG_FILE}
	echo "Creating a log location.....">>${LOG_LOCATION}/${LOG_FILE}
	echo "Welcome to the file or directory backup function">>${LOG_LOCATION}/${LOG_FILE}
	echo "Starting Job at $TS">>${LOG_LOCATION}/${LOG_FILE}
	echo "the arguments passed into this function are ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE} ${LOG_FILE}">>${LOG_LOCATION}/${LOG_FILE}
        echo "The first command line argument is: $1">>${LOG_LOCATION}/${LOG_FILE}
        echo "The second command line argument is: $2">>${LOG_LOCATION}/${LOG_FILE}
        echo "The third command line argument is: $3">>${LOG_LOCATION}/${LOG_FILE}
	echo "The fourth command line argument is: $4">>${LOG_LOCATION}/${LOG_FILE}
	echo "The fifth command line argument is: $5">>${LOG_LOCATION}/${LOG_FILE}
	echo "The sixth command line argument is: $6">>${LOG_LOCATION}/${LOG_FILE}
	echo "The seventh command line argument is: $7">>${LOG_LOCATION}/${LOG_FILE}
	echo "we have $# command line arguments in this backup scripts">>${LOG_LOCATION}/${LOG_FILE}

	# Conditional check
	if [[ ${BK_TYPE} == f || ${BK_TYPE} == F ]]
	then 
		echo "BK_TYPE is a file">>${LOG_LOCATION}/${LOG_FILE}
		BK_TYPE='File'
	else
		echo "BK_TYPE is a directory">>${LOG_LOCATION}/${LOG_FILE}
		BK_TYPE='Directory'
	fi


	# creating the backup directory
	BK_LOC=${BASE_BACKUP_LOC}/${RUNNER}/${BK_TYPE}/$TS
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
	ls -ltr ${BK_LOC} | wc -l>>${LOG_LOCATION}/${LOG_FILE}
}

f_d_delete()
{
	# Creating logging location
	LOG_LOCATION=${BASE_BACKUP_LOC}/${RUNNER}/LOG/$TS
	mkdir -p ${LOG_LOCATION}
	echo "You selected the second option">>${LOG_LOCATION}/${LOG_FILE}
	echo "Welcome to the file or directory function">>${LOG_LOCATION}/${LOG_FILE}
	echo "Starting Job at $TS">>${LOG_LOCATION}/${LOG_FILE}
	echo "the arguments passed into this function are ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE}">>${LOG_LOCATION}/${LOG_FILE}
	echo "The first command line argument is: $1">>${LOG_LOCATION}/${LOG_FILE}
	echo "The second command line argument is: $2">>${LOG_LOCATION}/${LOG_FILE}
	echo "The third command line argument is: $3">>${LOG_LOCATION}/${LOG_FILE}
	echo "The fourth command line argument is: $4">>${LOG_LOCATION}/${LOG_FILE}
	echo "The fifth command line argument is: $5">>${LOG_LOCATION}/${LOG_FILE}
	echo "The sixth command line argument is: $6">>${LOG_LOCATION}/${LOG_FILE}
	echo "The seventh command line argument is: $7">>${LOG_LOCATION}/${LOG_FILE}
	echo "we have $# command line arguments for this conditional check">>${LOG_LOCATION}/${LOG_FILE}

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
# Creating logging location
LOG_LOCATION=${BASE_BACKUP_LOC}/${RUNNER}/LOG/$TS
mkdir -p ${LOG_LOCATION}
#Copying file or directory into cloud server
echo "You selected the third option">>${LOG_LOCATION}/${LOG_FILE}
echo "Welcome to secure copy">>${LOG_LOCATION}/${LOG_FILE}
echo "starting job at $TS">>${LOG_LOCATION}/${LOG_FILE}
echo "The argument passed into this function are ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE} ${DST}">>${LOG_LOCATION}/${LOG_FILE}
echo "The first command line argument is: $1">>${LOG_LOCATION}/${LOG_FILE}
echo "The second command line argument is: $2">>${LOG_LOCATION}/${LOG_FILE}
echo "The third command line argument is: $3">>${LOG_LOCATION}/${LOG_FILE}
echo "The fourth command line argument is: $4">>${LOG_LOCATION}/${LOG_FILE}
echo "The fifth command line argument is: $5">>${LOG_LOCATION}/${LOG_FILE}
echo "The sixth command line argument is: $6">>${LOG_LOCATION}/${LOG_FILE}
echo "The seventh command line argument is: $7">>${LOG_LOCATION}/${LOG_FILE}
echo "The eighth command line argument is: $8">>${LOG_LOCATION}/${LOG_FILE}
echo "we have $# command line arguments for this conditional check">>${LOG_LOCATION}/${LOG_FILE}
echo "SSHing into cloud server to create directory">>${LOG_LOCATION}/${LOG_FILE}
# conditional check for backup_type
if [[ ${BK_TYPE} == f ]]
then
        echo "Backup type is a file">>${LOG_LOCATION}/${LOG_FILE}
        BK_TYPE='File'
else
        echo "Backup type is a directory">>${LOG_LOCATION}/${LOG_FILE}
        BK_TYPE='Directory'
	fi
echo "sshing into cloud server">>${LOG_LOCATION}/${LOG_FILE}
#checking if the destination directory exist

ssh -p 2223 ${DST} "${SCRIPTS}/create_tosyn_dir.sh ${BASE_BACKUP_LOC} ${RUNNER} $TS ${SCHEMA} ${DUMPFILE}"

echo "Copying a file into destination cloud server ${DST}">>${LOG_LOCATION}/${LOG_FILE}
scp -rP 2223 ${SOURCE} ${DST}:${BASE_BACKUP_LOC}/${RUNNER}
echo "Hi, the code is used to copy file to my cloud server">>${LOG_LOCATION}/${LOG_FILE}

}

db_logical_backup()
{	
	
	# Creating logging location
	LOG_LOCATION=${BASE_BACKUP_LOC}/${RUNNER}/LOG/$TS
	mkdir -p ${LOG_LOCATION}
	echo "You selected the fourth option">>${LOG_LOCATION}/${LOG_FILE}
	echo "Welcome to database logical backup">>${LOG_LOCATION}/${LOG_FILE}
	echo "Starting Job ${TS}">>${LOG_LOCATION}/${LOG_FILE}
	echo "Data base logical backup is Under Construction">>${LOG_LOCATION}/${LOG_FILE}
	echo "The arguments passed into this scripts are ${CONTROL_FLAG} ${DECISION} ${BASE_BACKUP_LOC} ${RUNNER} ${database} ${LOG_FILE} $DST">>${LOG_LOCATION}/${LOG_FILE}
	echo "The first command line argument is,Control flag: $1">>${LOG_LOCATION}/${LOG_FILE}
	echo "The second command line argument is,Decision: $2">>${LOG_LOCATION}/${LOG_FILE}
	echo "The third command line argument is,Base backup location: $3">>${LOG_LOCATION}/${LOG_FILE}
	echo "The fourth command line argument is,Runner: $4">>${LOG_LOCATION}/${LOG_FILE}
	echo "The fifth command line argument is,database name: $5">>${LOG_LOCATION}/${LOG_FILE}
	echo "The sixth command line argument is,log file: $6">>${LOG_LOCATION}/${LOG_FILE}
	#echo "The seventth command line argument is,SOURCE 1: $7">>${LOG_LOCATION}/${LOG_FILE}
	#echo "The eighth command line argument is,SOURCE 2: $8">>${LOG_LOCATION}/${LOG_FILE}
	#echo "The nineth command line argument is,SOURCE 3: $9">>${LOG_LOCATION}/${LOG_FILE}
	echo "The tenth command line argument is,DST: $7">>${LOG_LOCATION}/${LOG_FILE}
	echo "we have $# command line arguments for this conditional check">>${LOG_LOCATION}/${LOG_FILE}
	

	BK_LOC=${BASE_BACKUP_LOC}/${RUNNER}
	PARFILE_LOC="/home/localhost/scripts/practicedir_tosyn_aprill24"
	counter=1
	# listing database to ensure it is running  in our local machine
	echo "listing database to ensure it is running  in our local machine">>${LOG_LOCATION}/${LOG_FILE}
	if ( ps -ef | grep pmon | grep ${database} )>>${LOG_LOCATION}/${LOG_FILE}
	then
		echo "Statement succeeded, database is running">>${LOG_LOCATION}/${LOG_FILE}
	else
		echo "Statements failed">>${LOG_LOCATION}/${LOG_FILE}
		exit
	fi
	# to set oracle parmeters correctly in their desgnated path
	echo "setting oracle database paths currently">>${LOG_LOCATION}/${LOG_FILE}

	. ${PARFILE_LOC}/oracle_env_DBAT21C.sh

	sqlplus -s mydb_temp/guitar<<EOF
	select * from global_name;
	SELECT sum(bytes)/1024/1024 AS "Size in MB" FROM dba_data_files;
	show user;
	spool /home/localhost/scripts/practicedir_tosyn_aprill24/database_user.log
	set heading off pagesize 0
	select username from all_users where username like '%APR%';
	spool off
	create or replace directory DATA_EXPORT_IMPORT as '${BK_LOC}';
	select directory_name, directory_path from dba_directories where directory_name='DATA_EXPORT_IMPORT';
EOF
	#creating the backup directory
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
	
	while read SCHEMA
	do
		echo "Schema ${counter} is ${SCHEMA}">>${LOG_LOCATION}/${LOG_FILE}
		#(( counter++ ))
		if (( ${counter} < 2 ))
		then
			echo "userid='/ as sysdba'"> ${PARFILE_LOC}/expdp_${SCHEMA}_${TS}.par
			echo "schemas=${SCHEMA}">> ${PARFILE_LOC}/expdp_${SCHEMA}_${TS}.par
			echo "dumpfile=expdp_${SCHEMA}.dmp">> ${PARFILE_LOC}/expdp_${SCHEMA}_${TS}.par
			echo "logfile=expdp_${SCHEMA}.log">>${PARFILE_LOC}/expdp_${SCHEMA}_${TS}.par
			echo "directory=DATA_EXPORT_IMPORT">>${PARFILE_LOC}/expdp_${SCHEMA}_${TS}.par
			
			#IMPORT SCHEMA
			
			# Run configuration file:
			echo "Runing configuration file....">>${LOG_LOCATION}/${LOG_FILE}
			expdp parfile=${PARFILE_LOC}/expdp_${SCHEMA}_${TS}.par>>${LOG_LOCATION}/${LOG_FILE}

			echo "userid='/ as sysdba'"> ${PARFILE_LOC}/impdp_${SCHEMA}_${RUNNER}.par
			echo "schemas=${SCHEMA}">> ${PARFILE_LOC}/impdp_${SCHEMA}_${RUNNER}.par
			echo "remap_schema=${SCHEMA}:STACK_APR24_${RUNNER}">>${PARFILE_LOC}/impdp_${SCHEMA}_${RUNNER}.par
			echo "dumpfile=expdp_${SCHEMA}.dmp">> ${PARFILE_LOC}/impdp_${SCHEMA}_${RUNNER}.par
			echo "logfile=remap_schema_${RUNNER}.log">> ${PARFILE_LOC}/impdp_${SCHEMA}_${RUNNER}.par
			echo "directory=DATA_EXPORT_IMPORT">> ${PARFILE_LOC}/impdp_${SCHEMA}_${RUNNER}.par
			echo "table_exists_action=replace">> ${PARFILE_LOC}/impdp_${SCHEMA}_${RUNNER}.par


			if (( $? == 0 ))
			then
				echo "The job ran successfully">>${LOG_LOCATION}/${LOG_FILE}
			else
			        echo "Job failed!!">>${LOG_LOCATION}/${LOG_FILE}
			        echo "please check database user.log file">>${LOG_LOCATION}/${LOG_FILE}
				exit
			fi
			(( counter++ ))	

		else
			break
		fi
        #Check logfile for success message
	echo "Checking logfile for success message">>${LOG_LOCATION}/${LOG_FILE}
	grep "successfully" ${BK_LOC}/expdp_${SCHEMA}.log>>${LOG_LOCATION}/${LOG_FILE}
	grep "ORA-" ${BK_LOC}/expdp_${SCHEMA}.log>>${LOG_LOCATION}/${LOG_FILE}

#done<${PARFILE_LOC}/database_user.log


# Generate import control script
# listing database to ensure it is running  in our local machine
echo '#!/bin/bash'>${PARFILE_LOC}/imp_cntrl_script.sh
echo "# to set oracle parmeters correctly in their desgnated path">>${PARFILE_LOC}/imp_cntrl_script.sh
echo "# setting oracle database paths currently">>${PARFILE_LOC}/imp_cntrl_script.sh

echo ". /home/Cloudserver/scripts/practicedir_favour_aprill24/oracle_env_CLDBAT21c.sh">>${PARFILE_LOC}/imp_cntrl_script.sh

echo "#loging into cloud db to create datapump directory">>${PARFILE_LOC}/imp_cntrl_script.sh
echo "sqlplus CLOUDDB_TEMP/Guitar0679@localhost:1521/cloudat21c<<EOF">>${PARFILE_LOC}/imp_cntrl_script.sh
echo "create or replace directory DATA_EXPORT_IMPORT as '${BK_LOC}';">>${PARFILE_LOC}/imp_cntrl_script.sh
echo "alter session set "_oracle_script"=true;">>${PARFILE_LOC}/imp_cntrl_script.sh
echo "CREATE USER STACK_APR24_${RUNNER} IDENTIFIED BY Guitar;">>${PARFILE_LOC}/imp_cntrl_script.sh
echo "GRANT CREATE SESSION TO STACK_APR24_${RUNNER};">>${PARFILE_LOC}/imp_cntrl_script.sh
echo "GRANT CREATE TABLE TO STACK_APR24_${RUNNER};">>${PARFILE_LOC}/imp_cntrl_script.sh
echo "GRANT CREATE SEQUENCE TO STACK_APR24_${RUNNER};">>${PARFILE_LOC}/imp_cntrl_script.sh
echo "EOF">>${PARFILE_LOC}/imp_cntrl_script.sh
#echo "# Create a backup destination directory">>${PARFILE_LOC}/imp_cntrl_script.sh
#echo "mkdir -p ${BK_LOC}">>${PARFILE_LOC}/imp_cntrl_script.sh
echo "# Run Import">>${PARFILE_LOC}/imp_cntrl_script.sh
echo "impdp parfile=impdp_${SCHEMA}_${RUNNER}.par">>${PARFILE_LOC}/imp_cntrl_script.sh


# Create a backup destination directory
ssh -p 2223 ${DST} "/home/Cloudserver/scripts/create_tosyn_dir.sh ${BASE_BACKUP_LOC} ${RUNNER}"

SOURCE1=${PARFILE_LOC}/impdp_${SCHEMA}_${RUNNER}.par
SOURCE2=${BASE_BACKUP_LOC}/${RUNNER}/expdp_${SCHEMA}.dmp
SOURCE3=${PARFILE_LOC}/imp_cntrl_script.sh


# scp files into cloudserver
echo "Copying the import parfile into destination cloud server ${DST}">>${LOG_LOCATION}/${LOG_FILE}
scp -rP 2223 ${SOURCE1} ${SOURCE2} ${SOURCE3} ${DST}:${BK_LOC}
echo "Hi, the code is used to copy parfile to my cloud server">>${LOG_LOCATION}/${LOG_FILE}

done<${PARFILE_LOC}/database_user.log

# Create a backup destination directory
#ssh -p 2223 ${DST} "/home/Cloudserver/scripts/create_tosyn_dir.sh ${BASE_BACKUP_LOC} ${RUNNER}"

	# scp files into cloudserver
	#echo "Copying the dumpfile into destination cloud server ${DST}"
	#scp -rP 2223 ${SOURCE1} ${DST}:${BK_LOC}
	#echo "Hi, the code is used to copy dmp file to my cloud server">>${LOG_LOCATION}/${LOG_FILE}

#	echo "Copying the import parfile into destination cloud server ${DST}">>${LOG_LOCATION}/${LOG_FILE}
#	scp -rP 2223 ${SOURCE1} ${SOURCE2} ${SOURCE3} ${DST}:${BK_LOC}
#	echo "Hi, the code is used to copy parfile to my cloud server">>${LOG_LOCATION}/${LOG_FILE}

	#echo "Copying the import control script into destination cloud server ${DST}">>${LOG_LOCATION}/${LOG_FILE}
	#scp -rP 2223 ${SOURCE3} ${DST}:${BK_LOC}
        #echo "Hi, the code is used to copy parfile to my cloud server">>${LOG_LOCATION}/${LOG_FILE}
	   
ssh -p 2223 ${DST} "/home/Cloudserver/scripts/create_tosyn_dir.sh ${BASE_BACKUP_LOC} ${RUNNER}"

	# run the script
	ssh -p 2223 ${DST} "${BK_LOC}/imp_cntrl_script.sh"



#BK_LOC=${BASE_BACKUP_LOC}/${RUNNER}

#sqlplus CLOUDDB_TEMP/Guitar0679 
#create or replace directory DATA_EXPORT_IMPORT as '${BASE_BACKUP_LOC}/${RUNNER}';

#exit

#impdp parfile=${BASE_BACKUP_LOC}/${RUNNER}/impdp_stack_apr22_${RUNNER}.par
	# Run configuration file:

}
<<comm
db_cloud_backup()
{
	# Creating logging location
	LOG_LOCATION=${BASE_BACKUP_LOC}/${RUNNER}/LOG/$TS
	mkdir -p ${LOG_LOCATION}
	echo "You selected the fourth option">>${LOG_LOCATION}/${LOG_FILE}
	echo "Welcome to database logical backup">>${LOG_LOCATION}/${LOG_FILE}
	echo "Starting Job ${TS}">>${LOG_LOCATION}/${LOG_FILE}
	echo "Logical Database backup into cloud database">>${LOG_LOCATION}/${LOG_FILE}
	echo "The arguments passed into this scripts are ${CONTROL_FLAG} ${DECISION} ${BASE_BACKUP_LOC} ${RUNNER} ${database} ${LOG_FILE}">>${LOG_LOCATION}/${LOG_FILE}
	echo "The first command line argument is,Control flag: $1">>${LOG_LOCATION}/${LOG_FILE}
	echo "The second command line argument is,Decision: $2">>${LOG_LOCATION}/${LOG_FILE}
	echo "The third command line argument is,Base backup location: $3">>${LOG_LOCATION}/${LOG_FILE}
	echo "The fourth command line argument is,Runner: $4">>${LOG_LOCATION}/${LOG_FILE}
	echo "The fifth command line argument is,database name: $5">>${LOG_LOCATION}/${LOG_FILE}
	echo "The sixth command line argument is,log file: $6">>${LOG_LOCATION}/${LOG_FILE}
	echo "we have $# command line arguments for this conditional check">>${LOG_LOCATION}/${LOG_FILE}
	BK_LOC=${BASE_BACKUP_LOC}/${RUNNER}/$TS
PARFILE_LOC="/home/localhost/scripts/practicedir_tosyn_aprill24"
	counter=1
	# listing database to ensure it is running  in our local machine
	echo "listing database to ensure it is running  in our local machine">>${LOG_LOCATION}/${LOG_FILE}
	if ( ps -ef | grep pmon | grep ${database} )>>${LOG_LOCATION}/${LOG_FILE}
	then
	        echo "Statement succeeded, database is running">>${LOG_LOCATION}/${LOG_FILE}
	else
	        echo "Statements failed">>${LOG_LOCATION}/${LOG_FILE}
	        exit
	fi
	# to set oracle parmeters correctly in their desgnated path
	echo "setting oracle database paths currently">>${LOG_LOCATION}/${LOG_FILE}

	. ${PARFILE_LOC}/oracle_env_DBAT21C.sh

	sqlplus -s mydb_temp/guitar<<EOF
	select * from global_name;
	SELECT sum(bytes)/1024/1024 AS "Size in MB" FROM dba_data_files;
	show user;
	create or replace directory DATA_EXPORT_IMPORT as '${BK_LOC}';
	select directory_name, directory_path from dba_directories where directory_name='DATA_EXPORT_IMPORT';
EOF
	
	#creating the backup directory
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

	# Writting into a new parfile
	echo "userid='/ as sysdba'"> /home/localhost/scripts/impdp_stack_apr22_${RUNNER}.par
	echo "schemas=STACK_APR22_TEST2">> /home/localhost/scripts/impdp_stack_apr22_${RUNNER}.par
	echo "REMAP_SCHEMA=STACK_APR22_TEST2:STACK_APR22_${RUNNER}">>/home/localhost/scripts/impdp_stack_apr22_${RUNNER}
	echo "dumpfile=expdp_STACK_APR22_TEST2_${RUNNER}_${TS}.dmp">> /home/localhost/scripts/impdp_stack_apr22_${RUNNER}.par
	echo "logfile=remap_schema_${RUNNER}.log">> /home/localhost/scripts/impdp_stack_apr22_${RUNNER}.par
	echo "directory=DATA_EXPORT_IMPORT">> /home/localhost/scripts/impdp_stack_apr22_${RUNNER}.par
	echo "table_exists_action=replace">> /home/localhost/scripts/impdp_stack_apr22_${RUNNER}.par
	
	#invoking the import
	impdp parfile=/home/localhost/scripts/impdp_stack_apr22_${RUNNER}.par

}
comm


# Main Body

TS=`date +"%d%m%y%H%M%S"`
CONTROL_FLAG=$1
DECISION=$2
SCRIPTS="/home/Cloudserver/scripts"

if [[ ${CONTROL_FLAG} == "scheduled" ]]
then
	DECISION=$2
	SOURCE=$3
	BASE_BACKUP_LOC=$4
	RUNNER=$5
	BK_TYPE=$6
	DST=$7
	LOG_FILE=$8
	
	if [[ ${DECISION} == 1 ]]
	then
		CONTROL_FLAG=$1
		DECISION=$2
		SOURCE=$3
		BASE_BACKUP_LOC=$4
		RUNNER=$5
		BK_TYPE=$6
		database=$7
		LOG_FILE=$8
		if (( $# != 7 ))
		then 
			echo "We have $# command line arguments">>${LOG_LOCATION}/${LOG_FILE}
			echo "FAILED!!!
			USAGE:To run this script,you need these command line arguments:
			CONTROL_FLAG: which is used to select either scheduled or non scheduled,declared as Cl arg1
			DECISION: which is used to choose the desired function you want to call,declared as Cl arg2
			BACKUP SOURCE: which is the file that should be backed up,declared as CL arg3
			BACKUP DESTINATION: path which is the location the source file will be copied to declared as Cl arg4
			RUNNER: which is the name in whose the backup should be referenced declared as CL arg5
			BACKUP TYPE: seperating files from directory declared as CL arg6
			LOG FILE:Which is the name of the log file that contains all the logged doucments, declared as CL arg7
			example: ./(scripts) CL arg1 CL arg2 CL arg3 CL arg4 CL arg5 CL arg6 CL arg7">>${LOG_LOCATION}/${LOG_FILE}
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
		LOG_FILE=$7
		if (( $# != 7 ))
		then 
			echo echo "We have $# command line arguments">>${LOG_LOCATION}/${LOG_FILE}
			echo "FAILED!!!
			USAGE:To run this script,you need these command line arguments:
			CONTROL_FLAG: which is used to select either scheduled or non scheduled,declared as Cl arg1
			DECISION: which is used to choose the desired function you want to call,declared as Cl arg2
			BACKUP SOURCE: which is the file that should be backed up,declared as CL arg3
			BACKUP DESTINATION: path which is the location the source file will be copied to declared as Cl arg4
			RUNNER: which is the name in whose the backup should be referenced declared as CL arg5
			BACKUP TYPE: seperating files from directory declared as CL arg6
			LOG FILE:Which is the name of the log file that contains all the logged doucments, declared as CL arg7
			example: ./(scripts) CL arg1 CL arg2 CL arg3 CL arg4 CL arg5 CL arg6 CL arg7">>${LOG_LOCATION}/${LOG_FILE}
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
		LOG_FILE=$8
		if (( $# != 8 ))
		then
			echo echo "We have $# command line arguments">>${LOG_LOCATION}/${LOG_FILE}
			echo "FAILED!!!
			USAGE:To run this script,you need these command line arguments:
			CONTROL_FLAG: which is used to select either scheduled or non scheduled,declared as Cl arg1
			DECISION: which is used to choose the desired function you want to call,declared as Cl arg2
			BACKUP SOURCE: which is the file that should be backed up,declared as CL arg3
			BACKUP DESTINATION: path which is the location the source file will be copied to declared as Cl arg4
			RUNNER: which is the name in whose the backup should be referenced declared as CL arg5
			BACKUP TYPE: seperating files from directory declared as CL arg6
			DST: Which is the name of the server we want to server declared as CL arg7
			LOG FILE:Which is the name of the log file that contains all the logged doucments, declared as CL arg7
			example: ./(scripts) CL arg1 CL arg2 CL arg3 CL arg4 CL arg5 CL arg6 CL arg7">>${LOG_LOCATION}/${LOG_FILE}
			exit
		fi	
	fi

	if [[ ${DECISION} == 4 ]]
	then
		CONTROL_FLAG=$1
		DECISION=$2
		BASE_BACKUP_LOC=$3
		RUNNER=$4
		database=$5
		LOG_FILE=$6
		#SOURCE1=$7
		#SOURCE2=$8
		#SOURCE3=$9
		DST=$7
		if (( $# != 7 ))
		then
			echo echo "We have $# command line arguments"
			echo "FAILED!!!
			USAGE:To run this script,you need these command line arguments:
			CONTROL_FLAG: which is used to select either scheduled or non scheduled,declared as Cl arg1
			DECISION: which is used to choose the desired function you want to call,declared as Cl arg2
			BACKUP DESTINATION: path which is the location the source file will be copied to declared as Cl arg3
			RUNNER: which is the name in whose the backup should be referenced declared as CL arg4
			Database: Which is the name of the database name declared as CL arg5
			LOG FILE:Which is the name of the log file that contains all the logged doucments, declared as CL arg6
			example: ./(scripts) CL arg1 CL arg2 CL arg3 CL arg4 CL arg5 CL arg6 CL arg7"
			exit
		fi
	fi
elif [[ ${CONTROL_FLAG} == nonscheduled ]]
then
	echo "Creating loggibg location"
	echo "welcome onboard!! we'll like to run an interview session with you"
	read -p "What do you want to do?
	Enter 1 for file or directroy backup
	Enter 2 for file or directory delete
	Enter 3 for SCP into cloud server to create directory
	Enter 4 for database logical backup
	entry: " DECISION
	if [[ ${DECISION} == 1 ]]
	then
		echo "Creating loggibg location"
		echo "welcome to file, directory backup function"
		read -p "Enter source file or directory:" SOURCE
		read -p "Enter Base Backup location:" BASE_BACKUP_LOC
		read -p "Enter the runner directory:" RUNNER
		read -p "Enter backup type file or directory:" BK_TYPE
		read -p "Enter LOG FILE:" LOG_FILE
		control=`echo ${DECISION}`
	fi
	if [[ ${DECISION} == 2 ]]
	then
		echo "welcome to file, directory delete function"
		read -p "Enter source file or directory: " SOURCE
		read -p "Enter Base Backup location: " BASE_BACKUP_LOC
		read -p "Enter the runner directory: " RUNNER
		read -p "Enter backup type file or directory: " BK_TYPE
		read -p "Enter LOG FILE:" LOG_FILE
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
		read -p "Enter LOG FILE:" LOG_FILE
		control=`echo ${DECISION}`
	fi
	if [[ ${DECISION} == 4 ]]
	then
		echo "welcome to file, logical backup function"
		read -p "Enter Base Backup location: " BASE_BACKUP_LOC
		read -p "Enter the runner directory: " RUNNER
		read -p "Enter name of database: " database
		read -p "Enter LOG FILE:" LOG_FILE
		control=`echo ${DECISION}`
	fi
fi

case "${DECISION}" in
	1) echo "You selected the first option"
	   #Calling file or directory backup function
	   f_d_backup ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE} ${LOG_FILE}	
    	   ;;
        2) echo "You selected the second option"
           #Calling file or directory delete function
	   f_d_delete ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE} ${LOG_FILE}
	   ;;
        3) echo "You selected the third option"
           #Calling scp function
           scp_f_d ${CONTROL_FLAG} ${DECISION} ${SOURCE} ${BASE_BACKUP_LOC} ${RUNNER} ${BK_TYPE} ${DST} ${LOG_FILE}
 	   ;;
	4) echo "You selected the fourth option"
	   #calling database logical backup
	   db_logical_backup ${CONTROL_FLAG} ${DECISION} ${BASE_BACKUP_LOC} ${RUNNER} ${database} ${LOG_FILE} ${DST}
	   ;;
        *) echo "invalid option"
	   ;;
esac

# end of scripts
TS=`date +"%d%m%y%H%M%S"`
echo "Ending the backup job at $TS">>${LOG_LOCATION}/${LOG_FILE}
