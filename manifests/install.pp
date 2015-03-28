# == Class riak2::install
#
# This class is called from riak2 for install.
#
class riak2::install {
  ensure_packages(['sudo'])
  package { $::riak2::package_name:
    ensure => $::riak2::version,
    before => Service[$::riak2::service_name],
  }
}
