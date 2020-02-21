
About
=====

This repository is an example used to demonstrate the [`git`-based DNS hosting service](http://dns-api.com/), which allows you to maintain your DNS records in a `git` repository.

If you have a [dns-api](https://dns-api.com/) account you'll be given a `git` repository which you can use to make changes to hosted domains:

* You can either use the provided git repository exclusively, cloning it, committing changes, and pushing them back to it.
* Or you might prefer to host your repository on [github](http://github.com/), [bitbucket](http://bitbucket.org/), or even internally, and add the hosted-repository as a `git-remote`.

On the back-end your DNS is handled by Amazon's route53 infrastructure, giving you diverse, replicated, and highly-available DNS hosting.


Configuration
-------------

Regardless of where you host your DNS-data the moment you push to the hosted repository a hook will fire, which will trigger updating your DNS records.

There is no need to configure a webhook, confirm any integration, or deal with anything complicated:

* You push your DNS repository.
* Your DNS records are updated.

The only thing you need to do is create one file for each domain you wish hosted, beneath the top-level `zones/` directory.  Each file there will be scanned for DNS records, when the push event is triggered.


Zone Format
-----------

When a push-event is received the remote service will initiate a scan of each file beneath the `zones/` directory - and each zone there will be added to DNS.  The files __must__ be named after the zone they represent, to allow domains to be identified cleanly.

The zone-format is a simplified version of the [TinyDNS format](http://cr.yp.to/djbdns/tinydns-data.html), which allows you to define records in a simple line-based fashion:


* Lines prefixed with "`#`" are comments, which are ignored.
* Lines prefixed with "`+`" are A records.
* Lines prefixed with "`6`" are IPv6 records.
* Lines prefixed with "`@`" are MX records.
* Lines prefixed with "`C`" are CNAME records.
* Lines prefixed with "`T`" are TXT records.
* Lines prefixed with "`_`" are SRV records.
* Lines prefixed with "`!`" are CAA records.

The general form of each line is "`type : name : value : TTL`", and the two sample files should provide useful reference.

There is a simple online [DNS wizard](https://dns-api.com/docs/wizard/) which will allow you to generate a basic zonefile, covering the most basic cases.

Feel free to [get in touch](http://dns-api.com/docs/help) if you have queries, comments, or problems.


Testing
-------

If you're unsure about how your record(s) will be parsed you're welcome to test them online, via the zone-tester:

* [DNS-Record Parser](https://dns-api.com/parse/)

Otherwise you can use [the OpenSource module we published](https://github.com/DNS-API/tinydns--reader), which will allow you to validate the records locally.

> **NOTE**: Don't worry about the record format too much, it is unlikely you'll need to validate records once you've studied the examples.

Feedback
--------

We welcome suggestions for additional record-types to support, or other comments.  Just [drop us a mail](https://dns-api.com/docs/help).
