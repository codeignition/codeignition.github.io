---
layout: post
title: "How to Create a Low Cost, Self-Healing & Immutable Infrastructure using AWS EC2 Spot Instances [Part 2]"
description: "Reduce AWS bills significantly & automate maintenance using Auto-Scaling"
tags: ['aws','ec2','spot','infrastructure','cloud','devops']
author: vipul
---
{% include JB/setup %}

*<a href="http://codeignition.co/blog/2015/04/16/aws-spot-part1/" title="How to Create a Low Cost, Self-Healing & Immutable Infrastructure using AWS EC2 Spot Instances [Part 1]">
Continued from part 1</a>*

In our last blog we discussed about Pricing and Termination Policies of the AWS spot instances. We also discussed the factors affecting the pricing and the termination policies and how we can incorporate
AWS spot instances in our infrastructure. To create a self healing infrastructure and counter the unwanted infrastructure changes by terminations 
of AWS spot instances, we will now introduce another feature of AWS

**Autoscaling**

There are two components of Autoscaling

* **Autoscaling launch configuration**
* **Autoscaling groups**

**Autoscaling Launch Configuration**

Autoscaling launch config are essentials scripts to create an ec2 instance with fixed set of attributes and properties. Acording to AWS

> "A launch configuration is a template that an Auto Scaling group uses to launch EC2 instances.
> When you create a launch configuration, you specify information for the instances such as the ID of the Amazon Machine Image (AMI), the instance type, a key pair,
> one or more security groups, and a block device mapping, Bid price if it is a spot instance."

One important part in Autoscaling launch configuration is User data.
It can be shell script or cloud-init scripts which will used to configure the instance when it boots for the first time.

We have created a launch configuration which uses spot instance with instance related details and attributes as shown in the snapshot below.

<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="launch_config" src="/assets/blogs/launch_config.png" style="margin: 20px 2px"></div></div>

We will use the commands in User data section to configure the spot instance when it boots for the first time.
So every time an instance is created from this launch configuration, it should have nginx installed and running.

**Autoscaling Groups**

An autoscaling group uses launch configuration and aws availability zones to create and maintian a specific number of ec2 instances.There are 3 keys variables

* *Maximum Capacity* :- maximum number of ec2 instances in an Autoscaling Groups
* *Minimum Capacity* :- minimum number of ec2 instances in an Autoscaling Groups
* *Desired Capacity* :- number of ec2 instance which the autoscaling group will try to achieve. Think of it as equilibrium point.

If one of instance in Autoscaling Group is killed , The group will launch an ec2 instance using launch configuration automatically to keep number of server
at Desired Capacity and similarly terminate extra ec2 instance if total number of ec2 instance exceed Desired Capacity.

We create an Autoscaling Group using the Launch configuration we created above with specifications as shown in the snapshot below.

<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="autoscaling_group" src="/assets/blogs/autoscaling_group.png" style="margin: 20px 2px"></div></div>

**Testing**

Now you can test our setup and check if it heals itself. Here are the steps to test the setup

* Launch an instance in the autoscaling group created above.
* Check if the instance launched has nginx installed and running
* Terminate this instance manually to simulate termination by AWS for spot instance
* The autoscaling group should submit a Spot request automatically within a few min and you will get an new instance
* Check if the instance launched has nginx installed and running

Here is a snapshot of activity in autoscaling group where it submits a spot request automatically if the instance gets terminated.

<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="autoscaling_testing" src="/assets/blogs/autoscaling_testing.png" style="margin: 20px 2px"></div></div>

If yes, you have successfully created a low cost, self healing, immutable infrastrucuture using spot instance and autoscaling.

**Use Cases**

We have successfully integrated AWS Spot instance in

* App servers
* Worker processes using resque, sidekiq
* Compute instance in hadoop cluster

**Suggestions**

* As the AWS spot instance can get terminated at moment's notice, please refrain using them in local data specific usage services.
Please dont use for database, app servers using local cache and any other app using local storage.
* Keep a sizeable offset and use additional servers so that your services can handle to traffic if one or more Spot instance Fails.
* Research a lot on market pricing history in different zones,regions and instance types before choosing one for your application.
Normally zone c, zone e if present in a region are stable and offer low price for spot instances.
