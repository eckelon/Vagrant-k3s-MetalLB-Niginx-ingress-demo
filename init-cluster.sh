#!/bin/bash

set -e

K3SUP_BINARY=/usr/local/bin/k3sup
if [ -f "$K3SUP_BINARY" ]; then
  echo ""
else
  echo "Error: k3sup is required. Please, install it and then try again."
  exit 1
fi

vagrant up
eval `ssh-agent`
ssh-add ./.vagrant/machines/main/virtualbox/private_key
USER="vagrant"
MAIN_IP="192.168.56.110"
MAIN_PRIVATE_KEY="./.vagrant/machines/main/virtualbox/private_key"
KUBECONFIG="$HOME/.kubeconfigs/kube-vagrant"

echo "initializing main node..."
k3sup install \
  --ip=$MAIN_IP \
  --user=$USER \
  --sudo \
  --ssh-key=$MAIN_PRIVATE_KEY \
  --cluster \
  --k3s-channel=stable \
  --k3s-extra-args "--no-deploy=traefik --no-deploy=servicelb --flannel-iface=enp0s8 --node-ip=$MAIN_IP" \
  --merge \
  --local-path $KUBECONFIG \

echo "initializing worker nodes..."
for i in {1..2}
do
WORKER_IP="192.168.56.11$i"
WORKER_PRIVATE_KEY="./.vagrant/machines/worker$i/virtualbox/private_key"
k3sup join \
  --ip=$WORKER_IP \
  --user=$USER \
  --ssh-key=$WORKER_PRIVATE_KEY \
  --sudo \
  --k3s-channel=stable \
  --server \
  --server-ip=$MAIN_IP \
  --server-user=$USER \
  --k3s-extra-args "--no-deploy=traefik --no-deploy=servicelb --flannel-iface=enp0s8 --node-ip=$WORKER_IP"
done

echo "# Test your cluster with:"
echo "export KUBECONFIG=$KUBECONFIG"
echo "kubectl config set-context default"
echo "kubectl get node -o wide"
