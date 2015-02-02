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
  
  exec { 'move-wordpress':
    cwd     => '/vagrant/wordpress',
    command => '/bin/mkdir core; /bin/mv wp-* core; /bin/mv *.* core',
    require => Exec['untar-wordpress'],
    creates => '/cd vagrant/wordpress/core/readme.html'
  }
  
  file { '/vagrant/wordpress/index.php':
    source  => '/vagrant/wordpress/core/index.php',
	require => Exec['move-wordpress'],
  }
  
  exec { 'update-wp-index':
    cwd     => '/vagrant/wordpress',
    command => '/bin/sed -i "s/wp-blog-header/core\/wp-blog-header/" index.php',
	require => File['/vagrant/wordpress/index.php']
  }

  # Copy a working wp-config.php file for the vagrant setup.
  file { '/vagrant/wordpress/core/wp-config.php':
    source => 'puppet:///modules/wordpress/wp-config.php',
	require => Exec['update-wp-index'],
  }
  
}
