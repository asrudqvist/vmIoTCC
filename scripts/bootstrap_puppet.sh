#!/bin/bash
#https://coderwall.com/p/jiabja/automatically-update-puppet-in-your-vagrant-precise64-box
#Bastian Spanneberg

FLAG=/root/puppet-updated 

if [ ! -e $FLAG ]; then
	wget -O /tmp/puppetlabs-release-pc1-xenial.deb https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
	dpkg -i /tmp/puppetlabs-release-pc1-xenial.deb
	apt-get update
	apt-get --assume-yes install puppet-agent
	#systemctl start puppet
	touch $FLAG
fi

echo vagrant:vagrant | /usr/sbin/chpasswd