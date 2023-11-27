#!/usr/bin/env bash

cat <<EOF | kind create cluster -n rabbitmq-poc --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF

k8sstatus=$(kubectl cluster-info --context kind-rabbitmq-poc)
printf "\n $k8sstatus"

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
printf "Wait for NGINX ingress to be installed\n"

kubectl wait --namespace ingress-nginx \
  --for=condition=complete \
  --timeout=300s \
  job.batch/ingress-nginx-admission-create

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s

kubectl apply -f kind/yaml-templates/ingress-nginx-controller-ssl-passthrough.yaml
