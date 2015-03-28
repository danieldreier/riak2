## Don't use this module. It's still in development.
[![Build Status](https://travis-ci.org/danieldreier/riak2.svg?branch=master)](https://travis-ci.org/danieldreier/riak2)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with riak2](#setup)
    * [What riak2 affects](#what-riak2-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with riak2](#beginning-with-riak2)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages the 2.x versions of the Riak distributed key-value store.

## Module Description

This module installs the apt or yum repository, installs riak, and starts the
riak service. This is a very basic module, and does not manage clusters, help
rotate logs, backups, etc. It only manages the riak.conf file, not 
advanced.config (yet). 

## Setup

### What riak2 affects

* This will install the basho apt or yum repository
* Your /etc/riak.conf file will be overwritten
* 

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled, etc.), mention it here. 

### Beginning with riak2

The very basic steps needed for a user to get the module up and running. 

If your most recent release breaks compatibility or requires particular steps for upgrading, you may wish to include an additional section here: Upgrading (For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

The most basic use case is to simply install riak with default settings:

```puppet
include ::riak
```

A slightly more interesting configuration will look something like the
following, which has some defaults included for the sake of documentation.

```puppet
class { '::riak2':
  package_name   => 'riak',   # default
  service_name   => 'riak',   # default
  manage_package => true,     # default
  manage_repo    => true,     # default
  version        => 'latest', # default, use a package version if desired
  # settings in the settings hash are written directly to settings.conf.
  settings       => {
    'log.syslog'                              => 'on',
    'erlang.schedulers.force_wakeup_interval' => '500',
    'erlang.schedulers.compaction_of_load'    => false,
    'buckets.default.last_write_wins'         => true,
  },
}
```

## Limitations

This module is only expected to work with:

  - Puppet 3.7 and newer
  - needs future parser enabled
  - needs structured facts enabled
  - currently-maintained versions of MRI ruby and jruby. As of March 2015, this means 2.0.0, 2.1.5, or 2.2.1.

Although some functionality may work without all of those, you shouldn't
count on it to continue working.

This module has been tested with Puppet 3.7 on Debian Wheezy, Ubuntu 12.04,
Ubuntu 14.04, CentOS 6, and CentOS 7 using Beaker integration tests. However,
there is no ongoing Beaker CI coverage, so only tagged releases have been tested
using Beaker.

A few caveats:

- advanced.config is not managed
- log rotation is not managed
- the module doesn't help you make backups
- module doesn't validate configuration settings at all


## Development

Please contribute to this module. This module has extensive test coverage in
order to make contributing easier. Please read CONTRIBUTING.md for details.
