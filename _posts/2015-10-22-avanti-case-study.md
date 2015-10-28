---
layout: post
title: "Project Snapshots: Avanti"
description: "Highlights from our experience of crafting an entire operational system for a rising educational enterprise"
tags: ['ruby on rails','angular','polymer','material design','mongodb','chef','amazon ec2','amazon s3','oauth2','micro services architecture','haproxy','bootstrap','videojs','mathjax','export pdf','jenkins','ci']
author: sanat
---
{% include JB/setup %}

<div class="row"><div class='col-md-8 col-md-offset-2'> <img class="img-responsive" src="/assets/blogs/Avanti-1.jpg"> </div></div>

**Introduction**

Recently we wrapped up a pretty big project, the large scale setup setup & development of Avanti’s operational system that included infrastructure & software for web services and interfaces. Avanti by the way is a recognized educational enterprise; they run learning centers across the country & use collaborative learning practices which rely on technology.

That’s where we came in. When we started the operations were run independently across a slew of third party tools & services, and consumed a lot of human hours in managing, transferring & analyzing the data. With the company poised to accelerate scale & operations fast, our scope was to build a new system from scratch, and to do it in a way so the transition was quicker & smoother.

Going into the details of the entire project would be a bit much, but we wanted to share our experiences of doing some pretty cool things. In this post we highlight some of them. 

**The Architecture**

College admissions & their exam preparations are by nature cyclical. Knowing that Avanti’s operations (at least on the student side) followed this, we started our inception there to understand the broad operational & technology requirements. Then we moved into understanding all their different users (content team, admins, teachers & students) and their requirements. Using all of this to lay out the technology blueprint was the crucial first step.

We decided to use a micro-services architecture, deploying loosely coupled systems so that applications & services load was borne by their particular servers. The services were segmented on operational needs & users, and comprised of:

*User Services* Single authentication service (OAuth2) to manage all users across all applications
*Content Management System* Primarily for the content team to create & upload content to, and which would deliver all content other applications. Tasks included adding questions & material, videos & other media as well as bundling of content to create tests and packages.
*Learning Management System* The frontend that delivers content in classrooms & for online access. Apart from abstracting & delivering content from CMS, the LMS also takes inputs like attendance & test scores and analyzes data visually.
*Online Testing* Conducts online tests, tracks & calculates scores as & when needed. Uses high configuration instances to handle thousands of requests during synchronized tests, serve the load & shut down once test is complete.

<div class="row"><div class='col-md-8 col-md-offset-2'> <img class="img-responsive" src="/assets/blogs/Avanti-2.jpg"> </div></div>


All these services are launched on 1 server each with separate databases which are scaled horizontally/vertically as needed. We created a Staging build pipeline (an exact replica of Production environment) where we could release, test & fix bugs and deploy final code on production using a single click. 

Stack: AWS EC2/S3 instances with HAProxy, Ruby on Rails applications & MongoDb

##Frontend

Our first milestones were finishing the centralized User Service & a version of CMS that allowed content team to create & upload content. A fast desktop friendly interface for both these services was the call of the hour since their users would always be internal i.e. admins & content team members. We used Bootstrap to deliver working versions pretty fast, and kept iterating & streamlining as the transition for this set of operations began.

The LMS, which was essentially the frontend that all teachers & students would use in classrooms, needed a bit more thought. It needed to be flexible to render across all user devices (classroom monitors, teachers’ laptops, students’ tablets et al) & it had to be fast given that it would be accessed from smaller towns & cities with internet speeds that leave a lot to be desired.


<div class="row"><div class='col-md-8 col-md-offset-2'> <img class="img-responsive" src="/assets/blogs/Avanti-3.jpg"> </div></div>

As our luck would have it, the timing coincided with the launch of Material Design & the rise of supporting frameworks, and we decided to run with it. A sharp learning curve followed, but with the help of Angular, Materialize CSS & doggedly determined developers, a working version of LMS was rolled out quickly. 

The other upshots of using this stack was scalability; each learning centre gets to control their own classroom experiences by customizing lesson plans, and as the number of centres and users scale so can the LMS without affecting other systems.

**Content Bundles**

So far we have applications & services to administer users, add content & manage classroom experiences. But education doesn’t stop when the class is over. Providing their students with content bundles for further reading & self-testing is an important part of the Avanti experience, and this part used to be cumbersome.

For every curriculum there are subjects, every subject has chapters, and every chapter has topics. A content package can be created at the topic & chapter level, and gathering all the content from all the places it was saved, to then selecting, assembling & formatting together such bundles used to take anything days & weeks. Many human hours burnt, and the ultimate outcome was a slick & exhaustive PDF document.


<div class="row"><div class='col-md-8 col-md-offset-2'> <img class="img-responsive" src="/assets/blogs/Avanti-4.jpg"> </div></div>

With the amount of time & effort it consumed, this was a process begging to be automated. We created templates for all the different type of content components & wrote a process that compiles and formats automatically. Now all the user has to do is open this application, select the content, add a few identifiers & the same PDF document is automatically generated within 10 minutes.


