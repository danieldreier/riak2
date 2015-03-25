# == Class riak2::repository
#
# This class selects a package repository to install
#
class riak2::repository {

  case $::osfamily {
    'Redhat': { include riak2::repository::el }
    'Debian': { include riak2::repository::debian }
    default: { fail("No package repository is available for ${::osfamily}") }
  }

}
