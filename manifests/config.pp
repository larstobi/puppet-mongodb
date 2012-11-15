# == Class: mongodb::config
#
# Manage mongodb configuration.
#
# === Parameters
#
# logpath         - "Value for mongodb.conf template."
# logappend       - "Value for mongodb.conf template."
# mongofork       - "Value for mongodb.conf template."
# bind_ip         - "Value for mongodb.conf template."
# port            - "Value for mongodb.conf template."
# dbpath          - "Value for mongodb.conf template."
# nojournal       - "Value for mongodb.conf template."
# smallfiles      - "Value for mongodb.conf template."
# cpu             - "Value for mongodb.conf template."
# noauth          - "Value for mongodb.conf template."
# auth            - "Value for mongodb.conf template."
# verbose         - "Value for mongodb.conf template."
# objcheck        - "Value for mongodb.conf template."
# quota           - "Value for mongodb.conf template."
# oplog           - "Value for mongodb.conf template."
# nohints         - "Value for mongodb.conf template."
# nohttpinterface - "Value for mongodb.conf template."
# noscripting     - "Value for mongodb.conf template."
# notablescan     - "Value for mongodb.conf template."
# noprealloc      - "Value for mongodb.conf template."
# nssize          - "Value for mongodb.conf template."
# mms_token       - "Value for mongodb.conf template."
# mms_name        - "Value for mongodb.conf template."
# mms_interval    - "Value for mongodb.conf template."
# replset         - "Value for mongodb.conf template."
# slave           - "Value for mongodb.conf template."
# only            - "Value for mongodb.conf template."
# master          - "Value for mongodb.conf template."
# source          - "Value for mongodb.conf template."
# directoryperdb  - "Value for mongodb.conf template."
# replSet         - "Value for mongodb.conf template."
# rest            - "Value for mongodb.conf template."
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
