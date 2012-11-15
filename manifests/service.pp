# == Class: mongodb::service
#
# Manage the mongodb service.
#
# === Parameters
#
# servicename     - The service name, if other than $mongodb::params::service.
# service_ensure (default: running) - Ensure service is running or stopped.
# service_enable (default: true) - Enable service at boot or not.
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
  $servicename     = $mongodb::params::service,
  $service_ensure  = 'running',
  $service_enable  = true,
  ) inherits mongodb::params {
  service { 'mongodb':
    ensure    => $service_ensure,
    name      => $servicename,
    enable    => $service_enable,
    subscribe => File[$mongodb::params::config],
  }
}
