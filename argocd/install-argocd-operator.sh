#!/usr/bin/env bash

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


while ! kubectl get secret argocd-initial-admin-secret -n argocd; do echo "Waiting for ArgoCD-cluster secret. CTRL-C to exit."; sleep 1; done

username="admin"
password="$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 --decode)"
printf "\nArgoCD UI is starting. Your username is $username and password is $password \nOpen at https://localhost/login \n\n"

kubectl apply -f argocd/yaml-templates/argocd-ingress.yaml

# kubectl apply -f argocd/yaml-templates/cert-manager-operator.yaml -n argocd
# kubectl apply -f argocd/yaml-templates/rabbitmq-cluster-operator-project.yaml -n argocd
# kubectl apply -f https://github.com/rabbitmq/messaging-topology-operator/releases/latest/download/messaging-topology-operator-with-certmanager.yaml -n rabbitmq-system

# kubectl apply -f argocd/yaml-templates/rabbbitmq-topology-operator.yaml -n argocd

# cmd="kubectl port-forward svc/argocd-server -n argocd 8080:443"
# $cmd > /dev/null &
