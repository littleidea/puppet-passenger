define passenger::install($version) {
  package { passenger:
            ensure => $version,
            provider => gems,
            require => [Class['gems'], Class['ruby'], Class['apache2']]
  }

  exec { passenger-install:
         command => "/usr/bin/passenger-install-apache2-module"
         creates => "/usr/lib/ruby/gems/1.8/gems/passenger-$version/ext/apache2/mod_passenger.so",
         requires => Package['passenger']
  }
}
