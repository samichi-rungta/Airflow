#fetching credentials from another file
source /Users/samichirungta/airflow/scripts/credentials.sh

#fetching the size of the database
DB_SIZE=$(mysql -u $DB_USER -p$DB_PASS -e "SELECT ROUND(SUM(data_length + index_length) / 1024 / 1024 / 1024, 8) FROM information_schema.tables WHERE table_schema = '$DB_NAME';" -s -N)

#df doesn't directly give size but it provides block numbers that are free. each block is of 512 byte
available_blocks=$(df | awk '$NF=="/System/Volumes/Data" {print $4}')

available_bytes=$((available_blocks * 512))

#size of the free space in disk
FREE_SPACE=$(echo "scale=2; $available_bytes / (1024^3)" | bc)

echo "Helllo from free space check"
echo "Dump file size is $DB_SIZE GB"
echo "Available space: $FREE_SPACE GB"

if (( $(echo "$FREE_SPACE > $DB_SIZE" | bc -l) )); then
    isEnoughSpace=true
    checkSpaceMsg="Enough Space available. You are good to go. Required: ${DB_SIZE}GB, Available: ${FREE_SPACE}GB"
else
    isEnoughSpace=false
    checkSpaceMsg="Not enough free disk space. Required: ${DB_SIZE}GB, Available: ${FREE_SPACE}GB"
fi
  
echo "checkSpaceMsg=$checkSpaceMsg"
echo "isEnoughSpace=$isEnoughSpace,checkSpaceMsg=$checkSpaceMsg"
