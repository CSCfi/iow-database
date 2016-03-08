#!/bin/bash

############################
# Configure before using!! #
# If string starts with    #
# ADD, change it (must!)   #
############################

HOST="ADD_IP_ADDRESS"
PORT="3030"
# Change this when new datasets are present
DATASETS=("concept" "core" "imports" "users")
# %u: preserve backups for a week, %d: preserve backups for a month
CURRENT=$(date +%u)

cd ADD_BACKUP_DIRECTORY

for i in "${DATASETS[@]}"
do
        if [ -f ${i}_${CURRENT}.trig ] ; then
                rm ${i}_${CURRENT}.trig
        fi
	# Check curl path before running this
        /usr/bin/curl --header 'Content-type: text/trig' http://$HOST:$PORT/$i >> ${i}_${CURRENT}.trig;
done
