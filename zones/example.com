#
# This is the input for the zone "example.com".
#
# You'll notice that each record in this file is fully-qualified,
# that is the suffix "example.com" is present, in addition to being
# part of the filename.
#
# The other example file, "example.net", uses unqualified records
# with the zone being correctly inferred by the filename.
#
# I tend to think that being explicit is good, but there are situations
# where you might want to use symlinks and copies to make multiple
# zones have identical records, so for that purpose unqualfied records
# are simpler.
#

#
# An MX record will ensure that all mail sent to @example.com will
# be delivered to the host `mail.example.com`.
#
@example.com:mail.example.com:15:3600

#
# Now we define the IPv4 & IPv6 address for `mail.example.com`.
#
+mail.example.com:80.68.84.102:3600
6mail.example.com:200141c8010b01020000000000000010:3600

#
# Finally define a CNAME to allow easier use for users, as
# http://webmail.example.com/ is more memorable than http://mail.example.com/
#
Cwebmail.example.com:mail.example.com:3600

#
# We can define an SPF record to avoid mail-spoofing:
#
Texample.com:"v=spf1 mx a ptr ~all":3600

#
# Now we define the IPv4 addresses for the website
#
+example.com:80.68.84.111:3600
+www.example.com:80.68.84.111:3600

#
# And again, for IPv6.
#
6example.com:200141c8010b01030000000000000111:3600
6www.example.com:200141c8010b01030000000000000111:3600


#
#  SRV records which lets clients know that graphite submissions should go to:
#
#    graphite.docker.example.com:2003
#
#  This record is repeated for both UDP and TCP.
#
#  3600 is the TTL in seconds (one hour) and is optional
#
_graphite._udp.example.com:graphite.docker.example.com:2003:3600
_graphite._tcp.example.com:graphite.docker.example.com:2003:3600


#
#  Finally we support the processing of CAA records
# via the "!" prefix.
#
#  CAA records have an integer, a key, and a value
# the value will be quoted if there are no quotes
# present.
#
#  Supported keys are "issue", "issuewild", and "iodef".
#
!example.com:0:issue:letsencrypt.org
!secret.example.com:0:issue:"comodoca.com"

