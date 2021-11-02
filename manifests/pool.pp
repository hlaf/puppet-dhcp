# == Define: dhcp::pool
#
define dhcp::pool (
  $network,
  $mask,
  $gateway          = '',
  $range            = '',
  $failover         = '',
  $options          = '',
  $parameters       = '',
  $nameservers      = undef,
  $nameservers_ipv6 = undef,
  $pxeserver        = undef,
  $mtu              = undef,
  $domain_name      = '',
  $ignore_unknown   = undef,
  $allow_classes    = undef,
  $deny_classes     = undef,    
) {
  if $mtu {
    validate_integer($mtu)
  }

  include ::dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_pool_${name}":
    target  => "${dhcp_dir}/dhcpd.pools",
    content => template('dhcp/dhcpd.pool.erb'),
  }
}
