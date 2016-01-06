class role::webserver {
  include profile::firewall
  include profile::apache_vhost
}
