class puppet::master {
  class{"puppet::master::install": } ->
  class{"puppet::master::config": } ~>
  class{"puppet::master::service": } ->
  Class[$name]
}
