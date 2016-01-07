class roles::loadbalancer_primary {
  include profile::firewall
  include profile::haproxy
  include profile::masterkeepalived
}
