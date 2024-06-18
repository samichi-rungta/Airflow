#!/bin/bash

# Define the backup directory directly in the script
directory="/Users/samichirungta/airflow/backups"

cd "$directory" || exit

# Sort files wrt time i.e., newest first
files=($(ls -p -t | grep -v /))

# Length of files
num_files=${#files[@]}

if [ "$num_files" -gt 2 ]; then
    for (( i=2; i<num_files; i++ )); do
        rm "${files[$i]}"
    done

    export deleteStatus=true
    export deleteMsg="Delete complete."
else
    export deleteStatus=false
    export deleteMsg="File length < 2. Nothing deleted."
fi

echo $deleteStatus
echo $deleteMsg
