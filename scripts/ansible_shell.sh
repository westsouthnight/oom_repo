#!/bin/bash

 ansible -m shell -a "$argv"  -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory all