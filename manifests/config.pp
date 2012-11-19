# == Class: mongodb::config
#
# Manage mongodb configuration.
#
# === Parameters
#
# conf_hash - Configuration hash for the mongodb.conf template.
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
class mongodb::config(
  $config_hash    = hiera_hash('mongodb_config_hash', {'port'=>'27017'}),
  $config_file    = hiera('mongodb_config_file', '/etc/mongodb.conf'),
  $logrotate_file = hiera('mongodb_logrotate_file')
  ) {
  $conf = merge(hiera_hash('mongodb_default_conf'), $config_hash)

  file { $config_file:
    content => template('mongodb/mongodb.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { $logrotate_file:
    content => template('mongodb/logrotate.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
