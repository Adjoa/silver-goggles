class roles::loadbalancer_primary {
  include profile::firewall
  include profile::haproxy_lb
  include profile::masterkeepalived
}
