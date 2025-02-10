#!/bin/bash

# Variables
S3_BUCKET="alaa2000"
BACKUP_SOURCE="$HOME"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
LOCAL_BACKUP="/tmp/$BACKUP_NAME"

# Create a compressed archive of the home directory
tar -czf $LOCAL_BACKUP -C $BACKUP_SOURCE .

# Upload to S3
aws s3 cp $LOCAL_BACKUP s3://$S3_BUCKET/

# Confirm upload
if [ $? -eq 0 ]; then
    echo "Backup uploaded successfully: $BACKUP_NAME"
else
    echo "Backup failed!"
fi

# Cleanup local backup file
rm $LOCAL_BACKUP

