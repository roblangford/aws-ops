# AWS EBS Volumes detached from Instances

A Classic Operations error, even when running Infrastructure as Code, is leaving unattached EBS Volumes in a AWS Account after a restore or other activities. This script will scan for EBS Volumes that are no longer attached to EC2 Instances. If these are found the script will capture the Tags and details from CloudTrail, these will be emailed to a contact with periodic reminders.

## EBS Lambda Python script

Boto3 has EBS however its used for managing snapshots and backup activities. EC2 Client has an option to capture Volumes.

