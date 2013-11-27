# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian-70rc1-x64-vbox4210-nocm.box"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210-nocm.box"
  config.vm.synced_folder ".", "/var/www/"

  config.vm.network :forwarded_port, guest: 8000, host: 8080
  config.vm.network :forwarded_port, guest: 80, host: 1580
  config.vm.network :forwarded_port, guest: 22, host: 1522

  config.vm.provision :shell, :path => "bootstrap.sh"
end
