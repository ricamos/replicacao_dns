# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/buster64"
  config.vm.box_check_update = true
  config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/" #vagrant rsync-auto

  config.vm.define :ns1 do |ns1_config|
    ns1_config.vm.hostname = "ns1"
    ns1_config.vm.network :private_network,
                          :ip => "192.168.42.20"
    ns1_config.vm.provision "shell", run: "always", inline: "ip route del default via 10.0.2.2 || true"
    ns1_config.vm.provision "shell", run: "always", path: "files/ns1.sh"                      
  end

  config.vm.define :ns2 do |ns2_config|
    ns2_config.vm.hostname = "ns2"
    ns2_config.vm.network :private_network,
                          :ip => "172.16.42.20"
    ns2_config.vm.provision "shell", run: "always", inline: "ip route del default via 10.0.2.2 || true"                      
    ns2_config.vm.provision "shell", run: "always", path: "files/ns2.sh"                      
  end

  config.vm.define :fw1, primary: true do |fw1_config|
    fw1_config.vm.hostname = "fw1"
    fw1_config.vm.network :private_network,
                          :ip => "192.168.42.10"
    fw1_config.vm.network :private_network,
                          :ip => "172.16.42.10"
    fw1_config.vm.provision "shell", run: "always", path: "files/fw1.sh"                                              
  end                        
end
