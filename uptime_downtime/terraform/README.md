# AWS EC2 Uptime/Downtime scheduler

## Description: 
This is a simple uptime/downtime lambda script written in Python using Boto3 for AWS EC2 that I've developed. It's written to ensure that Non-Production systems/instances are not left running out side of business hours and weekends.
The application of this can be applied to ensure that systems are started in the morning and therefore available for developers. Or you can simply set up to turn off the systems at the end of the day.

## Table of Contents:
* [How this works](#how-this-works)
* [Components](#components)
    - [AWS EventBridge Rule](#aws-eventbridge-rule)
    - [AWS Lambda](#aws-lambda)
    - [AWS KMS](#aws-kms)
* [How to deploy](#how-to-deploy)
    - [Terraform](#terraform)
* [How to use](#how-to-use)
* [License](#license)
* [Badges](#badges)

### How this works:
An [AWS Lambda](https://aws.amazon.com/lambda/) will contain a simple Python script that uses [Boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html) to Stop and Start AWS EC2 Instances. This is controlled using an [AWS EventBridge Rule](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-rules.html) to schedule the events using a cron expression to trigger the AWS Lambda to run the Python script.

![Simple Schedule Diagram](../images/Schedule-Uptime_Downtime.drawio.png?raw-true)

#### Components: 
##### AWS EventBridge Rule: 
AWS EventBridge is a serverless event bus service that allows you simply connect applications and data. This was originally called CloudWatch Events, as this has continued to grow it has become its own Service. We will simply be using a Rule that is triggered on a Schedule. You can however setup an event trigger, for example a webhook to start a development environment from Slack or Microsoft Teams.

##### AWS Lambda:
AWS Lambda is a simple serverless service that allows developers to run code without having to worry about provisioning or managing Infrastructure or scaling. Compute costs are calculated based on the memory and per-millisecond execution of the code. Because the costs are based on how long the code takes to execute I haven't included any wait conditions or long process loops, for this process it is a waste of operational overhead to include these.

##### AWS KMS: 
AWS Key Mangement Service is only required if you have encrypted the EC2 Instance Volume. The AWS Lambda will need access to the key in order to decrypt the volume during startup.


### How to Deploy:
This project can be quickly deployed manually to ensure you have full understanding of this process, if you want to fully understand all of the components being used. If you are looking to deploy this at scale however I would recommend using the Infrastructure as Code options provided once you have reviewed the details of how it works.

#### Terraform:
 - Current work in progress

### How to Use: 

### License


### Badges: 
