class roles::puppetserver {
  service {'ufw':
    ensure => stopped,
    enable => false,
  }

  class {"puppet": } ->
  class {"puppet::master": }
}
