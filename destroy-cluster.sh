#!/bin/bash

set -e
KUBECONFIG="$HOME/.kubeconfigs/kube-vagrant"
vagrant destroy -f
if [ -f "$KUBECONFIG" ]; then
  rm $KUBECONFIG
fi
