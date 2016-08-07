#
class soekris::config {

  $baud_rate    = $::soekris::baud_rate
  $boot_timeout = $::soekris::boot_timeout
  $error_led    = $::soekris::error_led
  $ready_led    = $::soekris::ready_led

  file { '/etc/boot.conf':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template('soekris/boot.conf.erb'),
  }

  file { '/etc/rc.securelevel':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template('soekris/rc.securelevel.erb'),
  }

  sysctl { 'hw.perfpolicy':
    ensure => present,
    value  => 'auto',
  }
}
