# Homelab configuration
This repository contains every configuration file used in my Intel NUC7 i3 homelab, feel free to fork or copy its content for your own personal use.

The intended use for my NUC homelab is the following:
  * Host OS running Kubuntu 18.04 LTS
    * Connected to 4K TV and HiFi receiver
    * Used for web-surfing, streaming & Kodi
    * External HDD for Samba NAS with syncronization to JottaCloud
  * Vagrant
    * Creates 3-node k8s cluster
    * Uses libvirt for KVM virtualization
    * Bridged Virtio network adapter
      * Allows hosting from the Host OS and k8s cluster with seperate IP addresses
  * Terraform
    * Configuration k8s cluster
    * Helm/Tiller for provisioning applications to cluster
