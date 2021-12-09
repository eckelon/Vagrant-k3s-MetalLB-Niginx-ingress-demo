# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

 config.vm.define "router" do |router|
    router.vm.box = "ubuntu/bionic64"
    router.vm.network "private_network", ip: "192.168.56.109"
    router.vm.network "public_network", ip: "192.168.1.186", bridge:"en0: Wi-Fi (Wireless)"
    router.vm.provider "virtualbox" do |routervm|
      routervm.memory = 512
      routervm.cpus = 1
    end
    router.ssh.forward_agent = true
    router.vm.hostname = "router"
    router.vm.provision "shell", path: "./provision/router.sh"
  end

  config.vm.define "main" do |main|
    main.vm.box = "ubuntu/bionic64"
    main.vm.network "private_network", ip: "192.168.56.110"
    main.vm.provider "virtualbox" do |mainvm|
      mainvm.memory = 2048
      mainvm.cpus = 2
    end
    main.ssh.forward_agent = true
    main.vm.hostname = "main"
  end

  (1..2).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.box = "ubuntu/bionic64"
      worker.vm.network "private_network", ip: "192.168.56.11#{i}"
      worker.ssh.forward_agent = true
      worker.vm.provider "virtualbox" do |workervm|
        workervm.memory = 2048
        workervm.cpus = 1
      end
      worker.vm.hostname = "worker#{i}"
      worker.ssh.forward_agent = true
    end
  end
end
