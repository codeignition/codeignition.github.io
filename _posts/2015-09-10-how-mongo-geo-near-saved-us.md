---
layout: post
title: "How Mongo Geo Near Saved Us"
description: "Experience with the redis-geo and mongo-geo"
author: mehak
tags: ["mongodb","redis","geo-near","location"]
---
{% include JB/setup %}
This is a story of a experience with Redis-geo and Mongo-geo.

There was a requirement to save location (latitude/longitude) for users and then query on that to get nearby users in a given radius.
The frequency of updates was around 1500~2000 requests per second.
To match with that Frequency we decided to use [Redis-geo](http://redis.io/commands#geo).
The query Frequency was also high along with the Updates. So we had set up cluster with 1 master to write and 2 slaves to read from.
The Updates rate was meeting up with the incoming rate, and slaves were handling the reads.
Then We came to know about an [issue](https://groups.google.com/forum/#!topic/redis-db/w6zcOzVtPXg) in Redis-Geo,
that there is a problem with the sync for geo data and the fix will be in Redis version [3.2](http://antirez.com/news/89).
And the only temporary solution was to restart slaves, that was like force resync.

But the data updates were so frequent that we had to restart salves every minute. This was a stop gap solution till we figure out something concrete.

We decided to use [MongoDb-Geo-Near](http://docs.mongodb.org/manual/reference/command/geoNear/).
So we moved to mongo, Setup 1 master 2 slaves environment To Handle the load and come near the redis performance we made certain enhancements

One was Introducting [Rabbitmq](http://www.rabbitmq.com), thus queueing up all the update requests, so not overloading Mongo and there is no chance of losing any requests.

Another Was moving mongo to a ram disk. Since our Data size was not large, this step was a major booster in performance.

Finally Making the correct set of indexes and we are keeping up with the load now.The sync happens on time  and No more restarts.
