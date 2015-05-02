# squeezecenter
#
#   Install and start the Logitech Media Server software.  This software has
#   occasionally been known as 'Squeezecenter' and such, and is no longer being
#   supported by Logitech; but it still has working Debian repositories.
#
#   This actually uses mysql somewhere on the back-end, but we're not getting
#   that far into its configuration yet.
#
#   Firewall configuration should be handled on your own; you want at least
#   3483 (tcp + udp) and 9000 (tcp) to the appropriate networks.
#
# == Parameters
#
#   repo      Location of the Debian repo.
#   release   stable, unstable, or testing
#
# == Requirements
#
#   apt       https://forge.puppetlabs.com/puppetlabs/apt
#
class squeezecenter (
  $repo    = 'http://debian.slimdevices.com',
  $release = 'stable'
) {
  apt::source { 'squeezecenter':
    include  => { 'src' => false, 'deb' => true },
    location => $repo,
    release  => $release
  }

  package { 'logitechmediaserver':
    ensure  => installed,
    require => Apt::Source['squeezecenter']
  }

  service { 'logitechmediaserver':
    hasstatus => false,
    status    => 'pidof -x squeezeboxserver_safe',
    require   => Package['logitechmediaserver']
  }
}
