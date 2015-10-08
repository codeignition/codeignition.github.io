---
layout: post
title: "Resilience Testing [Part 1]"
description: "What is resilience testing and why do we need it"
tags: [’aws’,’disaster recovery’,’automation’, ’infrastructure’,’high availability’]
author: vipul
---
{% include JB/setup %}
**Introduction**

We are going to talk about resilience testing in this blog.

It will be divided into two parts

1. In the first part we will discuss why we should be doing **Resilience Testing** with a few real life examples.
2. In the second part we will discuss how we can go on about adding resilience testing to our **infrastructure**

Resilience of a system can be defined as its ability to continue functioning  even if some elements of the system do not survive.
All of us have done a few setups at some point of time in our infrastructure to make it more resilient to failure and bugs.
These are planned with respect to current environment mostly.But there are a lot of **External** as well as **Internal** changes happening on infrastructure level which affects the setup.

Resilience Testing is based on the principle that your infrastructure needs to be tested regularly to discover deficiences and bugs which may cause service outage.
I will share a few example with my personal experience where my setups failed to give expected performance due to unforeseen changes and which could have been easily avoided by regularly performing **Resilience Testing**. 

### External Environment Changes

Suppose you have an application which connects to a database.Now if the Database goes down your application will go down too. You dont want this to happens. So you a slave and setup automatic failover in case the master fails.

<div class="row"><div class='col-md-8 col-md-offset-2'> <img class="img-responsive" src="/assets/blogs/db.jpg"> </div></div>

`Are you sure this failover will kick in 6 months or a year later.`

We had setup Multi AZ postgresql in **AWS RDS**. Now **AWS** takes care of the failover and it saved our service from going down quite a few times.

One fine evening we started receiving connection timeout error from app to database. I logged in and found out db failover was taking place.After a few minutes again automatic failover happened.For the next 3 hours db failover happened every 20 minutes.

When we try to debug it we found out that db cpu was touching **100%** so **AWS** decided to failover to standy.Now after around 20 min standy cpu also touched **100%** so it did failover again.The problem was that our traffic had increased and we didnt upgrade the database acordingly.We could have avoided all the downtime if we had done load testing a week or two before.


### Internal Environment Changes

We had also done a setup for load balancer automatic failover.

If the master haproxy goes down, the slave haproxy will disassociate the Elastic Ip (public ip) from the master and associate it to iself automatically. To disassociate and reassociate the elastic ip , we had to give IAM access to haproxy instances.

<div class="row"><div class='col-md-8 col-md-offset-2'> <img class="img-responsive" src="/assets/blogs/haproxy.png"> </div></div>

This setup was working fine and as expected until one day our website went down.
I logged into AWS and checked that haproxy master was down and slave was **unable** to failover.When i checked haproxy slave logs , it was unable to failover because someone had removed the **IAM ACCESS** for the haproxy.

If we had been doing resilience testing every other week we would have found this bug and avoided a downtime on our website



### Lessons Learnt

1. No matter what you do;**bugs and failure** will always creep into your system both because of External and Internal Changes

2. Just because your infrastructure is working fine today doesnt means it will work as expected some time later also. You need to regularly test your infrastrucuture for bugs and failure so that you can proactively avoid disasters.


In the next part of the blog we will discuss what tools we can use to achieve to do resilience testing and also look at some major companies which actively do resilience testing.


