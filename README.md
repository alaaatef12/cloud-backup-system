cat <<EOF > README.md
# 🌩️ Cloud Backup System

This project automates file backups to **AWS S3** using **Bash**, **AWS CLI**, and **Python (for AWS Lambda support).**

## 📌 Features
- 🗄️ **Automated backups** to AWS S3
- 🔄 **Versioning support** to keep multiple copies
- ⏲️ **Scheduled execution** using cron or AWS Lambda
- 🔄 **Backup recovery** by downloading files from S3

## 🚀 Getting Started

### 1️⃣ Prerequisites
- AWS account with an S3 bucket
- AWS CLI installed and configured
- Git installed

### 2️⃣ Setup
Clone the repository:
\`\`\`bash
git clone https://github.com/alaaatef12/cloud-backup-system.git
cd cloud-backup-system
\`\`\`

### 3️⃣ Backup Script (Bash)
This script compresses your files and uploads them to AWS S3.

```bash
#!/bin/bash

# Variables
S3_BUCKET="your-bucket-name"
BACKUP_SOURCE="\$HOME"
TIMESTAMP=\$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_\$TIMESTAMP.tar.gz"
LOCAL_BACKUP="/tmp/\$BACKUP_NAME"

# Create a compressed archive
tar -czf \$LOCAL_BACKUP -C \$BACKUP_SOURCE .

# Upload to S3
aws s3 cp \$LOCAL_BACKUP s3://\$S3_BUCKET/

# Confirm upload
if [ \$? -eq 0 ]; then
    echo "Backup uploaded successfully: \$BACKUP_NAME"
else
    echo "Backup failed!"
fi

# Cleanup local backup file
rm \$LOCAL_BACKUP
```

### 4️⃣ AWS Lambda Backup Script (Python)
This script can be scheduled using AWS Lambda and EventBridge.

```python
import boto3
import datetime

# AWS S3 Client
s3 = boto3.client('s3')

# Set S3 bucket and file details
S3_BUCKET = "your-bucket-name"
BACKUP_FILE_NAME = f"backup_{datetime.datetime.now().strftime('%Y-%m-%d_%H-%M-%S')}.txt"

def lambda_handler(event, context):
    # Sample data (replace with actual file read logic)
    backup_data = "This is a test backup."

    # Upload the file to S3
    s3.put_object(Bucket=S3_BUCKET, Key=BACKUP_FILE_NAME, Body=backup_data)

    return {
        "statusCode": 200,
        "body": f"Backup {BACKUP_FILE_NAME} uploaded successfully!"
    }
```

### 5️⃣ Automate with AWS Lambda & EventBridge
- Deploy the \`lambda_backup.py\` script in AWS Lambda
- Schedule it using Amazon EventBridge 


## 📜 License
MIT License – Free to use and modify.

EOF

git add README.md
git commit -m "Add README.md with project details and code"
git push origin main
