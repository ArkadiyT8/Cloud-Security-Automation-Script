#!/bin/bash
# Yo, this script sends alerts for security issues

# Variables
ADMIN_EMAIL="admin@example.com"

# Send alert via email
echo "Yo, sending alert: $1" | tee -a ../logs/security-logs.txt
echo "$1" | mail -s "Security Alert" $ADMIN_EMAIL

# Log the alert
echo "$(date): $1" >> ../logs/security-logs.txt