# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "withinboredom/Trusty64"

  #The following line is ignored by hyperv
  config.vm.network :private_network, ip: "10.231.31.31"

  # Install Puppet in case the box doesn't have it.
  config.vm.provision "shell", path: "puppet/puppet.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "init.pp"
    puppet.options="--verbose --debug"
  end
  
  config.vm.provider "hyperv"
  # Fix for slow external network connections
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
  end
end
