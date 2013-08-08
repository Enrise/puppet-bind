# Class: bind::params
#
# This class defines default parameters used by the main module class bind
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to bind class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class bind::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'bind9',
  }

  $service = $::operatingsystem ? {
    default => 'bind9',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'bind',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'bind',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/bind',
  }

  # Based on Debian's standards.
  # "we suggest is that you put the db files for any zones you are master for
  # in /etc/bind [...], using full pathnames in the named.conf file."
  $zone_master_dir = $::operatingsystem ? {
    default => '/etc/bind',
  }

  # Based on Debian's standards. Could be changed for other distro's.
  # "The working directory for named is now /var/cache/bind.  Thus, any
  # transient files generated by named, such as database files for zones the
  # daemon is secondary for, will be written to the /var filesystem, where
  # they belong."
  $zone_secondary_dir = $::operatingsystem ? {
    default => '/var/cache/bind',
  }

  # Based on Debian's standards. Could be changed for other distro's.
  # "Zones subject to automatic updates (such as via DHCP and/or nsupdate)
  # should be stored in /var/lib/bind, and specified with full pathnames."
  $zone_dynamic_dir = $::operatingsystem ? {
    default => '/var/lib/bind',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/bind/named.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/bind',
    default                      => '/etc/sysconfig/bind',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/named/named.pid',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/bind',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/bind/bind.log',
  }

  $rfc1912_zone_file = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/etc/named.rfc1912.zones',
    default                           => '/etc/bind/named.conf.default-zones',
  }

  $port = '53'
  $enable_tcp = true
  $enable_udp = true
  
  $acl_recursion_subnets = [ '127.0.0.1',
                             '192.168.0.0/16',
                             '172.16.0.0/12',
                             '10.0.0.0/8' ]

  $forwarders = '0.0.0.0;'
  $enable_rfc1918_defaults = true
  $zone_header_template = 'bind/zone_header.erb'
  $managing_contact     = "devops.${::domain}"
  $nameservers          = [ $::fqdn ]

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = 'bind/named.conf.erb'
  $options_template = 'bind/named.conf.local.erb'
  $local_template = 'bind/named.conf.options.erb'
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

}