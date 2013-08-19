#
# == Author
#   Dolf Schimmel - Freeaqingme <dolf@enrise.com/>
#
define bind::zone::exported (
  $zone_name = undefined,
  $horizon = '',
  $type      = 'master',
  $magic_tag = undefined,
) {

  if $zone_name != undefined {
    $use_zone_name = $zone_name
  } else {
    $use_zone_name = $name
  }

  @@::bind::zone { "${::fqdn}_${horizon}_${use_zone_name}":
    zone_name=> $use_zone_name,
    horizon  => $horizon,
    tag      => $magic_tag,
  }

}
