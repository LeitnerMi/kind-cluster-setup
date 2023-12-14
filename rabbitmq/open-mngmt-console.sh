#!/usr/bin/env bash

while ! kubectl get secret hello-world-default-user -n hello-world-cluster; do echo "Waiting for RabbitMQ-Cluster secret. CTRL-C to exit."; sleep 2; done
username="$(kubectl get secret hello-world-default-user -n hello-world-cluster -o jsonpath='{.data.username}' | base64 --decode)"
password="$(kubectl get secret hello-world-default-user -n hello-world-cluster -o jsonpath='{.data.password}' | base64 --decode)"
printf "Username is $username \nPassword is $password \n"
kubectl port-forward "service/hello-world" 15672 -n hello-world-cluster
