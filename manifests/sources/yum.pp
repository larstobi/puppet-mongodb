# == Class: mongodb::sources::yum
#
# Configure yum location configuration for Red Hat derivatives.
class mongodb::sources::yum {
  yumrepo { '10gen':
    baseurl   => hiera('mongodb_baseurl'),
    gpgcheck  => '0',
    enabled   => '1',
  }
}
