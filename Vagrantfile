# Vagrant OS image to use
IMAGE_NAME = "debian/buster64"

# Network settings
NET_SUBNET = "192.168.0."
NETR_START = 200

# Number of k8s worker nodes wanted
N = 2

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "libvirt" do |v|
        v.memory = 2048
        v.cpus = 2
    end

    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network :public_network,
            :dev => "br0",
            :mode => "virtio",
            :type => "bridge",
            :mac => "0818E9E44C00",
            auto_config: true
        master.vm.hostname = "k8s-master"
        master.vm.provision "ansible" do |ansible|
            ansible.playbook = "010-vagrant/master-playbook.yml"
            ansible.extra_vars = {
                net_subnet: "#{NET_SUBNET}",
                node_ip: "#{NET_SUBNET}#{NETR_START}",
            }
        end
    end

    (1..N).each do |i|
        config.vm.define "k8s-node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network :public_network,
                :dev => "br0",
                :mode => "virtio",
                :type => "bridge",
                :mac => "0818E9E44C0#{i}",
                auto_config: true
            node.vm.hostname = "k8s-node-#{i}"
            node.vm.provision "ansible" do |ansible|
                ansible.playbook = "010-vagrant/node-playbook.yml"
                ansible.extra_vars = {
                    node_ip: "#{NET_SUBNET}#{i + NETR_START}",
                }
            end
        end
    end
end
