# == Class: mongodb::packages
#
# Manage mongodb package installations - either installing from the 10Gen repo
# or from EPEL in the case of EL systems.
#
# === Parameters
#
# enable_10gen (default: false) - Configure 10gen software repositories
# packagename (auto discovered) - Override the package name
#
# === Authors
#
# Craig Dunn <craig@craigdunn.org>
# Lars Tobias Skjong-Borsting <larstobi@conduct.no>
#
# === Copyright
#
# Copyright 2012 PuppetLabs
# Copyright 2012 Lars Tobias Skjong-Borsting <larstobi@conduct.no>
#
class mongodb::packages(
  $enable_10gen    = false,
  $packagename     = undef,
  $init            = $mongodb::params::init,
  ) inherits mongodb::params {
  if $enable_10gen {
    include $mongodb::params::source
    Class[$mongodb::params::source] -> Package[$mongodb::params::pkg_10gen]
  }

  if $packagename {
    $package = $packagename
  } elsif $enable_10gen {
    $package = $mongodb::params::pkg_10gen
  } else {
    $package = $mongodb::params::package
  }

  package { $package:
    ensure => installed,
  }
}
