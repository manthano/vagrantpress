class vagrantpress::prepare{

  ## Not needed for non-git checkouts
  file{"/home/vagrant/.ssh": ensure => directory,}
  file{"/home/vagrant/.ssh/config":
    ensure => present,
    content => 'StrictHostKeyChecking no'
  }


}