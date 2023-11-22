#!/usr/bin/env bash

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


while ! kubectl get secret argocd-initial-admin-secret -n argocd; do echo "Waiting for ArgoCD-cluster secret. CTRL-C to exit."; sleep 1; done

username="admin"
password="$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 --decode)"
printf "\nArgoCD UI is starting. Your username is $username and password is $password \nOpen at https://localhost:8080/login \n\n"

kubectl apply -f argocd/yaml-templates/argocd-ingress.yaml

# cmd="kubectl port-forward svc/argocd-server -n argocd 8080:443"
# $cmd > /dev/null &
