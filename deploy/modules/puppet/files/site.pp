node default {
  $sleep = fqdn_rand(60)

  notify{"Sleeping for ${sleep} seconds": } ->
  exec{"/bin/sleep ${sleep}": }
}

