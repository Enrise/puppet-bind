# = Type: record
#
# Adds a bind record identified by $name ($label) to the given $zone file
#
# == Parameters
#
# Module specific parameters
#
# [*zone*]
#   The zone to add this record to
#
# [*label*]
#   The label of the record
#
# [*type*]
#   The type of the record (e.g. A, CNAME, TXT, etc)
#
# [*order*]
#   The location of the record as it is ordered by the $order param
#
# [*rr_class*]
#   The class of the record. Defaults to 'IN'. Other values are HS and CH.
#
# [*horizon*]
#   The horizon of the zone to add this record to, for split-horizon setups.
#   Currently not yet supported.
#
# == Examples
#
# Basic example
#
# Usage:
# @@bind9::record { 'foobar':
#   zone: 'example.com',
#   target: '94.142.241.111'
# }
#
# Now you can type: telnet foobar.example.com
#
#
# == Author
#   Dolf Schimmel - Freeaqingme <dolf@enrise.com/>
#
define bind::record(
  $zone,
  $target,
  $label     = undefined,
  $type      = 'AAAA',
  $order     = 100,
  $rr_class     = 'IN',
  $horizon   = '',
  $magic_tag = undefined
) {

  if $label != undefined {
    $use_label = $label
  } else {
    $use_label = $name
  }

  @@::bind::record::exported { "${::fqdn}_${name}":
    zone      => $zone,
    target    => $target,
    label     => $use_label,
    type      => $type,
    order     => $order,
    rr_class  => $rr_class,
    horizon   => $horizon,
    tag       => $magic_tag,
  }

}
