# == Class riak2::repository::debian
#
# Install the correct package repository for Debian
#
class riak2::repository::debian {
  ensure_packages('apt-transport-https') # packagecloud is https-only
  include ::apt
  apt::source { 'riak':
    location   => 'https://packagecloud.io/basho/riak/debian/',
    key        => '418A7F2FB0E1E6E7EABF6FE8C2E73424D59097AB',
    key_source => 'https://packagecloud.io/gpg.key',
    pin        => '550',
    repos      => 'main',
    release    => $::lsbdistcodename,
    before     => Package[$::riak2::package_name],
    require    => Package['apt-transport-https'],
  }
}
