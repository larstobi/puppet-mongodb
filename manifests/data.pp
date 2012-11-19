# == Class: mongodb::data
#
# Default values for Hiera data lookup for the mongodb class.
class mongodb::data {
  $mongodb_enable_10gen = true
  case $::operatingsystem {
    'centos', 'redhat', 'oel', 'Amazon': {
      $mongodb_baseurl = "http://downloads-distro.mongodb.org/repo/redhat/os/${::architecture}"
      $mongodb_source         = 'mongodb::sources::yum'
      $mongodb_package        = 'mongodb-server'
      $mongodb_pkg_10gen      = 'mongo-10gen-server'
      $mongodb_config_file    = '/etc/mongodb.conf'
      $mongodb_service_name   = 'mongod'
      $mongodb_logrotate_file = '/etc/logrotate.d/mongod'
      $dbpath                 = '/var/lib/mongodb'
      $logpath                = '/var/log/mongodb/mongodb.log'
    }
    'debian', 'ubuntu': {
      $mongodb_locations = {
        'sysv'    => 'http://downloads-distro.mongodb.org/repo/debian-sysvinit',
        'upstart' => 'http://downloads-distro.mongodb.org/repo/ubuntu-upstart'
      }
      case $::operatingsystem {
        'debian':  { $mongodb_init = 'sysv' }
        'ubuntu':  { $mongodb_init = 'upstart' }
        default:   { $mongodb_init = 'sysv' }
      }
      $mongodb_logrotate_file = '/etc/logrotate.d/mongodb-server'
      $dbpath                 = '/var/lib/mongodb'
      $logpath                = '/var/log/mongodb/mongodb.log'
      $mongodb_source         = 'mongodb::sources::apt'
      $mongodb_package        = 'mongodb'
      $mongodb_pkg_10gen      = 'mongodb-10gen'
      $mongodb_config_file    = '/etc/mongodb.conf'
    }
    default: {
      fail("mongodb: ${::operatingsystem} is not supported.")
    }
  }

  $mongodb_config_hash = {'port'=>'27017'}
  # Default values for the mongodb.conf template.
  $mongodb_default_conf = {
    'auth'            => undef,
    'bind_ip'         => undef,
    'cpu'             => undef,
    'dbpath'          => $dbpath,
    'directoryperdb'  => undef,
    'fork'            => undef, # Note: service status may break if true.
    'logappend'       => true,
    'logpath'         => $logpath,
    'master'          => undef,
    'mms_interval'    => undef,
    'mms_name'        => undef,
    'mms_token'       => undef,
    'noauth'          => undef,
    'nohints'         => undef,
    'nohttpinterface' => undef,
    'nojournal'       => undef,
    'noprealloc'      => undef,
    'noscripting'     => undef,
    'notablescan'     => undef,
    'nssize'          => undef,
    'objcheck'        => undef,
    'only'            => undef,
    'oplog'           => undef,
    'port'            => '27017',
    'quota'           => undef,
    'replSet'         => undef,
    'rest'            => undef,
    'slave'           => undef,
    'smallfiles'      => undef,
    'source'          => undef,
    'verbose'         => undef,
  }
}
