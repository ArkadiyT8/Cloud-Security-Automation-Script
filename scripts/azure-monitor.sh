#!/bin/bash
# Yo, this script monitors Azure resources for unauthorized access

# Variables
LOG_FILE="../logs/security-logs.txt"
SUBSCRIPTION_ID="your-subscription-id"

# Check for unauthorized role assignments
echo "Yo, checking for unauthorized role assignments..." | tee -a $LOG_FILE
az role assignment list --subscription $SUBSCRIPTION_ID > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Error: Failed to fetch role assignments. Possible misconfiguration." | tee -a $LOG_FILE
  ./alert-system.sh "Azure Role Assignment Misconfiguration Detected"
fi

# Check for open storage accounts
echo "Checking for open storage accounts..." | tee -a $LOG_FILE
STORAGE_ACCOUNTS=$(az storage account list --query "[].name" --output tsv)
for ACCOUNT in $STORAGE_ACCOUNTS; do
  PUBLIC_ACCESS=$(az storage account show --name $ACCOUNT --query "allowBlobPublicAccess")
  if [ "$PUBLIC_ACCESS" == "true" ]; then
    echo "Warning: Storage account $ACCOUNT allows public access!" | tee -a $LOG_FILE
    ./alert-system.sh "Public Storage Account Detected: $ACCOUNT"
  fi
done

echo "Azure monitoring complete. Check logs for details." | tee -a $LOG_FILE