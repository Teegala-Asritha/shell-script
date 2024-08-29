#!/bin/bash

LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="/var/log/myapp/archive"
DAYS_TO_KEEP=30
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Create archive directory if it doesn't exist
mkdir -p $ARCHIVE_DIR

# Rotate and compress logs
find $LOG_DIR -type f -name "*.log" -mtime +$DAYS_TO_KEEP -exec gzip {} \;
find $LOG_DIR -type f -name "*.log.gz" -exec mv {} $ARCHIVE_DIR \;

# Delete old archives
find $ARCHIVE_DIR -type f -name "*.log.gz" -mtime +$DAYS_TO_KEEP -exec rm {} \;

echo "Log rotation and archiving completed."



#Explanation:

#Purpose: This script handles the rotation and archiving of logs, ensuring that logs older than a specified number of days are compressed and moved to an archive directory, and that old archives are deleted after a certain period.
#Key Steps:
#Create Archive Directory: Ensures the archive directory exists.
#Rotate Logs: Compresses log files older than the specified number of days.
#Move Logs: Moves the compressed log files to the archive directory.
#Clean Up Old Archives: Deletes archives older than the specified retention period.