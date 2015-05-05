---
layout: post
title: "Getting started with puppet using vagrant"
description: ""
tags: []
author: shobhit
---
{% include JB/setup %}

Getting Started with Puppet Open Source

I struggled a lot understanding Puppet master and agent configurations, and setting up and registering a new node at master.
And just to wrap all the setting before starting to write modules.

Lets create puppet master. No we need a machine on which we can setup Puppet master.
We can use vagrant for that. Vagrant it is excelent tool can be used for fast provisioning of VM.
It will take care all the VM configuring buisness, with a highly intitutive dsl, so that you won't have to deal with it and can focus on your work

So lets add a file named Vagrantfile.

```ruby
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
end
```

Now start this VM by

```
vagrant up
```

Now our server is up and running. Lets set-up Puppet master
login to the server

```
vagrant ssh
```

Now install puppet

```
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update
sudo apt-get install puppetmaster-passenger -y
```

to test
