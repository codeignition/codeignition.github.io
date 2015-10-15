---
layout: post
title: "Storing Infrastructure Secrets"
description: ""
category: 
author: monika
tags: [chef, secrets, vault, encrypted data bags]
---
{% include JB/setup %}
<br />
Chef is one of the most popular configuration management tool. It  is a platform that permits the user to manage servers programmatically, providing flexibility
in customizing configurations on the go. It  easily configures the OS, install and configure apps, start and stop them in given situations. 
<br /> <br />
Chef server stores your recipes as well as other configuration data. 
In every infrastructure, there is some sensitive data which needs to be hidden such as database passwords, AWS credentials, SSL Certificates to name a few. This is something very important to deal with. 
The question arises is how to manage this sensitive data? How to store it on the chef-server?  Or is it possible to store it at some secure place and procure it as and when needed.How do we manage these secrets which chef needs to configure the systems?
<br /><br />
Chef provides a way to  store these kinds of data in the form of "key-value" pairs, commonly known as "data bags". A data bag is indexed for searching and can be loaded by a recipe or accessed during a search.
But, to store sensitive data such as DB passwords, API credentials, we need something more secure and that’s where ‘encrypted data bags’ come in to picture. Encrypted data bags use the same RSA asymmetric key pairs that chef uses to authenticate clients over the API. The server stores the clients' public keys and they are used to encrypt the data bag contents, which can only be decrypted by the appropriate private key. 
The secrets are encrypted this way but are available only to those users/machines that have the decryption key. This is a major issue, because sometimes the key is misplaced or not available when needed on a particular machine which breaks the chef and hence the purpose gets defeated. Also, having a single key leaves the infrastructure vulnerable as an attacker has all the data if they get the key. Moreover, the access to encrypted data is not always logged, so if there is any sort of intrusion, it is not known what data has been accessed and by whom.
<br /><br />
To solve this problem, there is a new entrant in this space called **Vault**. It is a tool built exclusively for storing and accessing the secrets. It is easy to configure and use. It is an independent tool not tied to a specific configuration management tool. It provides a command line tool to read, write and delete secrets from the vault server. It also provides an HTTP API which makes vault easier to access from any application.
<br /><br />
Vault can be configured to store data in a file, AWS S3, MySQL, etc. It eliminates the single key vulnerability by using multiple keys for encrypting the secrets. So, an attacker cannot access the secrets stored in the vault unless they have a particular number of those multiple keys. Vault stores a detailed audit log of every interaction. 
<br /><br />
Hence, Vault solves the basic problem of storing secrets in a well thought manner. For further documentation, refer [http://vaultproject.io](http://vaultproject.io)
