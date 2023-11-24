#!/usr/bin/env bash

kubectl apply -f argocd/yaml-templates/basic-rabbitmq-cluster-application.yaml -n argocd

sleep 10s

kubectl apply -f argocd/yaml-templates/poc-app-application.yaml -n argocd

while ! kubectl get secret hello-world-default-user -n hello-world-cluster; do echo "Waiting for RabbitMQ-cluster secret. CTRL-C to exit."; sleep 1; done

username="$(kubectl get secret hello-world-default-user -n hello-world-cluster -o jsonpath='{.data.username}' | base64 --decode)"
password="$(kubectl get secret hello-world-default-user -n hello-world-cluster -o jsonpath='{.data.password}' | base64 --decode)"
printf "You can start RabbitMQ Management-UI with |kubectl rabbitmq -n hello-world-cluster manage hello-world|. Your username is $username and password is $password \n\n"
