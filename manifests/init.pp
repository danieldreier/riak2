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
  $package_name   = $::riak2::params::package_name,
  $service_name   = $::riak2::params::service_name,
  $manage_package = $::riak2::params::manage_package,
  $manage_repo    = $::riak2::params::manage_repo,
  $version        = $::riak2::params::version,
  $settings       = {},
) inherits ::riak2::params {

  # basic input validation
  # when we switch to puppet 4 DSL we can use typed variables
  validate_string($package_name)
  validate_string($service_name)
  validate_bool($manage_package)
  validate_bool($manage_repo)
  validate_string($version)
  validate_hash($settings)

  if $manage_repo and $manage_package {
    include ::riak2::repository
  }
  if $manage_package {
    include ::riak2::install
    Package[$::riak2::package_name] ~> File[$::riak2::params::riak_conf]
  }
  class { '::riak2::config': } ~>
  class { '::riak2::service': } ->
  Class['::riak2']
}
