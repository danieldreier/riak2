# == Class: riak2
#
# Full description of class riak2 here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class riak2 (
  $package_name = $::riak2::params::package_name,
  $service_name = $::riak2::params::service_name,
) inherits ::riak2::params {

  # validate parameters here

  class { '::riak2::repository': } ->
  class { '::riak2::install': } ->
  class { '::riak2::config': } ~>
  class { '::riak2::service': } ->
  Class['::riak2']
}
