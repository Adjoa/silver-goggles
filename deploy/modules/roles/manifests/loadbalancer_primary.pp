class roles::loadbalancer_primary {
  include profile::firewall_default
  include profile::haproxy_lb
  include profile::masterkeepalived
}
