---
layout: post
title:  "REST from a beginner's perspective"
description: "An overview of REST"
date:   2015-07-22 02:10:06
author: Gurupratap
---

<html>
	<title>
		<head> REST from a beginner's perspective </head>
	</title>

<body>
<p>
I had heard a lot about REST and RESTfullness of applications. It appeared to be a jargon for me for quite a while. It's actually not that difficult to understand. In this blog I have tried to focus on the conceptual idea of what REST is and did not get into the standard definition. I have used the example of Rails to describe how it uses REST.
</p>
<p>
REST stands for Representational State Transfer which is an architectural style for web applications. What REST focuses on is a web which has a rationale to support it in becoming scalable. It emphasizes on better user perceived performance, separation of concerns and provide generic interfaces for better communication between components. A RESTful application manages to do so by following the six constraints which were first communicated by Roy Fielding in his doctoral dissertation (see <a href ="http://www.ics.uci.edu/%7Efielding/pubs/dissertation/rest_arch_style.htm"> http://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm)</a>.
</p>
<p>
Any form of information that can be named is called a <i>resource</i> in REST. A resource is a mapping to a set of entities and represent their state which varies with time. This means that they can be both static as well as dynamic depending upon the semantics of the mapping. For example, "User's favorite song" is a mapping which changes with time whereas "Composer of the song Black" is a mapping which is static. REST allows us to define identifiers for these resources instead of defining documents identifiers which was done previously. Defining document identifiers meant that it would have to be changed as soon as the data in the documents changed. Resource identifiers allow us to identify the concept rather than the actual content. However, it then becomes our responsibility to ensure that the identifier chosen does correspond to the intended resource.  In a RESTful architecture the request and response objects of queries are representations of data and not the original data. Representations allow us to cater the needs of different clients effectively since the data type can be dynamically selected from the available standard types depending upon the recipient's need.
</p>
<p>
To illustrate how REST can be applied let's see how Rails works in a RESTful manner. Rails identifies data objects like files, images, videos, etc. by the term <i> resource </i>. These resources are instances of the model they belong to and have a controller associated with them for their manipulation. The controller includes the <i>index, edit and new </i>actions along with the CRUD (Create Read Update Delete) operations. The action to be performed is identified by understanding the query which is a combination of HTTP verbs(GET, POST, PUT and DELETE ) and the URI specified. These are known as RESTful routes which are created when the resource is first generated. The use of these routes makes URLs simpler and uniform regardless of the action to be performed (Check section 2.2 of <a href="http://guides.rubyonrails.org/routing.html">Rails Routing Guide</a> to understand how it works). Along with these routes, PATH helpers and URL helpers like <i>resource_path</i> and <i>resource_url</i> are also created. For example, these PATH and URL helpers are helpful in writing<i> link_to</i> statements in views and <i>redirect_to</i> statements in controllers.  Representations of resources can be sent across in different formats by writing the <i> respond_to </i> blocks in the controllers. In a REST application writing this becomes easier because URL helpers make it simple.
</p>
<p>
I hope this gives you a gist of REST. I would suggest you to go through the <a href ="http://www.ics.uci.edu/%7Efielding/pubs/dissertation/rest_arch_style.htm"> link </a> mentioned above to get a deeper understanding of what was the basis and the details of the design and constraints involved in REST.
</p>
</body>
</html>
