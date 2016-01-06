# -*- mode: ruby -*-
# vi: set ft=ruby :
DOMAIN="example.com"
SUBNET="10.90.15"
MEMORY=1028

Vagrant.configure(2) do |config|
  config.vm.define "http1" do |http1|
    http1.vm.box = "ubuntu/trusty64"
    http1.vm.hostname = "http1.#{DOMAIN}"
    http1.vm.network "private_network", ip: "#{SUBNET}.101"
    http1.vm.provision :puppet, :options => ["--pluginsync --hiera_config /vagrant/deploy/hiera.yaml --yamldir /hieradata"], :module_path => "deploy/modules", :facter => {"middleware_ip" => "#{SUBNET}.10"} do |puppet|
      puppet.manifests_path = "deploy"
      puppet.manifest_file = "site.pp"
    end
  end
end
