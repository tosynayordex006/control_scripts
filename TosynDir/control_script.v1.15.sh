#!/bin/bash
BASE_BACKUP_LOC=$1
RUNNER=$2
database=$3

TS=`date +"%d%m%y%H%M%S"`
BK_LOC=${BASE_BACKUP_LOC}/${RUNNER}/$TS
PACTICEDIR="/home/localhost/scripts/practicedir_tosyn_aprill24"


# listing database to ensure it is running  in our local machine

if ( ps -ef | grep pmon | grep ${database} )
then
   	echo "Statement succeeded"
else
        echo "Statements failed"
	exit
fi

# to set oracle parmeters correctly in their desgnated path
echo "setting oracle database paths currently"
. ${PACTICEDIR}/oracle_env_DBAT21C.sh

sqlplus stack_aprill24_tos/guitar<<EOF
select * from global_name;
SELECT sum(bytes)/1024/1024 AS "Size in MB" FROM dba_data_files;
show user;
create or replace directory DATA_EXPORT_IMPORT as '${BK_LOC}';
select directory_name, directory_path from dba_directories where directory_name='DATA_EXPORT_IMPORT';
EOF

#creating the backup directory
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

# Run configuration file:
echo "Runing configuration file...."
expdp parfile=${PACTICEDIR}/expdp_iyanu.par

#Check logfile for success message
echo "Checking logfile for success message"
grep "successfully" ${BK_LOC}/expdp_iyanu_MYDB_TEMP.log
grep "ORA-" ${BK_LOC}/expdp_iyanu_MYDB_TEMP.log


