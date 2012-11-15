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
# packagename (auto discovered) - Override the package name
# servicename (auto discovered) - Override the service name
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
  $enable_10gen    = false,
  $init            = $mongodb::params::init,
  $location        = '',
  $packagename     = undef,
  $servicename     = $mongodb::params::service,
  $service_ensure  = 'running',
  $service_enable  = true,
  $logpath         = $mongodb::params::logpath,
  $logappend       = true,
  $mongofork       = true,
  $bind_ip         = undef,
  $port            = '27017',
  $dbpath          = $mongodb::params::dbpath,
  $nojournal       = undef,
  $smallfiles      = undef,
  $cpu             = undef,
  $noauth          = undef,
  $auth            = undef,
  $verbose         = undef,
  $objcheck        = undef,
  $quota           = undef,
  $oplog           = undef,
  $nohints         = undef,
  $nohttpinterface = undef,
  $noscripting     = undef,
  $notablescan     = undef,
  $noprealloc      = undef,
  $nssize          = undef,
  $mms_token       = undef,
  $mms_name        = undef,
  $mms_interval    = undef,
  $replset         = undef,
  $slave           = undef,
  $only            = undef,
  $master          = undef,
  $source          = undef,
  $directoryperdb  = undef,
  $replSet         = undef,
  $rest            = undef,
) inherits mongodb::params {
  class {
    'mongodb::packages':
      enable_10gen => $enable_10gen,
      packagename  => $packagename;

    'mongodb::config':
      logpath         => $logpath,
      logappend       => $logappend,
      mongofork       => $mongofork,
      bind_ip         => $bind_ip,
      port            => $port,
      dbpath          => $dbpath,
      nojournal       => $nojournal,
      smallfiles      => $smallfiles,
      cpu             => $cpu,
      noauth          => $noauth,
      auth            => $auth,
      verbose         => $verbose,
      objcheck        => $objcheck,
      quota           => $quota,
      oplog           => $oplog,
      nohints         => $nohints,
      nohttpinterface => $nohttpinterface,
      noscripting     => $noscripting,
      notablescan     => $notablescan,
      noprealloc      => $noprealloc,
      nssize          => $nssize,
      mms_token       => $mms_token,
      mms_name        => $mms_name,
      mms_interval    => $mms_interval,
      replset         => $replset,
      slave           => $slave,
      only            => $only,
      master          => $master,
      source          => $source,
      directoryperdb  => $directoryperdb,
      replSet         => $replSet,
      rest            => $rest;

    'mongodb::service':
      servicename     => $servicename,
      service_ensure  => $service_ensure,
      service_enable  => $service_enable;
  }
  Class['mongodb::packages'] -> Class['mongodb::config']
  Class['mongodb::config']   -> Class['mongodb::service']
}
