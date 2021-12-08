# K3S + MetalLB + Ingress-Nginx Demo

This is an automated way of deploying a K8s cluster ([k3s](https://k3s.io/)) in bare metal (Vagrant for this example) with an ingress controller ([Ingress-Nginx Controller](https://kubernetes.github.io/ingress-nginx/)) and a LoadBalancer ([MetalLB](https://metallb.org/)).

## Init the cluster

```
./init-cluster.sh
```

## export the Kubeconfig

```
export KUBECONFIG=$HOME/.kubeconfigs/kube-vagrant
```

## Install MetalLB and Nginx-Ingress controller

```
helmfile sync
```

## ... And test it!

```
#/etc/hosts
192.168.56.120 pruebas.net
```

```
./test.sh
```

wait a minute and go to http://pruebas.net in your browser!

