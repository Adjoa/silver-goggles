class roles::webserver {
  include profile::firewall
  include profile::apache_vhost
}
