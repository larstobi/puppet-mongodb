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
  $config_hash = {},
  ) inherits mongodb::params {
  $conf = merge($mongodb::params::default_conf, $config_hash)

  file { $mongodb::params::config:
    content => template('mongodb/mongod.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/logrotate.d/mongod':
    content => template('mongodb/logrotate.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
