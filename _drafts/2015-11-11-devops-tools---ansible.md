---
layout: post
title: "Devops tools we love - Ansible"
description: "A basic introduction to Ansible"
category: [configuration management, orchestration]
---
{% include JB/setup %}

Imagine a situation where you have two machines, where one is your
workstation. Let's call it the management node. The other one is a fresh
ubuntu/centos machine which can be bare metal physical box or a cloud
instance. Let's say you have to configure this machine into a apache or
nginx web server.

One way to go about this would be to manually ssh into the machine,
install the necessary packages and editing the configuration files.

This is a pretty common practice, but this manual work can quickly pile
up if you have say tens or even hundreds of machines. Not only will this
take up a lot of your precious time and energy, but the chances of
making an error are there as well, as we are doing everything manually.
Also there are always these scenarios when something important dies and
you are not sure about how to recreate it quickly. And you again engage
into such manual work which created this mess in the first place.

#### There should be a better way, right.

This is where configuration management tools come in to automate such
tasks, saving you time and improving the overall process.

Ansible is one such easy to use open source configuration management and
orchestration tool, and is directly targeted at solving such problems.

Let's just get started. Let's go back to our problem. We had many
instances and everyone needed to configured in a different way.

So what we need is Ansible installed on your machine/workstation. This
is generally called the Ansible management node. Also you need an inventory
file and playbook(s).

#### What do these terms, inventory file and playbooks mean?

An inventory file is basically just a listing of host names or ip
addresses of instances you want to configure. You can either use fqdn or
just host names or even ip addresses, neat right. You can also group a
number of instances under a heading, if those nodes are to configured
the same way.

    [load-balancer]
    haproxy-01.exam ple.com
    haproxy-02
    10.2.10.15

    [web-app]
    web-app-01.example.com
    web-app-02

Above is a sample host inventory file. Notice how can we group these
instances together. So now while running a script, I can just mention
the group `load-balancer` and it will run on all the three instances
mentioned.

Playbooks are configuration files, that outline tasks that are to be run
against a host, that otherwise we would have performed manually. Playbooks
are in written in yaml which makes it very easy to write and it also
increases the readablity as its almost plain English. Below is an
example playbook file.

    ---
    - hosts: web-app
      sudo: yes

      tasks:

      - name: install nginx
        apt: name=nginx state=installed update_cache=yes

      - name: load config file
        template: src=templates/nginx.conf.j2 dest=/etc/nginx/nginx.conf

      handlers:

      - name: restart nginx
        service: name=nginx state=restarted

One can see the playbook is self-explanatory in itself, which is really
great if we have multiple people on the same team.

Now, when we run ansible-playbook shell command, along with other
parameters, ansible will look into the hosts file for the machines,
ssh-trusts into them and performs the tasks listed in the playbook.

And that's it. It's really as easy as that.

Below are some links for further reading.

- [Ansible Docs](http://docs.ansible.com/)

