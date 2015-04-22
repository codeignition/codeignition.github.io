---
layout: post
title: "How to Create a Low Cost, Self-Healing & Immutable Infrastructure using AWS EC2 Spot Instances [Part 1]"
description: "Reduce AWS bills significantly & automate maintenance using Auto-Scaling"
tags: ['aws','ec2','spot','infrastructure','cloud','devops']
author: vipul
---
{% include JB/setup %}
If you have ever used any cloud service, then chances are pretty good that it was AWS.
They lead the way with almost 1/3rd of the cloud infrastructure market ([source](http://www.cloudcomputing-news.net/news/2015/feb/03/aws-hits-five-year-high-cloud-infrastructure-market-share/)).
Worldwide more and more professionals are using AWS’s EC2 instances because they are dependable, flexible & easy to manage.

But all that comes at a cost, which companies realize soon enough. Because when you grow, your EC2 bill grows with you. I had already heard stories of large bills before experiencing this myself. And when it happened to me, it made me stop and ask some questions.

What are your options when the AWS EC2 bills start growing too much, too fast? Do you:

1.  Move to another cloud service?
2.  Move to DataCenters? 
3.  Raise the money to pay the bills anyway?

Or do you find a way that both saves money & makes managing it easy? By introducing Spot Instances into the mix and deploying Auto-Scaling, you can do just that.

**Spot Instances**

To the uninitiated, Spots Instances are the unused or dormant compute resources which AWS provides to bidders at much lower prices than normal instances. The spot instances work exactly like the normal ec2 instance while running. 
The only difference is

* **Pricing**

  On an average these prices can be 1/8th or 1/10th of normal instances, and the variation is totally dependent on market demand where AWS users place bids.
  It works like any other auction market, in that AWS sets a base price and users put forth bids at prices higher that the base price.
  The market value varies acording to supply and demand.

  When you submit a spot request for a spot instance, you specify the bid price which is the maximum price which you are willing to pay for this instance.
  Acording to AWS , the market price for any instance type is lowest bid price for which a spot instance was provided for any user.
  For eg if aws has 5 instance and 6 users have submitted bids

  User 1 - Rs 1  
  User 2 - Rs 2  
  User 3 - Rs 3  
  User 4 - Rs 4  
  User 5 - Rs 5  
  User 6 - Rs 6  

  Everyone will get a spot instance except user 1. The lowest bid price for which a spot instance was assigned was from User 2 and thus market price is Rs 2

* **Termination Policy**

  Unlike the normal ec2 instance which terminate when a user terminates them manually,spot instance can get terminated automatically and at any time.
  When the market price goes above the bid price which user specified in the spot request, the spot  instance will get terminated.

Market price is influenced by many factors.Lets discuss a few of them

1. The bid price submitted by other aws users

    Suppose in the above Example there is User 7 who bids Rs 7 for the same instance.
    Now the all users except User 1 and User 2 will get a spot instance. Because User 3 has the lowest bid from which the spot instance was assigned the market price of the instance type will be Rs 3.

1. Aws has provided the aws spot instance from spot pool of instance which are not used in normal scheme of things.When the demand for normal ec2 instance increases, the spot pool decreases and then instance are terminated.

    Now in the example above  if the spot pool decrease and we are left with 3 instance.
    The spot instance for User 2 and 3 will get terminated as they have lower bids and market price will be Rs 4.

So these are the termination policies exercised by AWS, and they are the reason why a lot of people don’t opt for Spot Instances in their mix.

*Continued in part 2*
