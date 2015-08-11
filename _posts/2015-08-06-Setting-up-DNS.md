---
layout: post
title:  "Setting up DNS server on ubuntu"
description: "DNS How To blog"
author: himanshu
---
# Setting up a DNS server from scratch

I am completely new to networking and had to setup a DNS server as part
of my Bootcamp. I started reading from different sources about DNS,
domain names, bind, and other related stuff. This blog basically
summarizes what I learned and I hope anyone who reads this will easily be able to
setup their DNS server on ubuntu.

I will start with the basics.

Domain Name System or DNS is a naming system that maps
an IP address to a domain name, which is basically an indentification
string. Domain names exist on different levels. The first-level domain
name includes domains like com, org, net, io, etc while the second and
third level domain names are "open for reservation" domain names that
are available to buy. First level domains are also known as top-level domains (TLDs) and the third-level domains are called subdomains.
For example, in the URL of google translator -
translate.google.com - .COM is the top-level domain, 'google' is the
second-level domain, and 'translate' is the thirld-level or subdomain.
A domain name that contains all the levels is called an absolute domain name or a fully qualified domain name (FQDN).

A domain name system consists of different kinds of records. But while
setting up a DNS server, a few of them are necessary to understand :

+ A record - Address record. Stores the domain name corresponding to an
IP. When DNS server receives a domain name query, it looks up in the A
records.
+ NS - Name server. Name server is another name for DNS server; so a
name server record stores the domain / IP of the DNS server.
+ CNAME - Canonical name record. Used for aliasing other domain names.
i.e. maps a name to another name.
+ PTR record - Pointer record. Opposite of an A record, i.e. maps an IP to a domain name or a CNAME. Used for reverse lookups.
+ SOA record - Start of authority record. Indicates the primary name
server.

While setting up a DNS server, it is good to know about the three
basic types of DNS servers, namely Authoritative-only name servers, Caching (or Recursive)
name servers and Forwarding name servers, or any combination made
from these. But since an authoritative-only DNS server does not concern
itself with answering to and querying from other name servers, it should
be the first choice to begin with.



## Installation and configuration

Numerous softwares are availabe to setup a DNS server like Bind, Cisco
Network Registrar, DNS Blast, Dnsmasq, and several others. Bind is
recommended. Because it is open source, the most widely used software
for implementing DNS protocols and is distributed for most Unix and
Linux platforms. Its latest stable release is Bind9. So here it goes -

Install bind9 and its utilities :
`$ sudo apt-get install bind9 bind9utils`

Additionally, to get the offline Bind9 documentation :
`$ sudo apt-get install bind9-doc`

That's all for the installation. Next comes the configuration file.
Bind saves the config files in the _/etc/bind/_ directory of the system.
But before configuring Bind, there are a few terms that would be needed:

+ Domain namespace - The naming system on which DNS is based is called the domain namespace. It has a hierarchical and logical tree structure.

+ Zone - DNS namespace is divided into zones. So, a DNS zone is a distinct portion of the domain name space, which stores name information about one or more DNS domains. Conversely, the total of all DNS zones forms the DNS namespace.

  Broadly speaking, there are two kinds of zones - forward zones and reverse zones. Forward zones work with the A records and hence map the domain names or addresses to the corresponding IPs. While, reverse zones work with the PTR records and hence do the reverse lookup of the IPs, so as to map them to their corresponding domain names.

### Configuration files

1. *named.conf.local* - Contains the definition of zones. All forward as
well as reverse zones are defined here. A zone definition also includes the
path to its zone file.

   Sample _named.conf.local_ :

        zone "hostname.tld" {
          type master;
          file "/etc/bind/db.hostname.tld";   #zone file path
        };

        zone "10.168.192.in-addr.arpa" {
          type master;
          file "/etc/bind/db.192";            #zone file path
        };


   + Upper section defines the forward zone "hostname.tld" and lower section
   defines the reverse zone, which contains the first three octets of the
   subnet in the reverse order, the subnet being _192.168.10.0/24_.

   + '.arpa' is a TLD and stands for "address and routing parameter area". It
   is used to define a reverse zone. While 'in-addr.arpa' serves the purpose of reverse
   resolution of IPv4 addresses.

   + Here, "hostname" and "tld" can be replaced by any other choice of hostname
   and TLD (.com, .io, etc.), say myowndomain.com. Also, the reverse zone
   "10.168.192.in-addr.arpa" can be replaced accordingly by the subnet in question,
   which here was _192.168.10.0/24_.


2. *Zone file* - It is a configuration file, which is actually a representation of a zone. All the files in the _/etc/bind/_ directory that start with _"db."_ are zone files. _"db.local"_ is the forward zone file of zone _'local'_, whose reverse zone file is _"db.127"_. It is a good practice to name a zone file same as name of the zone.  
Keep in mind that the zone file created has the same name and path as
given to it in the zone definition in _named.conf.local_.


A zone file must start with the TTL (Time to Live), which specifies for how long the records should be kept in the DNS Server's cache. The other mandatory record for a DNS Zone file is the SOA (Start of Authority) record.
After these two records, additional records, such as A, NS or PTR records, can be added.
When adding a record (except for an A record) for a hostname, the hostname should end with a period. Hostnames, which do not end with a period, are considered relative to the main domain name, for which the DNS Zone was created.

Forward and reverse zone files can be created in the _/etc/bind/_
directory, like a normal file. But, to avoid the permission issues that
might come with a new file, file's owner and mode should be
changed manually :

`$ sudo chown root db.hostname.tld db.192`

`$ sudo chmod 0644 db.hostname.tld db.192`

Here's a sample of forward and reverse zone files :


Forward zone file for "hostname.tld" - _/etc/bind/db.hostname.tld_

--------------------------------------------------------------------------
{%highlight vim%}
$TTL	604800
@	IN	SOA	ns.hostname.tld. 	email_id.example.com. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
             IN   NS	ns.hostname.tld.

ns           IN   A	  192.168.10.2  	; A - record of nameserver
machine1     IN   A	  192.168.10.3		; A - record of machine-1
machine2     IN   A	  192.168.10.4		; A - record of machine-2
{% endhighlight%}

Reverse zone file for zone "10.168.192.in-addr.arpa" -
_/etc/bind/db.192_

{%highlight vim%}
$TTL	604800
@	IN	SOA	ns.hostname.tld. 	email_id.example.com. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
	  IN	NS	  ns.hostname.tld.

2	  IN	PTR	  ns.hostname.tld.
3	  IN	PTR	  machine1.hostname.tld.
4	  IN	PTR	  machine2.hostname.tld.
{% endhighlight%}

+ A records are defined in the forward zone file and PTR records in the
revese zone file. NS records have to be defined in both zone files.
Note that, every time a zone files is edited, value of serial should be
incremented by 1 (it has been incremented to 2 for convenience).

+ Except for the A records, defined in the forward zone file, wherever the
hostname occurs, it has to end with a period.

+ email_id.example.com can be substituted with any relevent email address. Note that, instead of '@', period '.' is used while writing the email address. Also, it should end with period.

+ The reverse zone used in the file contains 3 octets from the subnet.
If the reverse zone is defined such that it contains less than 3 octets,
say 2, then the PTR records should contain the remaining 2 octets in
the reverse order.

Everytime a config or zone file is edited, it should be checked for syntax errors. This can be
done using the following commands.

To check the config files : `$ sudo named-checkconf`

To check the zone files : `$ sudo named-checkzone zone_name path/to/zonefile`

So, if I want to check the reverse zone file for syntax errors,

`$ sudo named-checkzone 10.168.192.in-addr.arpa /etc/bind/db.192`

This concludes the configuration. Now there is only one step left before
leaving the DNS server - to restart the Bind service :

`$ sudo service bind9 restart`

Suppose that the DNS server has been setup on a remote machine. So,
every machine, that has access to it and want to use the DNS server, would need to have an entry that
tells it to use the above set server as its DNS server. Nameserver
entries of a machine are stored in resolv.conf file, which is located in
_/etc/_ directory of an ubuntu system. This file can be edited using the head
file present in the _/etc/resolvconf/resolv.conf.d/_ directory. The contents of the head file are prepended into
the resolv.conf file when the service is restarted. If the file is directly edited, the changes would be removed as soon as the resolvconf service is restarted.

Name server in the sample files has ip _192.168.10.2_. So following
should be added to the head file :

{%highlight text%} nameserver  192.168.10.2 {%endhighlight%}

And then the resolvconf service should be restarted :

` $ sudo service resolvconf restart`

This should be repeated on every machine that intends to use the DNS
server.

Working of the DNS server can be verified using nslookup :

For forward lookup : `$ nslookup ns.hostname.tld`

For reverse lookup : `$ nslookpup 192.168.10.2`

If these yield IP address of name server and URL of name server,
respectively, then the DNS server has been setup successfully.
