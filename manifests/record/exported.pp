# = Type: record::exported
#
# This type is not meant to be invoked directly and is subject to change.
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
# [*class*]
#   The class of the record. Defaults to 'IN'. Other values are HS and CH.
#
# [*horizon*]
#   The horizon of the zone to add this record to, for split-horizon setups.
#   Currently not yet supported.
#
# == Examples
#
# This type is not meant to be invoked directly and is subject to change.
#
# == Author
#   Dolf Schimmel - Freeaqingme <dolf@enrise.com/>
#
define bind::record::exported (
  $zone,
  $target,
  $label,
  $type,
  $order,
  $rr_class,
  $horizon,
) {

  concat::fragment{ "puppet_bind_${name}":
    target  => "/var/lib/puppet/bind/zones/db.${zone}-${horizon}",
    order   => $order,
    content => "${label}\t\t ${rr_class}\t ${type}\t ${target}\n",
    require => File['/var/lib/puppet/bind/zones'],
  }
  

}
