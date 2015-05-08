---
layout: post
title: "How to Create a Low Cost, Self-Healing & Immutable Infrastructure using AWS EC2 Spot Instances [Part 2]"
description: "Reduce AWS bills significantly & automate maintenance using Auto-Scaling"
tags: ['aws','ec2','spot','infrastructure','cloud','devops']
author: vipul
---
{% include JB/setup %}

* **Autoscaling groups**
* **Autoscaling launch configuration**

with spot instances to effectivelty use the spot instances to create low cost self healing infrastructure.

*Continued in part 2*

* **Autoscaling Launch Configuration**

Autoscaling launch config are essentials scripts to create an ec2 instance with fixed set of attributes and properties.
Acording to AWS "A launch configuration is a template that an Auto Scaling group uses to launch EC2 instances. 
When you create a launch configuration, you specify information for the instances such as the ID of the Amazon Machine Image (AMI), the instance type, a key pair,
one or more security groups, and a block device mapping, Bid price if it is a spot instance."
One important part in Autoscaling launch configuration is User data.
It can be  shell script or cloud-init scripts which will used to configure the instance when it boots for the first time. For eg in our case
we will

1. Install nginx
2. Start nginx
So every time an instance is created from this launch configuration, it should have nginx installed and running.

* **Autoscaling Groups**

An autoscaling group uses launch configuration and aws availability zones to create and maintian a specific number of ec2 instances.There are 3 keys variables
1. Maximum Capacity :- As name suggests it is the maximum number of ec2 instances in an Autoscaling Groups
2. Minimum Capacity :- As name suggests it is the minimum number of ec2 instances in an Autoscaling Groups
3. Desired Capacity :- This the number of ec2 instance which the autoscaling group will try to achieve. Think of it as equilibrium point.
If one of instance in Autoscaling Group is killed , The group will launch an ec2 instance using launch configuration automatically to keep number of server
at Desired Capacity and similarly terminate extra ec2 instance if total number of ec2 instance exceed Desired Capacity.

So we create a launch configuration which uses spot instance with instance related details and attributes as shown in the snapshot below.

We create an Autoscaling Group using the Launch configuration we created above with specifications as shown in the snapshot below.

* **Testing**

Now you can test our setup and check if it heals itself.
Here are the steps to test the setup

1. Launch an instance in the autoscaling group created above.
2. Check if the instance launched has nginx installed and running
3. Terminate this instance manually to simulate termination by AWS for spot instance
4. The autoscaling group should submit a Spot request automatically within a few min and you will get an new instance
5. Check if the instance launched has nginx installed and running

If yes , you have successfully created a low cost, self healing , immutable infrastrucuture using spot instance and autoscaling.



* **Use Cases**

We have successfully integrated AWS Spot instance in 
1) App servers
2) Worker processes using resque, sidekiq
3) Compute instance in hadoop cluster

Suggestions

1)As the AWS spot instance can get terminated at moment's notice, please refrain using them in local data specific usage services.
 Please dont use for database, app servers using local cache and any other app using local storage.
2)Plese keep a sizeable offset and use additional servers so that your services can handle to traffic if one or more Spot instance Fails.
3)Please research a lot on market pricing history in different zones,regions and instance types before choosing one for your application.
Normally zone c , zone e if present in a region are stable and offer low price for spot instances.







