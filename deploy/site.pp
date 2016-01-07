node default {
  if $::hostname =~ /^http/ {
    $role = "webserver"
   }
  elsif $::hostname =~ /^lb1/ {
    $role = "loadbalancer_primary"
  }
  elsif $::hostname =~ /^lb2/ {
    $role = "loadbalancer_backup"
  }

  class{"roles::${role}": }

#  host {"puppet":
#    ip => $::middleware_ip,
#  }
}
