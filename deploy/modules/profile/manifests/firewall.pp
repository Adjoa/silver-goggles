# Submitted by: Adjoa Darien
# Last updated: Dec-28-2015
# Defines the default firewall settings
class profile::firewall{
   firewall { '101 allow access to http, https and, puppet services':
     dport   => [80, 443, 61613, 8140],
     proto  => tcp,
     action => accept,
  }
}
