---
layout: post
title: "How Mongo geoNear Saved The Day"
description: "Experience handling massive location requests on Redis Lua Geo and Mongo geoNear"
author: mehak
tags: ["mongodb","redis","geo-near","location"]
---
{% include JB/setup %}

The requirement was straightforward: Save users’ locations (latitudes & longitudes) & query against them to produce a list of nearby users within a set radius of any user.

We chose [Redis](http://redis.io/commands#geo) with Lua Geo Scripting, and we set up 1 master to write & 2 slaves to read from. The updates were matching the incoming rate and the slaves were handling the reads, The numbers climbed up to 80,000 requests per minute.

Then we came to know about an [issue](https://groups.google.com/forum/#!topic/redis-db/w6zcOzVtPXg) in Redis-Geo, that it doesn't sync the Geo Data at all.

The fix for this is expected in the next Redis update version [3.2](http://antirez.com/news/89) & the only temporary solution was to restart slaves, which as a force resync doesn’t really work when you have to restart slaves every minute.

This stop gap solution wasn’t going to work, so we decided to use [MongoDb-geoNear](http://docs.mongodb.org/manual/reference/command/geoNear/). We set up the same 1 master & 2 slaves environment and to handle the request load efficiently we made a few enhancements.

One was introducing [Rabbitmq](http://www.rabbitmq.com), thus queuing up all the update requests so as to not overload Mongo & leaving no chance of losing any requests.

Another was moving Mongo to a RAM disk. Since the data size itself was not large, this step gave a huge boost in load performance, and the last one was making the correct set of indexes.

The solution worked. We have been keeping up with the load consistently as the number of requests has only grown. The sync happens on time, and there are no more slave restarts.
