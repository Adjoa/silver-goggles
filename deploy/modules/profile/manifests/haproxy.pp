# Submitted by: Adjoa Darien
# Last updated: Dec-28-2015
# Configures a static implementation of HAProxy; an implementation that requires
# the details of each Apache web server be known in advance. 
class profile::haproxy ( 
  $haproxy_port = hiera('haproxy_port') 
){
  class { 'haproxy': }
  
  # Sets up a listening service configuration block (listen block) inside the 
  # /etc/haproxy/haproxy.cfg file on the HAProxy load balancer. A "listen" section
  # defines a complete proxy with its frontend and backend parts combined in one 
  # section. It is generally useful for TCP-only traffic.
  # - collected_exported setting indicates that Puppet's exported resources feature
  #   will not be used to collect information about the web servers being managed
  # - ipaddress setting defines the shared virtual IP address to be contacted by 
  #   clients and associated with the relevant web servers
  # - ports setting indicates which ports to listen on for the address specified in 
  #   ipaddress
  # - options setting indicates that, as dictated by the http mode, client requests 
  #   will be analyzed in depth before connecting to any server, any request which
  #   is not RFC-compliant will be rejected and layer 7 filtering, processing and 
  #   switching will be possible. 
  haproxy::listen { 'puppet00':
    collect_exported => false,
    ipaddress        => '10.80.15.109',
    ports            => "${haproxy_port}",
    options          => { 'mode' => 'http', },
  }

  # Each haproxy::balancermember definition describes a load-balanced member node.
  # The settings for each node will appear within a server declaration in haproxy.cfg
  # - listening_service setting associates the node with a listen block in haproxy.cfg
  # - option setting includes an array of options to be specified after the server
  #   declaration in the listen block and in this instance, the check option enables
  #   health checks on the server
  haproxy::balancermember { 'http1':
    listening_service => 'puppet00',
    server_names      => 'http1.example.haproxy',
    ipaddresses       => '10.80.15.101',
    ports             => $haproxy_port,
    options           => 'check',
  }

  haproxy::balancermember { 'http2':
    listening_service => 'puppet00',
    server_names      => 'http2.example.haproxy',
    ipaddresses       => '10.90.15.102',
    ports             =>  $haproxy_port,
    options           => 'check',
  }

  # Update the values in the /etc/sysctl.conf file
  # Enable IP forwarding
  sysctl::value { "net.ipv4.ip_forward": 
    value => "1", 
  }
  
  # Allow HAProxy to bind to the shared virtual IP address
  sysctl::value { "net.ipv4.ip_nonlocal_bind": 
    value => "1", 
  }

  firewall {'103 allow access to haproxy':
    dport  => $haproxy_port,
    proto  => tcp,
    action => accept,
  }
}
