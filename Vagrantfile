# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  (1..6).each do |i|
      config.vm.define "0#{i}-target-host", primary: true do |config|
        config.vm.box = "ubuntu/xenial64"
        config.vm.synced_folder ".", "/vagrant"
        config.ssh.insert_key = false
        config.vm.provision "shell", binary: true, privileged: false, path: "scripts/install-ansible.sh"
      end
    end
      
  config.vm.provider :virtualbox do |v|
    v.memory = 512
    v.cpus = 1
  end
 config.vm.network "private_network", type: "dhcp"
  config.vm.define "ansible-control", primary: true do |control|
    config.vm.synced_folder ".", "/vagrant"
    config.ssh.insert_key = false
    control.vm.box = "ubuntu/xenial64"
    # Define targets
    control.vm.provision "shell", binary: true, privileged: false, path: "scripts/install-ansible.sh"
    control.vm.provision "ansible" do |ansible|
      ansible.playbook = "init-clear.yml"
      ansible.limit = 'all'
      ansible.groups = {
        "galera-nodes": ["01-target-host", "02-target-host", "03-target-host", "04-target-host"],
        "mysql-backend": ["01-target-host", "02-target-host", "03-target-host", "04-target-host"],
        "mysql-haproxy": ["01-target-host", "02-target-host", "03-target-host", "04-target-host"],

        # include all host into this group
        "vagrant": [
          "01-target-host",
          "02-target-host",
          "03-target-host",
          "04-target-host",
          "ansible-control"
        ]
      }
    end
  end
end