# Maintain AWS Tagging

One of the difficulties in AWS is ensuring that you keep track of your Infrastructure. Lets say you restore EBS volumes from snapshot to roll back an instance after a failure, you may forget to update the tags on the Volume to ensure AWS Backups continue, or you may forget to delete the detached volume.

