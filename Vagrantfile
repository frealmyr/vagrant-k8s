# Vagrant OS image to use
IMAGE_NAME = "debian/buster64"

# Network settings
NET_START = 200
NET_SUBNET = "192.168.0."
MAC_ADDRESS = "0818E9E44C0"

# Number of k8s worker nodes wanted
N = 2

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    # Host VM configuration
    config.vm.provider "libvirt" do |v|
        v.memory = 2048
        v.cpus = 2
    end

    # k8s master node configuration
    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network :public_network,
            :dev => "br0",
            :mode => "virtio",
            :type => "bridge",
            :mac => "#{MAC_ADDRESS}0",
            auto_config: true
        master.vm.hostname = "k8s-master"
        master.vm.provision "ansible" do |ansible|
            ansible.playbook = "010-vagrant/master-playbook.yml"
            ansible.extra_vars = {
                net_subnet: "#{NET_SUBNET}",
                node_ip: "#{NET_SUBNET}#{NET_START}",
            }
        end

        # Remove generated configuration files upon destroy
        master.trigger.after :destroy do |trigger|
            if File.file?("./.kube/config")
                trigger.run = {inline: "rm ./.kube/config"}
            end
            if File.file?("./010-vagrant/join-command")
                trigger.run = {inline: "rm ./010-vagrant/join-command"}
            end
        end
    end

    # k8s worker nodes configuration
    (1..N).each do |i|
        config.vm.define "k8s-node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network :public_network,
                :dev => "br0",
                :mode => "virtio",
                :type => "bridge",
                :mac => "#{MAC_ADDRESS}#{i}",
                auto_config: true
            node.vm.hostname = "k8s-node-#{i}"
            node.vm.provision "ansible" do |ansible|
                ansible.playbook = "010-vagrant/node-playbook.yml"
                ansible.extra_vars = {
                    node_ip: "#{NET_SUBNET}#{i + NET_START}",
                }
            end
        end
    end
end
