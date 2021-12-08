#!/bin/bash

set -e

kubectl create namespace demonginx
kubectl -n demonginx create deployment demo --image=httpd --port=80
kubectl -n demonginx expose deployment demo
kubectl -n demonginx create ingress demo-localhost --class=nginx \
  --rule=pruebas.net/*=demo:80

