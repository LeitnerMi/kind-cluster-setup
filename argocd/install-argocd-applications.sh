#!/usr/bin/env bash

kubectl apply -f argocd/yaml-templates/basic-rabbitmq-cluster-application.yaml -n argocd

kubectl apply -f argocd/yaml-templates/poc-app-application.yaml -n argocd

