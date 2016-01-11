class roles::loadbalancer_backup {
  include profile::firewall_default
  include profile::haproxy_lb
  include profile::backupkeepalived
}

