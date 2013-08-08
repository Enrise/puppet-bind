#
# == Author
#   Dolf Schimmel - Freeaqingme <dolf@enrise.com/>
#
define bind::zone (
  $reverse                 = false,
  $zone_name               = undefined,
  $horizon                 = '',
  $type                    = 'master',
  $zone_header_template    = $bind::zone_header_template,
  $managing_contact        = $bind::managing_contact,
  $nameservers             = $bind::nameservers,
  $custom_zonefile_content = $bind::custom_zonefile_content,
) {
  
  if $horizon != '' {
    fail('Use of split-view horizons is not supported yet')
  }
  
  if $type != 'master' {
    fail('Use of slaves or dynamic updates is not supported yet')
  }

  if $zone_name != undefined {
    $use_zone_name = $zone_name
  } else {
    $use_zone_name = $name
  }

  if $horizon != '' {
    $horizon_suffix = "-${horizon}"
  } else {
    $horizon_suffix = ''
  }

  if $type == 'master' {
    $path = "${bind::zone_master_dir}/db.${use_zone_name}${horizon_suffix}"
  } else {
    # todo
  }

  unless $reverse {
    ::bind::record { "${use_zone_name}_localhost-A":
      label  => 'localhost',
      zone   => $use_zone_name,
      type   => 'A',
      target => '127.0.0.1'
    }
  
    ::bind::record { "${use_zone_name}_localhost-AAAA":
      zone   => $use_zone_name,
      label  => 'localhost',
      type   => 'AAAA',
      target => '::1'
    }
  }
  
  if $type == 'master' {
    
    concat::fragment{ "puppet_zones_master-${name}":
      target  => "${bind::config_file}.options",
      order   => 10,
      content => template('bind/options.conf_master_fragment.erb'),
      require => File['/var/lib/puppet/bind/zones'],
    }

  }

  concat::fragment{ "puppet_zone_${name}-${horizon}":
    target  => "/var/lib/puppet/bind/zones/db.${use_zone_name}-${horizon}",
    order   => 1000, # Allows to prepend the zone file - with something
    content => template($zone_header_template),
    require => File['/var/lib/puppet/bind/zones'],
  }
  
  if $custom_zonefile_content != '' {
    concat::fragment{ "puppet_zone_${name}-${horizon}-custom":
      target  => "/var/lib/puppet/bind/zones/db.${use_zone_name}-${horizon}",
      order   => 2500, # Allows to prepend the zone file - with something
      content => $custom_zonefile_content,
      require => File['/var/lib/puppet/bind/zones'],
    }
  }
  

  concat{ "/var/lib/puppet/bind/zones/db.${use_zone_name}-${horizon}":
    owner => root,
    group => root,
    mode  => '0644',
  }
  
  
  file { $path:
    require => File[ "/var/lib/puppet/bind/zones/db.${use_zone_name}-${horizon}" ],
    source => "file:///var/lib/puppet/bind/zones/db.${use_zone_name}-${horizon}",
    notify => Service['bind'],
  }

}
