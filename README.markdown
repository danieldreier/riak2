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

[Riak](http://basho.com/riak/) is an open source, distributed database that
focuses on high availability, horizontal scalability, and *predictable*
latency.

This repository is **community supported**. We both appreciate and need your
contribution to keep it stable. For more on how to contribute,
[take a look at the contribution process](#contribution).

This module installs the apt or yum repository, installs riak, and starts the
riak service. This is a very basic module, and does not manage clusters, help
rotate logs, backups, etc. It only manages the riak.conf file, not
advanced.config (yet).

Thank you for being part of the community! We love you for it.

## Setup

### What riak2 affects

* This will install the basho apt or yum repository
* Your /etc/riak.conf file will be overwritten
* The riak system package will be installed, and the service started

### Setup Requirements

This module requires Puppet 3.7 and future parser. See the limitations section
for more details on supported platforms.

### Beginning with riak2

This module is not yet published on Puppet Forge, so you should install it
from the git repository using r10k.

## Usage

The most basic use case is to simply install riak with default settings:

```puppet
include ::riak2
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
  - currently-maintained versions of MRI ruby and jruby that are also supported by Puppet Labs. As of March 2015, this means 2.0.0 and 2.1.5. [2.2 won't be supported in the 3.x series](https://tickets.puppetlabs.com/browse/PUP-3796?focusedCommentId=154371&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-154371)
  - ruby 1.9.3 is tested because jruby runs in 1.9.3 mode. When Puppet supports jruby 1.7.4's ruby 2.0.0 support this will go away.

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

**warning**
The Riak RPMs distributed by Basho are [not GPG signed](https://github.com/basho/riak/issues/714). To work around this,
the module disabled GPG verification in that Yum repository. The apt packages
are signed, so this only applies to EL platforms.

## Development

Please contribute to this module. This module has extensive test coverage in
order to make contributing easier. Please read CONTRIBUTING.md for details.
