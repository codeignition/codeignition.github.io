---
layout: post
title: "Monitor the Business, not just the Infrastructure"
description: "Why setting up monitoring for business before infrastructure makes better DevOps sense"
tags: []
tags: [monitoring,business metrics,devops best practices,infrastructure,dashboards,computing resources,trend analysis,proactive devops]
author: sumit
---

{% include JB/setup %}

Infrastructure monitoring is an important aspect of DevOps culture. Whether it's a simple check & email alert, or an elaborate network of tools that automatically monitor, analyze, visualize & send alerts across platforms; infrastructure monitoring helps DevOps teams identify resource contentions, critical service failures and generally gain insights that help the DevOps workflows.

As compelling as infrastructure monitoring is, it can be insufficient in telling the whole story of the business. And if the role of DevOps is to enable, drive and grow the business, then it's imperative to set up business monitoring first. It's not just better for business, it's also better for DevOps. Here's why.

**Avoid Ad Hoc Post-mortem**

Imagine there's an infrastructure you manage which is running smoothly. There are no memory or disc alerts, no latency issues, nothing that alerts you about anything amiss. Then you hear from the business team that daily order or revenue numbers have been dropping, and now you have an investigation on your hands. 

Is it a deployment issue? Third-party services latency? Or is it simply user behavior? Recently on a project the client shared an observation that on one day of the week around the same time they always reported drops in revenue. What followed was a root cause analysis of everything, till we discovered that a lot of the service providers (it's a business that connects them with customers) would be unavailable at that time due to Friday prayers. 

Having a business monitoring setup would help identify trends, correlations and causes like these a lot sooner and save time & effort expended by business & DevOps teams alike.

**Manage Growth Better**

As a business grows, so does its engineering. More traffic, more users, more end-points means building more subsystems to cater to product & service needs and to satisfy scalability requirements. More subsystems mean more moving parts and integration points, and more scope for impedance mismatches or failure points within the system.

As with all polyglot trends, these subsystems are built with different tech stacks and come with different databases or messaging components. This means multiple different data points need to be collected and monitored in some way or the other for the business to run and scale smoothly. 

Here business monitoring helps in identification of not only the key metrics, but in their impact on services as well. In another recent example, we optimized a service for scale but it became too fast for the peer component to keep pace with it. The result was bottlenecks in other services and general slowdown.

<div class="row"><div class='col-md-8 col-md-offset-2'> <img class="img-responsive" src="/assets/blogs/business_monitoring.jpg"> </div></div>

**Proactive Assessment & Resolution** 

A typical escalation scenario goes like this: some user (internal or external) encounters a tardy or even downright slow service, rings up the call centre or support team, who then bring that to the engineering team to find the root cause and resolve the issue. The engineering team digs through logs and places some form of monitoring or the other just in case this issue happens again. 

While this isn't a no-no approach, the business impact resulting from any service downtime and poor customer experiences can be easily avoided by proactively monitoring the more high level metrics which reflect the problems in early stages. Infrastructure monitoring is still required for fixing issues from an engineering standpoint, but business monitoring helps in decreasing the feedback time and uncovering the services issue early on.

**Sharper Alerts**

Infrastructure monitoring for growing or big systems also suffers from a higher noise ratio, because of repeating alerts resulting from false alarms or non-urgent issues like CPU spikes in one of many nodes. Most of these are transient in nature which disappear fast, but the sheer frequency of these alerts and their amplification in different forms can lead to desensitization and ignorance, which can spell trouble.

Business monitoring helps identify & prioritize critical events, paving the way for DevOps to define alerts better and stay sharp.  

**Better Business, Better DevOps**

A typical business metrics dashboard can be counters for DAU, MAU and time series or moving averages for concurrent orders or active users. Supplementing business metrics with key DevOps events like customer escalations or deployment events further helps in identifying & correlating trends and pin points issues proactively and early on.

In summary, business monitoring helps:

1. Identify trends & issues early to avoid unnecessary post-mortems
2. Correlate infrastructure and business metrics for faster and smarter impact analyses
3. Business teams to actively monitor metrics to notify you for anomalies or potential technical issues
4. Help in moving from reactive to proactive DevOps
