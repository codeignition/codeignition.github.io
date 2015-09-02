---
layout: post
title:  "REST from a beginner's perspective"
description: "An overview of REST"
tags: ['rails','rest']
author: gurupratap
---
{% include JB/setup %}

I had heard a lot about REST and RESTfullness of applications. It appeared to be a jargon for me for quite a while.
It's actually not that difficult to understand. In this blog I have tried to focus on the conceptual idea of what REST is and did not get into the standard definition.
I have used the example of Rails to describe how it uses REST.

REST stands for Representational State Transfer which is an architectural style for web applications.
What REST focuses on is a web which has a rationale to support it in becoming scalable.
It emphasizes on better user perceived performance, separation of concerns and provide generic interfaces for better communication between components.
A RESTful application manages to do so by following the six constraints which were first communicated by Roy Fielding in his doctoral dissertation,
see [http://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm](http://www.ics.uci.edu/%7Efielding/pubs/dissertation/rest_arch_style.htm)

Any form of information that can be named is called a *resource* in REST. A resource is a mapping to a set of entities and represent their state which varies with time.
This means that they can be both static as well as dynamic depending upon the semantics of the mapping.
For example, "User's favorite song" is a mapping which changes with time whereas "Composer of the song Black" is a mapping which is static.
REST allows us to define identifiers for these resources instead of defining documents identifiers which was done previously.
Defining document identifiers meant that it would have to be changed as soon as the data in the documents changed.
Resource identifiers allow us to identify the concept rather than the actual content.
However, it then becomes our responsibility to ensure that the identifier chosen does correspond to the intended resource.
In a RESTful architecture the request and response objects of queries are representations of data and not the original data.
Representations allow us to cater the needs of different clients effectively since the data type can be dynamically selected from the available standard types depending upon the recipient's need.

To illustrate how REST can be applied let's see how Rails works in a RESTful manner. Rails identifies data objects like files, images, videos, etc. by the term *resource*.
These resources are instances of the model they belong to and have a controller associated with them for their manipulation.
The controller includes the *index, edit and new* actions along with the CRUD (Create Read Update Delete) operations.
The action to be performed is identified by understanding the query which is a combination of HTTP verbs(GET, POST, PUT and DELETE ) and the URI specified.
These are known as RESTful routes which are created when the resource is first generated.
The use of these routes makes URLs simpler and uniform regardless of the action to be performed.
(Check section 2.2 of [Rails Routing Guide](http://guides.rubyonrails.org/routing.html) to understand how it works).
Along with these routes, PATH helpers and URL helpers like *resource_path* and *resource_url* are also created.
For example, these PATH and URL helpers are helpful in writing *link_to* statements in views and *redirect_to* statements in controllers.
Representations of resources can be sent across in different formats by writing the *respond_to* blocks in the controllers.
In a REST application writing this becomes easier because URL helpers make it simple.

Further Reading -

[details of the design and constraints involved in REST.](http://www.ics.uci.edu/%7Efielding/pubs/dissertation/rest_arch_style.htm)
