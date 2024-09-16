#!/bin/bash

BASE_BACKUP_LOC=$1
RUNNER=$2
database=$3
PRACTICEDIR="/home/Cloudserver/scripts/practicedir_ayodele_aprill24"
TS=`date +"%d%m%y%H%M%S"`
BK_LOC=${BASE_BACKUP_LOC}/$TS/${RUNNER}


#Listing the database 

if ( ps -ef | grep pmon | grep ${database} )
then	
	echo "Database exist, hence statement succeeded!!"
else
	echo "Database does not exist, hence statement failed!!"
fi

# To set oracle parameters
echo "setting oracle path correctly"
. ${PRACTICEDIR}/oracle_env_Cloudat21c.sh

# Running a bunch commands in file through sqlplus
sqlplus CLOUDDB_TEMP/Guitar0679 <<EOF
select * from global_name;
SELECT sum(bytes)/1024/1024 AS "Size in MB" FROM dba_data_files;
show user;
create or replace directory DATA_EXPORT_IMPORT as '${BK_LOC}';
select directory_name, directory_path from dba_directories where directory_name='DATA_EXPORT_IMPORT';
EOF

# checking if direcory exist

if [[ -d ${BK_LOC} ]]
then
	echo "directory already exist, sleeping for 10 seconds"
	sleep 10
else
	echo "Directory does not exist, creating a new directory"
	mkdir -p ${BK_LOC}
	# Check for exit mission critical command Mkdir
	if (( $? == 0 ))
	then
		echo "Mkdir command ran successfully"
	else
        	echo "Mkdir command failed"
		exit
	fi
fi

# Run configuration file:
echo "Runing configuration file...."
expdp parfile=${PRACTICEDIR}/expdp_ayodele.par

#Check logfile for success message
echo "Checking logfile for success message"
grep "successfully" ${BK_LOC}/expdp_CLOUDDB_TEMP.log
grep "ORA-" ${BK_LOC}/expdp_CLOUDDB_TEMP.log
