class{'install':

  class {'apache':}

  apache::vhost { 'myMpwar.dev':
        port          => '80',
        docroot       => '/var/www',
        docroot_owner => 'vagrant',
        docroot_group => 'vagrant',
  }

  apache::vhost { 'myMpwar.prod':
        port          => '80',
        docroot       => '/var/www',
        docroot_owner => 'vagrant',
        docroot_group => 'vagrant',
  }

  class { 'php':
    version => '5.4',
  }

  class {'mysql':}

  mysql::db { 'mympwar_exam':
    user     => 'myuser',
    password => 'mypass',
    host     => 'localhost',
    grant    => ['SELECT', 'UPDATE'],
  }

  mysql::db { 'mympwar_backup':
    user     => 'myuser',
    password => 'mypass',
    host     => 'localhost',
    grant    => ['SELECT', 'UPDATE'],
  }

  class {'memcached':}

  file{"/var/www/index.php":
    ensure => present,
    content => "<?php echo 'Hello World. Sistema operativo ' . php_uname('s') .' ' .php_uname('v') ",
  }

  file{"/var/www/info.php":
    ensure => present,
    content => "<?php phpinfo();",
  }

  file_line{"Open port 8080":
    path => "/etc/sysconfig/iptables",
    line => "-A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT",
  }

  file_line{"Open port 443":
    path => "/etc/sysconfig/iptables",
    line => "-A INPUT -p tcp -m tcp --dport 443 -j ACCEPT",
  }

}
