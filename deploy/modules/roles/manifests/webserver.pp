class roles::webserver {
  include profile::firewall_default
  include profile::apache_vhost
}
