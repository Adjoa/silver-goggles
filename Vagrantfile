# -*- mode: ruby -*-
# vi: set ft=ruby :
DOMAIN="example.com"
SUBNET="10.90.15"

Vagrant.configure(2) do |config|
  config.vm.define "http1" do |http1|
    http1.vm.box = "ubuntu/trusty64"
    http1.vm.hostname = "http1.#{DOMAIN}"
    http1.vm.network "private_network", ip: "#{SUBNET}.101"
    http1.vm.provision :puppet, :options => ["--pluginsync --hiera_config /vagrant/deploy/hiera.yaml"], :module_path => "deploy/modules", :facter => {"middleware_ip" => "#{SUBNET}.10"} do |puppet|
      puppet.manifests_path = "deploy"
      puppet.manifest_file = "site.pp"
    end
  end

  config.vm.define "http2" do |http2|
    http2.vm.box = "ubuntu/trusty64"
    http2.vm.hostname = "http2.#{DOMAIN}"
    http2.vm.network "private_network", ip: "#{SUBNET}.102"
    http2.vm.provision :puppet, :options => ["--hiera_config /vagrant/deploy/hiera.yaml"], :module_path => "deploy/modules" do |puppet|
      puppet.manifests_path = "deploy"
      puppet.manifest_file = "site.pp"
    end
  end
  
  config.vm.define "lb1" do |lb1|
    lb1.vm.box = "puphpet/centos65-x64"
    lb1.vm.hostname = "lb1.#{DOMAIN}"
    lb1.vm.network "private_network", ip: "#{SUBNET}.103"
    lb1.vm.provision :puppet, :options => ["--hiera_config /vagrant/deploy/hiera.yaml"], :module_path => "deploy/modules" do |puppet|
      puppet.manifests_path = "deploy"
      puppet.manifest_file = "site.pp"
    end
  end
  
  config.vm.define "lb2" do |lb2|
    lb2.vm.box = "puphpet/centos65-x64"
    lb2.vm.hostname = "lb2.#{DOMAIN}"
    lb2.vm.network "private_network", ip: "#{SUBNET}.104"
    lb2.vm.provision :puppet, :options => ["--hiera_config /vagrant/deploy/hiera.yaml"], :module_path => "deploy/modules" do |puppet|
      puppet.manifests_path = "deploy"
      puppet.manifest_file = "site.pp"
    end
  end
end
