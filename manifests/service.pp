# == Class: mongodb::service
#
# Manage the mongodb service.
#
# === Parameters
#
# service_name   (default: mongodb) - The service name.
# service_ensure (default: running) - Ensure service is running or stopped.
# service_enable (default: true)    - Enable service at boot or not.
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
class mongodb::service (
  $service_name   = hiera('mongodb_service_name',   'mongodb'),
  $service_ensure = hiera('mongodb_service_ensure', 'running'),
  $service_enable = hiera('mongodb_service_enable', true),
  ) {
  service { $service_name:
    ensure    => $service_ensure,
    enable    => $service_enable,
    subscribe => Class['mongodb::config'],
  }
}
