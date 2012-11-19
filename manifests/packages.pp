# == Class: mongodb::packages
#
# Manage mongodb package installations - either installing from the 10Gen repo
# or from EPEL in the case of EL systems.
#
# === Parameters
#
# enable_10gen (default: false) - Configure 10gen software repositories
# package_name (auto discovered) - Override the package name
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
  $enable_10gen    = hiera('mongodb_enable_10gen', false),
  $init            = hiera('mongodb_init',         undef),
  $package         = hiera('mongodb_package',      'mongodb'),
  $location        = hiera('mongodb_location',     undef),
  ) {
  if $enable_10gen {
    $mongodb_source = hiera('mongodb_source')
    $pkg_10gen      = hiera('mongodb_pkg_10gen')
    $package_name   = $pkg_10gen
    class { $mongodb_source: location => $location; }
    Class[$mongodb_source] -> Package[$mongodb_pkg_10gen]
  } else {
    $package_name = $package
  }

  package { $package_name:
    ensure => installed,
  }
}
