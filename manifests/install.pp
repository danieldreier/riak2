# == Class riak2::install
#
# This class is called from riak2 for install.
#
class riak2::install {

  package { $::riak2::package_name:
    ensure => present,
  }
}
