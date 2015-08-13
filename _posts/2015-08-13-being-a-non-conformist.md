---
layout: post
title: "Being a Non-conformist"
description: "Views on diving into internals and about software complexity"
author: hariharan
---
{% include JB/setup %}
<br>
It is incredible that most of us live our life within the societal conventions, accepting life as it is without questioning. By doing things as recommended, our learning curve is severely damaged. The only way we can bring a revolution is by questioning the status quo. 
<br /><br />
We as programmers, are the creators of complexity. We create abstractions on top of abstractions.. Sometimes, its hard to grasp why we are doing something. To quote Jim Gordon in The Dark Knight,
<br /><br />
"There's a point, far out there when the structures fail you, and the rules aren't weapons anymore, they're... shackles letting the bad guy get ahead. One day... you may face such a moment of crisis. And in that moment, I hope you have a friend like I did, to plunge their hands into the filth so that you can keep yours clean!"
<br /><br />
We encounter many such frameworks / patterns which are portrayed as structures but are indeed shackles. But we aren't brave enough to get our hands dirty. "Its too much trouble", "Why bother to when there's a library", "Why reinvent the wheel" are excuses we give to bullshit our self.
<br /><br />
Yes, there are cases when you should use an existing framework / a pattern. But, one must be aware of the cornercases, limitations properly before doing so. By diving without learning about the internals, we complicate things and  make bad decisions that affect throughout the program lifecycle.
<br /><br />
For example, it is a mistake to keep using rails without knowing the HTTP internals such as TCP slow start, cache control headers, latency overhead because of too many requests, etc. It is acceptable for a beginner, but we must strive to be better than our self yesterday.
<br /> <br />
Don't let your curiosity and zeal to dive into internals die because of time constraints, or fancy processes where we ship code that works and forget about it. 
<br /><br />
Ultimately, think about what you want to be remembered as, "a producer" or "a consumer".
<br /><br />
Be a late bloomer, but at least, be a bloomer.
<br /><br />
- Hari haran