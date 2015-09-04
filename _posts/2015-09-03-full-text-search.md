---
layout: post
title: "Full-Text Search in SQL"
description: "How full-text seacrh works and what makes it efficient"
tags: ['ruby','rails','search','full text']
author: akashdeep
---

Full-text search means to take a sub-string and match it against a given database to find data with similar sub-strings.
SQL has queries like "LIKE" which can be used to search something in the data, but when database grows in size the 'LIKE' query takes time to process the results.
To counter these limitations MYSQL introduced a new concept FULLTEXT search.
It processes the columns initially to create indexes, and then the search queries return results a lot faster than the 'LIKE' query.
There are two main parts in the Full-Text search, Indexing and Searching.
Indexing is performed on every table of data to generate indexes, upon which the future search queries are performed. After the creation of indexes,
full-text search performs queries on these indexes instead of the original data tables.
Indexing is performed in this manner:
lets say we have a table with some documnets such d1,d2 and so on.

~~~ Ruby
Document sets = {d1, d2, d3, d4, ... dn}
Word sets = {w1, w2, w3, .. wn}

=>

w1 -> {d1, d5, d9,.. dn}
w2 -> {d11, d50, d2,.. dn}
w3 -> {d23, d67, d34,.. dn}
:
wn -> {d90, d87, d57,.. dn}

~~~

The word set contains all the terms or words in the table, the matrix generated contains the data in the form of hashes,
with each word as the key and as its value it contains all the documents in which it is present.

Now the search query will be performed in this way:

~~~ Ruby
SELECT *
FROM   table
WHERE  MATCH (column) against ('w2');

~~~

So this search query will check with the indexes and return all the documents associated with the word 'w2', here it will return:

~~~ Ruby
documents = d11, d50, d2,.. dn

~~~

Full-Text search queries are also very flexible and operations like 'AND' 'OR' can be easily performed in comparison with "LIKE" queries.
This makes the use of full-text even more productive.

Considering the above example again, if we want all the documents containing words 'w2' & 'w5', it will perform an 'AND' operation
between the two hashes and generate the resulting documents which appear in both of the hashes.

This is what makes the full-text search real fast.
