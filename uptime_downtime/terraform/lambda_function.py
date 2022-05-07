#!/etc/bin python3
#------------------------------------------------
# Created by : Robert Langford - 
# Created Date : May 2022
# Version : 1.0
#------------------------------------------------
# Repo Link: https://github.com/roblangford/aws-ops/tree/main/uptime_downtime
#------------------------------------------------

import boto3

# EC2 instance lookup
def ec2_instance_lookup(ec2_client, environment_tag, instance_state):

    # Filter Instances to target 
    environment_filters = [{'Name':'tag:Environment','Values':[environment_tag]},{'Name' : 'instance-state-name','Values': [instance_state]}]
    filtered_instances = ec2_client.describe_instances(Filters=environment_filters).get("Reservations")

    # Create empty list
    instance_list=[]

    # Loop through Instances lists to capture InstanceId's
    for Instances in filtered_instances:
        for Instance in Instances["Instances"]:
            instance_list.append(Instance["InstanceId"])

    # Return list of InstanceIds
    return instance_list

def ec2_instance_stop(ec2_client, instances):
    # Stop instances
    ec2_client.stop_instances(InstanceIds=instances)

def ec2_instance_start(ec2_client, instances):
    # Start instances
    ec2_client.start_instances(InstanceIds=instances)


# Main code
def lambda_handler(event, context):
    # EventBridge Rule Constant
    # e.g. : {"Environment":"DEV","Action":"Stop","Region":"ap-southeast-2"}
    event_input_environment = event['Environment'] # Target a specific tagged environment
    event_input_action = (event['Action']).lower() # Action to take: Stop or Start
    event_input_region = (event['Region']).lower() # AWS Region to target
    instance_state = ''

    # Register resources in region
    ec2_client = boto3.client('ec2', region_name=event_input_region)
    
    # Set the instance state based on the event input action to assist filter
    if event_input_action == "stop":
        instance_state = "running"
    elif event_input_action == "start":
        instance_state = "stopped"
   
    # Lookup EC2 instances.
    instances = ec2_instance_lookup(ec2_client, event_input_environment, instance_state)
    
    # Check if the instances lookup check returns empty list
    if not instances:
        print(f'There are no instances found to stop')
        exit
    else:
        # Stop EC2 instances.
        if event_input_action == "stop":
            print(f'Stopping the EC2 instances: {instances}')
            ec2_instance_stop(ec2_client, instances)

        # Start EC2 instances.
        if event_input_action == "start":
            print(f'Starting the EC2 instances: {instances}')
            ec2_instance_start(ec2_client, instances)