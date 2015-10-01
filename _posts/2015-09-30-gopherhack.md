---
layout: post
title: "Hacking Gopher"
description: "Google Chrome Extension Tool - a hidden producity hack for golang developers"
author: abhinandan
tags: ["go","golang","chrome","productivity","hack"]
---
{% include JB/setup %}

I have recently started working on go and I am truly mesmerised by its tooling. The community is amazing and has built some great tools such as gofmt, goimports, godoc, etc.
Not only this , Recently as of version 1.5 they have even developed compiler and runtime to build go in go itself by completely removing the C code.

I recently came across a hidden gem which can be useful to most of the golang developers.
This is a google chrome extension named Hacking Gopher. Since this extension is not available in the chrome web store and hence unknown to many developers like me.

I would like to describe and document the installation process and its usage.

* To install this, first we need to download the latest go source code:

   `git clone https://go.googlesource.com/go`

   `cd go`

   `git checkout go1.5`

* After this open the chrome web browser and visiting the URL `chrome://extensions`

* Click on the `Load Unpacked Extension Button`. Switch to developer mode to enable this option.

  ![smiley](/assets/blogs/gopher_4.png){:height="70%" width="70%"}

* Navigate to the go source downloaded in step 1 and click select once you are inside `go/misc/chrome/gophertool` directory.

* A new gopher icon appears next to the address bar on top right.

  ![smiley](/assets/blogs/gopher_1.png){:height="40%" width="40%"}

* Open a new tab to check installation of Gopher Tool by typing Golang in address bar

  ![smiley](/assets/blogs/gopher_2.png){:height="60%" width="60%"}

* Press TAB or SPACEBAR Key to go into Hacking Gopher mode

  ![smiley](/assets/blogs/gopher_3.png){:height="60%" width="60%"}

### Quick Tips and Uses:

- To visit package url for packages and sub packages simply type name and press enter.

   `os/user` will redirect to `https://golang.org/pkg/os/user/` automatically.

- To visit any specific issue url in go source git repository, simply enter the issue number.

   `1234` will redirect to `https://github.com/golang/go/issues/1234`

- To visit any specific commit in go source type the commit id.

   `b1797390b95d1ffd3d97b19532bf451719d42fd5` will redirect to `https://go.googlesource.com/go/+/b1797390b95d1ffd3d97b19532bf451719d42fd5`

- To visit go review url type review id.

   `264590043` will redirect to `https://codereview.appspot.com/264590043`
