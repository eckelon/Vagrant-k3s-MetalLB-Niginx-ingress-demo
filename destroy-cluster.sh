#!/bin/bash
set -e

bold=$(tput bold)
normal=$(tput sgr0)

KUBECONFIG="$HOME/.kubeconfigs/kube-vagrant"

vagrant destroy -f
if [ -f "$KUBECONFIG" ]; then
  rm $KUBECONFIG
  echo -n "${bold}==> clean kubeconfig: $KUBECONFIG deleted.${normal}"
fi
