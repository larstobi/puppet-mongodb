# == Class: mongodb::params
#
# Default parameters for the mongodb class.
class mongodb::params{
  case $::operatingsystem {
    'centos', 'redhat', 'oel', 'Amazon': {
      $baseurl   = "http://downloads-distro.mongodb.org/repo/redhat/os/${::architecture}"
      $source    = 'mongodb::sources::yum'
      $package   = 'mongodb-server'
      $service   = 'mongod'
      $pkg_10gen = 'mongo-10gen-server'
      $dbpath    = '/var/lib/mongodb'
      $logpath   = '/var/log/mongodb/mongodb.log'
      $config    = '/etc/mongodb.conf'
    }
    'debian', 'ubuntu': {
      $locations = {
        'sysv'    => 'http://downloads-distro.mongodb.org/repo/debian-sysvinit',
        'upstart' => 'http://downloads-distro.mongodb.org/repo/ubuntu-upstart'
      }
      case $::operatingsystem {
        'debian':  { $init = 'sysv' }
        'ubuntu':  { $init = 'upstart' }
        default:   { $init = 'sysv' }
      }
      $source    = 'mongodb::sources::apt'
      $package   = 'mongodb'
      $service   = 'mongodb'
      $pkg_10gen = 'mongodb-10gen'
      $dbpath    = '/var/lib/mongo'
      $logpath   = '/var/log/mongo/mongod.log'
      $config    = '/etc/mongodb.conf'
    }
    default: {
      fail ("mongodb: ${::operatingsystem} is not supported.")
    }
  }

  # Default values for the mongodb.conf template.
  $default_conf = {
    'auth'            => undef,
    'bind_ip'         => undef,
    'cpu'             => undef,
    'dbpath'          => $dbpath,
    'directoryperdb'  => undef,
    'fork'            => undef,
    'logappend'       => true,
    'logpath'         => $logpath,
    'master'          => undef,
    'mms_interval'    => undef,
    'mms_name'        => undef,
    'mms_token'       => undef,
    'mongofork'       => true,
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
