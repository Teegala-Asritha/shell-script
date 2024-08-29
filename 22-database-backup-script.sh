#!/bin/bash

DB_USER="username"
DB_PASSWORD="password"
DB_NAME="mydatabase"
BACKUP_DIR="/backups/database"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
BACKUP_NAME="$DB_NAME-$TIMESTAMP.sql.gz"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup the database
mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME | gzip > $BACKUP_DIR/$BACKUP_NAME

# Delete old backups (older than 7 days)
find $BACKUP_DIR -type f -name "*.sql.gz" -mtime +7 -exec rm {} \;

echo "Database backup completed: $BACKUP_NAME"


#Explanation:

#Purpose: Automates the backup of a MySQL database, compresses the backup, and deletes old backups to free up space.
#Key Steps:
#Backup Database: Uses mysqldump to create a backup of the database, which is then compressed.
#Manage Backups: Deletes backups older than 7 days to prevent the backup directory from growing indefinitely.