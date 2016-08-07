#
class soekris::params {

  case $::osfamily {
    'OpenBSD': {
      if $::manufacturer != 'Soekris Engineering' {
        fail('')
      }
      if $::productname != 'net6501' {
        fail('')
      }
    }
    default: {
    }
  }
}
