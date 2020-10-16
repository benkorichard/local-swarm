Vagrant.require_version ">= 1.6.0"
boxes = [
    {
        :name => "manager",
        :eth1 => "172.28.128.10",
        :mem => "1024",
        :cpu => "2"
    },
    {
        :name => "node1",
        :eth1 => "172.28.128.11",
        :mem => "4096",
        :cpu => "4"
    },
    {
        :name => "node2",
        :eth1 => "172.28.128.12",
        :mem => "4096",
        :cpu => "4"
    }
]

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/bionic64"

  boxes.each do |opts|
      config.vm.define opts[:name] do |config|
        config.vm.hostname = opts[:name]
        config.vm.provider "virtualbox" do |v|
          v.customize ["modifyvm", :id, "--memory", opts[:mem]]
          v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
          v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        end

        config.vm.network "private_network", ip: opts[:eth1]
        config.vm.provision "shell", path: "scripts/bootstrap.sh"
      end
  end
end
