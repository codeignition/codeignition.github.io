---
layout: post
title: "Case Study: Grasshopper"
description: "How we helped a growing virtual telephony start-up customize & automate their infrastructure"
tags: ['aws','heroku','disaster recovery','automation','freeswitch','telephony','voip','grasshopper','case study','infrastructure','high availability', 'continuous delivery']
author: sanat
---
{% include JB/setup %}
**Introduction**

<a href="http://uk.grasshopper.com/" target="_blank">Grasshopper</a> is a virtual telephony company that enables businesses to build a virtual office that connects callers to employees. Since starting out, Grasshopper's goal has been to create a smart, affordable & customizable virtual phone system that helps entrepreneurs streamline business communications. 
Grasshopper's biggest USP's are:

* Being entirely virtual there are no cumbersome hardware costs or processes
* Customization & simplicity making it very user friendly

**Initial Challenges**

Grasshopper's application suite was developed in-house and hosted on Heroku. Whilst this setup offered convenience of interface, customization & analytics, it came with some limitations: 

* Automation options were restricted, which increased both risks & costs 
* Centralized monitoring was not available
* Granular access was also lacking
* Couldn't accommodate FreeSWITCH

**Solution**

Having recognized the above challenges and with automation & high availability as core business goals, Grasshopper reached out to us in August of 2013. Our first order of business was devising a migration strategy from Heroku to AWS, and implementing the following customized solutions:

* Setup separate production & staging environments 
* Setup centralized logs with granular access & visualization of information
* Customized central & always-on monitoring of all processes
* Implemented Continuous Delivery pipeline with single-click implementation
* Installed FreeSWITCH 
* High availability for maximum components (including VPN, FreeSWITCH, web apps & databases)

**Results**

* We migrated the entire setup to AWS & delivered essential customizations in 10 weeks
* Round the clock monitoring & support means Grasshopper now enjoys much higher uptime
* Access to complex information with customized analytics & dashboards means decision making and business processes run more effectively
* Reduced deployment time by automating deployment across services
* We created an immutable infrastructure, where instead of changing part of the system, it is replaced altogether on a new instance with automated deployment at every step
