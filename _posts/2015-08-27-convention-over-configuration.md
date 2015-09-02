---
layout: post
title: "Why Convention Over Configuration?"
description: "Why do software developers need to follow conventions of a framework"
tags: ['Ruby', 'Rails', 'Convention']
author: sartaj
---
{% include JB/setup %}

`Convention over Configuration` is a pattern/paradigm in the software development world which aims at gaining simplicity in the development approach and as a result of these conventions the developer has to make lesser number of decisions as the framework makes most of them.
It relies on the development of an application by using the framework's inbuilt procedures.

Lets say that you are hosting dinner for one of your friends and wish to make a new kind of meal to impress your friend. You have two approaches to do it.
The first approach is the hard approach where you build everything from scratch and discover your own order of mixing ingredients. This approach will allow you to experiment with your recipe but there is a risk that you might be covered by more of your ingredients than you put in your meal and end up getting late.
The second approach is where you follow a proper recipe advisor and have the basic ingredients already built for you and an order of mixing ingredients already decided. And you can still experiment with the recipe wherever you feel the urge to. This approach promises you simpler and faster meal preparation, hence an impressed friend.


### Lets talk about the convention principle in Ruby on Rails Framework
When I started working with `Ruby on Rails`, I could see a lot of controllers and views and models for the database. Then i came to know that the team behind `Rails` has set up rules to ease up working with the application which helps to reduce the need of heavy configuration.
And moreover you can always override any rule according to your need but sticking with the conventional rules really speeds up the process of development and helps to keep the code concise and understandable. It helps you to navigate easily through your application without confusion.


From the very start, when you create a new `Rails` app by using the command below, `Rails` creates a number of files for you.

~~~ Ruby
rails new app-name
~~~

You automatically get the folders to hold your controllers, views and models.
Folders to include your testing files and assets such as Javascript and CSS stylesheets.
This speeds up the process of your app development as you precisely know where your code will go in the application and if a new developer
has to continue with your project he will understand the code and its utility very easily without confusion, if only you have written atleast readable code, and not a new language of your own.



The `Rails` app generates different environment files for you as well i.e. development, test and production.
This makes it easier to keep your changes in a particular environment as they will only be loaded from the corresponding configuration file when running in that environment.
For example we dont need to do precompilation of assets when in development mode but we do need that in production mode as it really speeds up the application behaviour and response time.

There is also a database config file that has separate entries for each environment so that you dont have to worry about changing data once an app is deployed to production.

In `Rails` if you have a model named `User` , the corresponding database table will be called `users` and the handling controller is called `users_controller`. The table will automatically have columns of `created_at` and `updated_at` and not needing manual implementation.
As they say , sometimes having too many options is a bad thing and it confuses you till you are on the verge of indecision. You can always have a name that you want and override the conventional names but that should be
avoided unless absolutey necessary.


Another convention in `Rails` allows you to get the desired output from your views in HTML  or in `JSON` by just appending .json at the end of your url.

What `convention over configuration` really suggests is that there is a hard way to do a thing and then there is a smart way to do the same thing without necessarily losing flexibility, and that smart way has its pros of being speedy, less confusing, simple to understand and adaptable to different minds.
So, if you are an inspiring developer and have a thing for simple and speedy development, then `Convention over Configuration` is the way to go.
