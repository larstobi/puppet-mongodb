# == Class: mongodb::sources::yum
#
# Configure yum location configuration for Red Hat derivatives.
class mongodb::sources::yum inherits mongodb::params {
  yumrepo { '10gen':
    baseurl   => $mongodb::params::baseurl,
    gpgcheck  => '0',
    enabled   => '1',
  }
}
