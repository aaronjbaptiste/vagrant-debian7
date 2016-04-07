# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian-70rc1-x64-vbox4210-nocm.box"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210-nocm.box"

  config.vm.network :forwarded_port, guest: 8000, host: 8080
  config.vm.network :forwarded_port, guest: 80, host: 1580
  config.vm.network :forwarded_port, guest: 22, host: 1522

  config.vm.provision :shell, :path => "bootstrap.sh"
  config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=666"]

  config.vm.provider :virtualbox do |v|
      host = RbConfig::CONFIG['host_os']

      # Give VM 1/4 system memory & access to all cpu cores on the host
      if host =~ /darwin/
          cpus = `sysctl -n hw.physicalcpu`.to_i
          # sysctl returns Bytes and we need to convert to MB
          mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
      elsif host =~ /linux/
          cpus = `nproc`.to_i
          # meminfo shows KB and we need to convert to MB
          mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
      else # sorry Windows folks, I can't help you
          cpus = 2
          mem = 1024
      end

      v.customize ["modifyvm", :id, "--memory", mem]
      v.customize ["modifyvm", :id, "--cpus", cpus]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

end
