---
layout: post
title: "Mopping up a Networking Nightmare with an OpenVPN VLAN"
description: "How we fixed a troubled infrastructure and built a peer to peer openvpn star vlan network"
tags: ['openvpn','star topoloagy','peer to peer','infrastructure','firewall','networking']
author: sankalp
---
{% include JB/setup %}


Recently I came across a broken infrastructure where all the servers were managed manually with huge IP table rules.

Each host had as many as 7 to 8 VMs with each interface configured with different network addresses. Plus there was port forwarding for all the application in all the VMs, firewalls configured for per user access based on their static IP, and to make the apps communicate, a big chunk of IP table rules were configured. 

All of these combined made the infrastructure very difficult to manage. We turned it around, and this post will show in detail just how we did it.

**The Challenges** 

Imagine your average IT guy who needs SSH access to some servers. To gain this access, he has to add his public IP into the firewall configuration, and repeat this process every time he moves from one location to another, which can happen frequently. 

Once he’s in, and needs to deploy some new application as he is bound to, then he needs to forward the application ports and add the IPs of all other servers that needs to interact with this server. This guy will needs to have a fantastic memory to remember all the SSH ports to numerous VMs.

Database backup was taken by 2 cron jobs, one running on the server which takes the backup and copies it on the host machine, and the other running on the host machine which copies the collected backup to the backup server.

The setup made it impossible to use any automation tool, there was also no monitoring setup as there was no central location that can reach all the servers, and each deployment had to be done manually by logging into the production server.

The below diagram represents the horrendous arrangement of host and VMs.

<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="horrendous infrastructure" src="/assets/blogs/p2p-01.jpg" style="margin: 20px 2px;"></div></div>

This was an infrastructure bound to run into problems it couldn’t resolve automatically, and in today’s day & age where there are plenty of tools & methodologies available, that was just not something that could be allowed.

We decided to fix it, and fix it well. We knew at the onset that at the very least the solutions were:

* A central server which can automate infrastructure setup
* A monitoring server to monitor infrastructure health
* And above all, networking should be simple and easy to manage & automate

**The Plan**

Networking was the most obvious pain point, so we kick-started the revival there. And the first call of actions were to remove the port forwardings & mindboggling firewall configurations.

As all VMs were under different network address even in a host, our plan was to set up a VLAN between all the hosts, with one central sever connecting them all like in star topology.

This central server then hosts an OpenVPN server from which users can directly access VMs without the black magic of ports and firewalls. Plus this server can be used for other infra activities like configuration management and monitoring.

We started by fixing one host first, beginning with the setup of provisioning a VM on this host and installing OpenVPN server. It’s a simple installation and any of the links below can be followed to install the server.

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

On this configuration’s basis we assume the following values:

* Tunnel between the host and the server has the network 10.8.0.0/24
* The VPN server IP is 10.2.2.2
* Port that we are connecting to is 1194

If everything is kept to default then we can see a tun0 created with inet address 10.8.0.1.

Next step is to install the OpenVPN client on your workstation. Mac users can use TunnelBlick as a VPN client. Linux users can use OpenVPN client from command-line.

See the link below to generate client configuration using easy RSA.

* [https://openvpn.net/index.php/open-source/documentation/miscellaneous/77-rsa-key-management.html](https://openvpn.net/index.php/open-source/documentation/miscellaneous/77-rsa-key-management.html)

Now we try to reach the private IP of our VM. If this step doesn’t work then you might have to debug some of the networking issues.


Check that you have done these things:

* Port forwarding from host to our VPN server
* Post routing configuration on the VPN server

Port forwarding can be done by adding the below rule:

```
iptables -t nat -A PREROUTING -p tcp  --dport 1194 -j DNAT --to-destination <vm ip> --to-port 1194
```
Post-routing configuration on the VPN server:

```
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o tun4 -j SNAT --to-source <vm IP address>
```

Now that we are able to reach VPN server, we will try to reach other VMs on the same host.
If you are able to communicate among the VMs on the same host then just adding the below line to server.conf is sufficient to reach other VM over VPN.

```
push "route <vm> 255.255.255.255"
```

<div class="row"><div class='col-md-6 col-md-offset-3'><img class="img-responsive" alt="openvpn client connection" style="margin: 20px 2px;" src="/assets/blogs/p2p-03.jpg"></div></div>

At this point our VPN client can connect to these VMs as if they are on the same LAN. We can gladly remove any firewall configuration specific to whitelisting user IP for that host. And **No More Port Forwarding**.

That’s one host fixed. Now it’s time to fix the others. Our goal is to bring all other hosts under this same network so users can reach any VM using same OpenVPN clients without needing to remember hosts.

To add another host machine we will set up peer to peer OpenVPN connection between the OpenVPN server and the new host.

For this we need to:

* Install OpenVPN server on the new host
* Create configuration files for OpenVPN p2p on both the VPN server and the host
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

You can refer more here (http://john.de-graaff.net/wiki/doku.php/links/openvpn)

We can see from the configuration that we are creating a new tunnel i.e tun1 between VPN server and the host which is listening on 1294 port.

Check that the firewall configuration has:

* Port 1294 forwarding (just the way we did with 1194 port above)
* Post-routing configuration on VPN server NET table
* Peer host configured to accept connections on VPN tunnel

With above configuration host should be reachable at 10.20.0.2 from the server. Now to add the VM on the peer host in VPN network, we just have to add the below line in vpn server p2p configuration file.

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

Now any user who has VPN access can access all the VMs on these two hosts directly.

This method was then replicated for all the other hosts and their VMs as well. And finally we lay to rest those firewall rules and configurations.

<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="horrendous infrastructure" src="/assets/blogs/p2p-05.jpg" style="margin: 20px 2px;"></div></div>

But we didn’t stop there. We improved things further by:

* Implementing an internal DNS which enables user to address servers by their host names rather than their IP addresses
* Setting up an Ansible master on this machine (any config management tool can work)
* Automating the infrastructure process
* Setting up Sensu monitoring server (you can use Nagios, if you are one of those guys) to monitor the infrastructure’s health

Now with this network, the possibilities are endless!

