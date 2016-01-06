node default {
  if $::hostname =~ /^http/ {
    $role = "webserver"
   }

  class{"roles::webserver": }

#  host {"puppet":
#    ip => $::middleware_ip,
#  }
}
