# Cloud Security Automation Script

This project includes Bash scripts to monitor AWS and Azure cloud infrastructures for unauthorized access and misconfigurations. It also implements a logging and alert system to notify administrators of potential breaches.

## Features
- **AWS Monitoring**: Detects unauthorized IAM activity and open S3 buckets.
- **Azure Monitoring**: Detects unauthorized role assignments and open storage accounts.
- **Alert System**: Sends email notifications for security issues.
- **Logging**: Logs all security events for auditing.

## How to Run

1. Install dependencies:
   - AWS CLI: `sudo apt install awscli`
   - Azure CLI: `sudo apt install azure-cli`
2. Configure AWS and Azure credentials:
   - AWS: `aws configure`
   - Azure: `az login`
3. Run the scripts:
   - AWS: `bash scripts/aws-monitor.sh`
   - Azure: `bash scripts/azure-monitor.sh`

## Date Created
2023

## Made by
ArkadiyT

## License
MIT License
