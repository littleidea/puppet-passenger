define passenger::enable($version) {
  passenger::install{ passenger: version => $version}

  file { passenger-load:
         path => "/etc/apache2/mods-available/passenger.load",
         content => "LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-$version/ext/apache2/mod_passenger.so\n",
         mode => 644,
         require => Exec['passenger-install']
  }

  file { passenger-conf:
         path => "/etc/apache2/mods-available/passenger.conf",
         content => template(passenger/passenger.conf.erb),
         mode => 644,
         require => Exec['passenger-install']
  }

  exec { a2enmod:
         command => "/usr/sbin/a2enmod",
         require => [File['passenger-load'], File['passenger-conf']]
  }
}
