class role::loadbalancer_backup {
  include profile::firewall
  include profile::haproxy
  include profile::backupkeepalived
}

