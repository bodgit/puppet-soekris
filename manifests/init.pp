#
class soekris (
  $baud_rate          = 19200,
  $boot_timeout       = 2,
  $error_led          = 'error_led',
  $manage_gpioflicker = true,
  $manage_watchdog    = true,
  $ready_led          = 'ready_led',
  $watchdog_period    = 32,
) inherits ::soekris::params {

  validate_integer($baud_rate)
  validate_integer($boot_timeout)
  validate_string($error_led)
  validate_bool($manage_gpioflicker)
  validate_bool($manage_watchdog)
  validate_string($ready_led)
  if $manage_watchdog {
    validate_integer($watchdog_period, 600, 0)
  }

  include ::soekris::config

  anchor { 'soekris::begin': }
  anchor { 'soekris::end': }

  Anchor['soekris::begin'] -> Class['::soekris::config']
    -> Anchor['soekris::end']

  if $manage_gpioflicker {
    class { '::gpioflicker':
      device        => '/dev/gpio1',
      pin           => 0,
      initial_state => 0,
    }

    Class['::soekris::config'] -> Class['::gpioflicker']
      -> Anchor['soekris::end']
  }

  if $manage_watchdog {
    class { '::watchdog':
      manage_service => false,
      period         => $watchdog_period,
    }

    Anchor['soekris::begin'] -> Class['::watchdog'] -> Anchor['soekris::end']
  }
}
