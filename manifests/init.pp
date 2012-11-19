# == Class: mongodb
#
# Manage mongodb installations on RHEL, CentOS, Debian and Ubuntu - either
# installing from the 10Gen repo or from EPEL in the case of EL systems.
#
# === Parameters
#
# enable_10gen (default: false) - Configure 10gen software repositories
# init (auto discovered) - Override init method for Debian derivatives
# location - Override apt location configuration for Debian derivatives
# package_name (auto discovered) - Override the package name
# service_name (auto discovered) - Override the service name
# service_enable (default: true)- Enable the service and ensure it is running
#
# === Examples
#
# To install with defaults from the distribution packages on any system:
#   include mongodb
#
# To install from 10gen on a EL server
#   class { 'mongodb':
#     enable_10gen => true,
#   }
#
# === Authors
#
# Craig Dunn <craig@craigdunn.org>
#
# === Copyright
#
# Copyright 2012 PuppetLabs
#
class mongodb (
  $enable_10gen    = hiera('mongodb_enable_10gen',     false),
  $init            = hiera('mongodb_init',             undef),
  $location        = hiera('mongodb_location',         undef),
  $package         = hiera('mongodb_package',          undef),
  $service_name    = hiera('mongodb_service_name',     'mongodb'),
  $service_ensure  = hiera('mongodb_service_ensure',   'running'),
  $service_enable  = hiera('mongodb_service_enable',   true),
  $config_hash     = hiera_hash('mongodb_config_hash', {'port'=>'27017'}),
  ) {
  class {
    'mongodb::packages':
      enable_10gen => $enable_10gen,
      package      => $package;

    'mongodb::config':
      config_hash => $config_hash;

    'mongodb::service':
      service_name    => $service_name,
      service_ensure  => $service_ensure,
      service_enable  => $service_enable;
  }
  Class['mongodb::packages'] -> Class['mongodb::config']
  Class['mongodb::config']   -> Class['mongodb::service']
}
