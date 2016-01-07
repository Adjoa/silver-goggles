class roles::loadbalancer_backup {
  include profile::firewall
  include profile::haproxy_lb
  include profile::backupkeepalived
}

