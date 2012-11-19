# == Class: mongodb::sources::apt
#
# Configure apt location configuration and PGP keys for Debian derivatives.
class mongodb::sources::apt(
  $location        = hiera('mongodb_location', undef),
  ) {
  include apt
  $mongodb_locations = hiera('mongodb_locations', undef)
  $mongodb_init      = hiera('mongodb_init',      undef)

  if $mongodb_location {
    $apt_location = $location
  } else {
    $apt_location = $mongodb_locations[$mongodb_init]
  }

  apt::source { '10gen':
    location    => $apt_location,
    release     => 'dist',
    repos       => '10gen',
    key         => '7F0CEB10',
    key_server  => 'keyserver.ubuntu.com',
    include_src => false,
  }
}
