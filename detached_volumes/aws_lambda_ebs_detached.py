#!/etc/bin python3
#------------------------------------------------
# Created by : Robert Langford - 
# Created Date : May 2022
# Version : 1.0
#------------------------------------------------
# Repo Link: https://github.com/roblangford/aws-ops/tree/main/detached_volumes/
#------------------------------------------------

import boto3

# EBS volume lookup
def detached_ebs_volume_lookup(ec2_client, environment_tag, volume_state):

    # Filter Instances to target 
    environment_filters = [{'Name':'tag:Environment','Values':[environment_tag]},{'Name' : 'status','Values': [volume_state]}]
    filtered_volumes = ec2_client.describe_volumes(Filters=environment_filters).get("Volumes")

    # Return list of InstanceIds
    return filtered_volumes

# Main code
def lambda_handler(event, context):
    # EventBridge Rule Constant
    # e.g. : {"Region":"ap-southeast-2", "State":"available"}
    event_input_region = (event['Region']).lower() # AWS Region to target
    volume_state = (event['State']).lower() # Volume state to use for filter - Options: 'State': 'creating'|'available'|'in-use'|'deleting'|'deleted'|'error'

    # Register resources in region
    ec2_client = boto3.client('ec2', region_name=event_input_region)

    # Describe Volumes: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2.html#EC2.Client.describe_volumes
    # Get all the volumes: ec2_client.describe_volumes().get('Volumes')

    # Describe Volume Statuses: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2.html#EC2.Client.describe_volume_status
    # Get volume Statuses: ec2_client.describe_volume_status().get('VolumeStatuses')

    # Lookup EC2 instances.
    detached_volumes = detached_ebs_volume_lookup(ec2_client, event_input_region, volume_state)
    

    # Check for Available disks (detached)
    if len(detached_volumes['Volumes']) != 0 :

        # Loop through Volume lists to capture Id's
        for Volume in detached_volumes['Volumes']:
            volume_id = Volume["VolumeId"]
            volume_tags = Volume["Tags"]

            volume_reports.append()
    else:
        print(f'There are detached volumes found')
        exit
