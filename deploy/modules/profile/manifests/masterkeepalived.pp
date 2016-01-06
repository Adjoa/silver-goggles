# Submitted by: Adjoa Darien
# Last updated: Dec-22-2015
# Configures Keepalived (/etc/keepalived/keepalived.conf) to set up load 
# balancer nodes in an active-passive configuration with HTTP failover. 
class profile::masterkeepalived{
  include keepalived
  
  # Checks whether the haproxy service is running
  keepalived::vrrp::script { 'check_haproxy':
    script => 'killall -0 haproxy',
  }
  
  # Defines this load balancer as the MASTER in the active-passive configuration.
  # - unicast_peers parameter contains an array of IP addresses that correspond
  #   to the failover nodes.
  keepalived::vrrp::instance { 'VI_50':
    interface         => 'eth1',
    state             => 'MASTER',
    virtual_router_id => '50',
    priority          => '101',
    auth_type         => 'PASS',
    auth_pass         => 'secret',
    virtual_ipaddress => [ '10.80.15.109' ],
    track_interface   => ['eth1','tun0'], # optional, monitor these interfaces.
    track_script      => 'check_haproxy',  
    unicast_peers     => ['10.80.15.104', '10.80.15.109'],
  }
}
