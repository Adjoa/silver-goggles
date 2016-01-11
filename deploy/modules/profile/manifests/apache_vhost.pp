# Submitted by: Adjoa Darien
# Last updated: Dec-28-2015
# Defines a virtual host and prepares the web server to communicate with a
# transparent HAProxy server.
class profile::apache_vhost (
  $apache_port = '7267'
){
  # default_vhost setting allows for the creation of customized Apache virtual hosts
  # log_formats setting instructs the web server to log the ip address of the requesting
  # client (instead of the proxy's ip address) which is being passed to it from the HTTP
  # header field %{X-Forwarded-For}i
  class { 'apache':
    default_vhost => false,
    log_formats   => {
      combined => '%{X-Forwarded-For}i %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"'},
  }

  # HAProxy will regularly check on the server's health by requesting the file check.txt
  file { "${::apache::params::docroot}/check.txt":
     ensure  => present,
     require => Class['apache'] 
  }

  # Configures a name-based virtual host with the hostname first.example.com and,
  # instructs the server not to log requests for the file check.txt
  apache::vhost { 'first.example.com':
    port               => $apache_port,
    docroot            => "${::apache::params::docroot}/first.example.com",
    access_log_format  => 'combined',
    access_log_env_var => "!dontlog",
    setenvif           => ['Request_URI "^/check\.txt$" dontlog',],
  }

  file {"${::apache::params::docroot}/first.example.com/default.html":
    ensure  => present,
    source  => "puppet:///modules/profile/default.html",
    require => Apache::Vhost['first.example.com'],
  }

  firewall {'102 allow access to apache':
    dport  => [$apache_port],
    proto  => tcp,
    action => accept,
 }
}
