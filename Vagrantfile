# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  (1..4).each do |i|
      config.vm.define "0#{i}-target-host", primary: true do |config|
        config.vm.box = "ubuntu/xenial64"
        config.vm.provision "shell", binary: true, privileged: false, path: "scripts/install-ansible.sh"
      end
    end
      
  config.vm.provider :virtualbox do |v|
    v.memory = 3048
    v.cpus = 3
  end
 config.vm.network "private_network", type: "dhcp"
  config.vm.define "ansible-control", primary: true do |control|
    control.vm.box = "ubuntu/xenial64"
    config.ssh.private_key_path = File.expand_path('~/.vagrant.d/insecure_private_key')
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