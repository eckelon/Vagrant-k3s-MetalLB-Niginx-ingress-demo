# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

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
