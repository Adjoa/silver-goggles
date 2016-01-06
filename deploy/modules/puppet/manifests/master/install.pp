class puppet::master::install {
  package {'puppetmaster':
    ensure => latest,
  }
}
