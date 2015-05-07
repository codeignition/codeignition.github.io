---
layout: post
title: "DevOps tools we love: Vagrant"
description: ""
category: 
tags: []
---
{% include JB/setup %}

Vagrant provides easy to configure, reproducible, and portable work environments.
To achieve its magic, Machines are provisioned on top of VirtualBox, VMware, AWS, or any other provider.
Then, provisioning tools such as shell scripts, Chef, or Puppet, can be used to automatically install and configure software on the machine.

Vagrant is useful for everyone

* **Developer**

  Creates a single Vagrantfile, you just need to vagrant up and everything is installed and configured for you to work.
  Other members of your team create their development environments from the same configuration, so whether you're working on Linux, Mac OS X, or Windows, all your team members are running code in the same environment, against the same dependencies, all configured the same way.
  Say goodbye to "works on my machine" bugs.

* **DevOps Engineer**

  Vagrant gives you a disposable environment and consistent workflow for developing and testing infrastructure management scripts.
  You can quickly test things like shell scripts, Chef cookbooks, Puppet modules, and more using local virtualization such as VirtualBox or clouds as AWS.

* **Designer**

  No more bothering other developers to help you fix your environment so you can test designs. Just check out the code, vagrant up, and start designing.

Just create a box with a simple

```
vagrant init ubuntu/trusty64
vagrant up
```

You'll have a fully running virtual machine in running Ubuntu 14.04.
You can SSH into this machine with ```vagrant ssh```, and when you're done playing around, you can stop it with ```vagrant halt```.
Or just delete it for good with ```vagrant destroy```

Vagrant gives you simple DSL for configuring virtual machines.
You can setup networking amongst multiple machines, create a cluster of machines or sync your folders to virtual machines.
Vagrant gives you complete flexibility.

Vagrant also gives you an interesting feature of sharing your machine on public internet, which could comes in handy for demos or debugging
