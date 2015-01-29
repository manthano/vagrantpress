# Install latest Wordpress

class wordpress::install {

  # Create the Wordpress database
  exec { 'create-database':
    unless  => '/usr/bin/mysql -u root -pvagrant wordpress',
    command => '/usr/bin/mysql -u root -pvagrant --execute=\'create database wordpress\'',
  }

  exec { 'create-user':
    unless  => '/usr/bin/mysql -u wordpress -pwordpress wordpress',
    command => '/usr/bin/mysql -u root -pvagrant --execute="GRANT ALL PRIVILEGES ON wordpress.* TO \'wordpress\'@\'localhost\' IDENTIFIED BY \'wordpress\'"',
  }

  # Get a new copy of the latest wordpress release
  # FILE TO DOWNLOAD: http://wordpress.org/latest.tar.gz

  exec { 'download-wordpress': #tee hee
    command => '/usr/bin/wget http://wordpress.org/latest.tar.gz',
    cwd     => '/vagrant/',
    creates => '/vagrant/latest.tar.gz'
  }

  exec { 'untar-wordpress':
    cwd     => '/vagrant/',
    command => '/bin/tar xzvf /vagrant/latest.tar.gz',
    require => Exec['download-wordpress'],
    creates => '/vagrant/wordpress',
  }
  
  exec { 'create-wp-subdir':
    cwd     => '/vagrant/wordpress',
    command => 'mkdir core',
    creates => 'vagrant/wordpress/core',
  }
  
  exec { 'move-wordpress':
    cwd     => '/vagrant/wordpress',
    command => 'mv * core',
    require => 'Exec['create-wp-subdir'],
    creates => 'vagrant/wordpress/core/wp-content'
  }
  
  file { '/vagrant/wordpress/index.php':
    source  => '/vagrant/wordpress/core/index.php',
  }
  
  exec { 'update-wp-index':
    cwd     => '/vagrant/wordpress',
    command => ' sed -i "s/wp-blog-header/core\/wp-blog-header/"',
    require => 'Exec['move-wordpress'],
  }

  # Copy a working wp-config.php file for the vagrant setup.
  file { '/vagrant/wordpress/core/wp-config.php':
    source => 'puppet:///modules/wordpress/wp-config.php'
  }
  
}
