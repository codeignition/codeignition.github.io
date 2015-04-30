---
layout: post
title: "Case Study: Blueshift Labs"
description: "How we empowered a big data powered start-up using Hadoop, AWS, Chef & Automation"
tags: ['hadoop’,’aws’,’chef’,’big data’,’automation’,’auto-scaling’,’spot instances’,’blueshift’,’case study’,’infrastructure’]
author: sanat
---
{% include JB/setup %}
**Introduction**

Blueshift Labs is a big data powered marketing SaaS start-up that helps marketers analyze, predict and communicate better. Blueshift’s mission is to enable marketers to build more meaningful relationships with customers using relevant & timely messages. 
Blueshift started out with two very ambitious goals:

* Create an infrastructure that can support big data requirements of today & scale comfortably 
* Have this infrastructure be cost effective

Meeting these goals, and making their mission into a reality however, posed some challenges. Whilst Blueshift had a clear vision & recognized the direction they wanted to go in, early operations & results brought up markers for change.

**Initial Problems**

* Developers managing DevOps meant limited expertise & imbalance in prioritization
* Dedicated AWS instances were managed using OpsWorks, which meant no custom deployment solutions
* Dedicated instances also meant Higher Costs since big data requirements were increasing rapidly

**Solution**

Blueshift approached us at CodeIgnition 8 months ago with these challenges. Having clarity of the product requirements & roadmap meant we could figure out exactly what was needed & what had to be done to achieve that. Here’s a list of what we devised & executed for Blueshift:

* Setup Hadoop cluster & test environments
* Migrated instances & databases from OpsWorks to Chef to improve deployment & performance
* Implemented auto-scaling & continuous integration processes
* Setup database failover operations & improved security measures to cut downtime to near naught 
* Introduced mix of EC2 & Spot instances with auto-scaling groups to reduce both costs & dependencies

**Results**

* Improved load handling. Blueshift is now accustomed & equipped to handle all manners of growth & spikes. With increasing demand for their product from major big data customers such as Indian e-commerce giant Snapdeal, Blueshift is now able to serve over 10,000 requests per second.
* Reduced deployment time. When accommodating request spikes in the past, it used to take anywhere between 30 to 40 minutes to setup a new instance. We have now reduced that time to less than 5 minutes using automation & auto-scaling.
* Cost effective growth. By introducing Spot instances into the mix, we were able to reduce monthly AWS bills to a tenth of original costs. Growing big data requirements has meant increase in capacity and usage, but the cost increase has been contained within budgets.

Related Post: <a href="http://codeignition.co/blog/2015/04/16/aws-spot-part1/" target="_blank">How to Create a Low Cost, Self-Healing & Immutable Infrastructure using AWS EC2 Spot Instances</a>
