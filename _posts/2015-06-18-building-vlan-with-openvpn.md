---
layout: post
title: "Mopping up a networking nightmare with an openvpn vlan"
description: "build a peer to peer openvpn star vlan network"
tags: ['openvpn','star topoloagy','peer to peer','infrastructure','firewall','networking']
author: sankalp
---
{% include JB/setup %}

Recently I came across a broken infrastructure where all the servers were managed manually with huge iptable rules.
Each hosts were having as many as seven to eight VMs and with each interface configured with different network address.
Port forwarding for all the application in all the VMs.
To make the applications communication, huge number of iptable rules were configured which made it very difficult to manage.
There were firewall configuration for per user access on the basis of their static IP.

Imagine some poor guy, who needs ssh access to some of servers. Then to do that him public IP has to be added into the firewall
configuration and on top of that if they change their location then this process has to be repeated again.
If some new application needs to be deployed, then port forward the application port and add the IPs of all the other
servers that needs to interact to this server. And he need to be mighty smart to remember all the ssh ports to numerous VMs.

Database backup was taken by 2 cron jobs, one running on the server which takes the backup and copies it on the host machine
and the other cron job that runs on the host machine which copies the collected backup to the backup server.

Impossible to use any automation tool and no monitoring setup as there was no central location that can reach all the servers.
Every deployment has to be done manually by logging into the production server.
It seems unreal in today’s time when we have so many tools and methodologies to manage infrastructures but that was the case.

The below diagram represents the horrendous arrangement of host and VMs.

<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="horrendous infrastructure" src="/assets/blogs/p2p-01.jpg" style="margin: 20px 2px;"></div></div>

It was crystal clear to us, that this infrastructure was bound to give us nightmares. I can’t live that, so need to fix it.
And to fix it good we at very least needed.

* A central server which can automate infrastructure setup
* A monitoring server to monitor infrastructure health
* And above all, Networking should be simple, easy to manage and automate

To kick start the revival, networking was the most obvious pain point.
Plan was to frist get rid with port forwadings and mind boggling firewal configs.
So we planned to setup a vlan, as all VMs were under different network address even in a host.

Plan was to set up a vlan between all the host, with one central sever connected all host like in star topology.
This central server will host an openvpn server to which users can connect and directly access VMs without black magic of ports and firewalls.
And this server can be used for other infra activites like configuration management and monitoring.

To achieve this we needed to fix one host first. So now we needed an Openvpn server up and running on it.
To start with the setup we can provision a VM on this host and install openvpn server.
Its a simple installation and any of the links below can be followed to install the server.

* [https://openvpn.net/index.php/open-source/documentation/howto.html#install](https://openvpn.net/index.php/open-source/documentation/howto.html#install)

* [https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-14-04](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-14-04)


After the openvpn installation, any user can connect to the VPN server via a client.

<div class="row"><div class='col-md-6 col-md-offset-3'><img class="img-responsive" alt="openvpn client connection" style="margin: 20px 2px;" src="/assets/blogs/p2p-02.jpg"></div></div>

Sample server.conf:

```
server                10.8.0.0 255.255.255.0
port                    1194
dev                     tun0
proto                   udp
user                    nobody
group                   nogroup
ifconfig-pool-persist   ipp.txt
status                  openvpn-status.log
log-append              /var/log/openvpn.log
keepalive               10 120
verb                    3
mute                    10
comp-lzo
persist-key
persist-tun
push "route 10.2.2.2 255.255.255.255"
ca   /etc/openvpn/ca.crt
key  /etc/openvpn/burrow.key
cert /etc/openvpn/burrow.crt
dh   /etc/openvpn/dh2048.pem
```

On the basis of above configuration we will assume the following values :

* Tunnel between the host and the server has the network 10.8.0.0/24
* The vpn server IP is 10.2.2.2
* Port that we are connecting to is 1194

If everything is kept to default then we can see a tun0 created with inet address 10.8.0.1.

Next step is to install the openvpn client on your workstation. Mac users can use tunnelblick as a vpn client.
Linux users can use openvpn client from command-line.
Follow the below link to generate client configuration using easy rsa.

* [https://openvpn.net/index.php/open-source/documentation/miscellaneous/77-rsa-key-management.html](https://openvpn.net/index.php/open-source/documentation/miscellaneous/77-rsa-key-management.html)

Now we can reach the private IP of our vm. If it does not work then you might have to debug some of the networking issues.
Following are the few things that you should check.
* Port forwarding from host to our vpn server
* Postrouting configuration on the vpn server

Port forwarding can be done by adding the below rule:

```
iptables -t nat -A PREROUTING -p tcp  --dport 1194 -j DNAT --to-destination <vm ip> --to-port 1194
```

Postrouting configuration on the vpn server:

```
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o tun4 -j SNAT --to-source <vm IP address>
```

Now that we are able to reach vpn server, we will try to reach other vm on the same host.
If you are able to communicate among the vms on the same host then just adding the below line to server.conf is sufficient to reach other vm over vpn.

```
push "route <vm> 255.255.255.255"
```

<div class="row"><div class='col-md-6 col-md-offset-3'><img class="img-responsive" alt="openvpn client connection" style="margin: 20px 2px;" src="/assets/blogs/p2p-03.jpg"></div></div>

At this point our vpn client can connect to these vms as if they are on the same LAN.
We can gladly remove any firewall configuration specific to whitelisting user IP, for that host.
And **no more Port forwading**.

We have now fixed one host, now its time to tackle others. We want to bring all other hosts under this same network.
So users can reach any vm using same openvpn clients, without remembering on which host they really exist.
To add another host machine we will set up peer to peer openvpn connection between the openvpn server and the new host.
To achieve this we need to:

* Install openvpn server on the new host
* Create configuration files for openvpn p2p on both the vpn server and the host
* Check firewall configuration

Sample configuration for servers:

**Central VPN Server**

```
mode p2p  # default
proto udp # default
dev tun1  # default
port 1294 # default - server will listen on all interfaces, on this port
ifconfig 10.20.0.1 10.20.0.2 # first Tunnel-IP is local, 2nd Tunnel-IP is remote
route <VM ip> 255.255.255.255
verb 3
secret static.key # openvpn --genkey --secret static.key
keepalive 10 60
persist-tun
persist-key
persist-local-ip
comp-lzo
```

**New Peer Host**

```
mode p2p  # default
proto udp # default
dev tun   # default
remote <vpn_server host> 1294 # client will connect to this (server) IP + port
ifconfig 10.20.0.2 10.20.0.1 # first Tunnel-IP is local, 2nd Tunnel-IP is remote
verb 3
secret static.key
keepalive 10 60
comp-lzo
explicit-exit-notify 2
```
[can refer here](http://john.de-graaff.net/wiki/doku.php/links/openvpn)


We can see from the configuration that we are creating a new tunnel i.e tun1 between vpn server and the host which is listening on 1294 port.
Firewall configuration that should be checked:

* Forward 1294 port same as what we did with 1194 port above
* Postrouting configuration on vpn server nat table
* Peer host should be configured such that it should accept connections on vpn tunnel.

With above configuration host should be reachable at 10.20.0.2 from the server. Now to add the VM on the peer host in vpn network,
we just have to add the below line in vpn server p2p configuration file.

```
route <vm ip> 255.255.255.255
```

Add the static route on vpn server:

```
route add -host <vm ip> gw 10.20.0.2
```

Add push route for this vm in server.conf file.

```
push "route <vm> 255.255.255.255"
```

<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="horrendous infrastructure" src="/assets/blogs/p2p-04.jpg" style="margin: 20px 2px;"></div></div>

Now any user who has vpn access can access all the vms on these two hosts directly.
This method can be replicated for all the other hosts and their VMs. And then finally we can lit a match to burn down those Firwall rules and configurations.

<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="horrendous infrastructure" src="/assets/blogs/p2p-05.jpg" style="margin: 20px 2px;"></div></div>

We can do better, by implementing an internal DNS can help us to address our servers by their host names rather than their IP addresses,
setting up an ansible master or any other configuration management tool on this machine and automate the infrastructure setup,
setting up monitoring server such as sensu (or nagios, if you are one of those guys) monitor the health of infrastructure.
Now with this network, possibilties are endless !
