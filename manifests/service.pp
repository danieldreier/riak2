# == Class riak2::service
#
# This class is meant to be called from riak2.
# It ensure the service is running.
#
class riak2::service {

  service { $::riak2::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
