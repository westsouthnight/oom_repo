#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible
ls -la /
ls -la /vagrant

#cp /vagrant/ansible/hosts/vagrant /etc/ansible/hosts -f
# sudo chmod 666 /etc/ansible/hosts
#cat /vagrant/ansible/files/authorized_keys >> /home/vagrant/.ssh/authorized_keys
#sudo ansible-playbook /vagrant/ansible/playbook.yml --connection=local

# sudo apt-get update -y
# sudo apt-get install -y build-essential checkinstall software-properties-common
# sudo apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev
# cd /usr/src
# sudo wget https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz
# sudo tar xzf Python-2.7.11.tgz
# cd Python-2.7.11
# sudo ./configure
# sudo make install
# sudo wget https://bootstrap.pypa.io/get-pip.py
# sudo -H python get-pip.py
# sudo -H pip install cryptography pywinrm ansible
# sudo pip install --upgrade pip