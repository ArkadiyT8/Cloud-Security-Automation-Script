#!/bin/bash
# Yo, this script monitors AWS resources for unauthorized access

# Variables
LOG_FILE="../logs/security-logs.txt"
AWS_REGION="us-east-1"

# Check for unauthorized IAM activity
echo "Yo, checking for unauthorized IAM activity..." | tee -a $LOG_FILE
aws iam list-users --region $AWS_REGION > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Error: Failed to fetch IAM users. Possible misconfiguration." | tee -a $LOG_FILE
  ./alert-system.sh "AWS IAM Misconfiguration Detected"
fi

# Check for open S3 buckets
echo "Checking for open S3 buckets..." | tee -a $LOG_FILE
BUCKETS=$(aws s3api list-buckets --query "Buckets[].Name" --output text)
for BUCKET in $BUCKETS; do
  ACL=$(aws s3api get-bucket-acl --bucket $BUCKET --region $AWS_REGION)
  if echo "$ACL" | grep -q "AllUsers"; then
    echo "Warning: S3 bucket $BUCKET is publicly accessible!" | tee -a $LOG_FILE
    ./alert-system.sh "Public S3 Bucket Detected: $BUCKET"
  fi
done

echo "AWS monitoring complete. Check logs for details." | tee -a $LOG_FILE