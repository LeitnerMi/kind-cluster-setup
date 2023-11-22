#!/usr/bin/env bash

kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
# kubectl krew install rabbitmq

kubectl apply -f "rabbitmq/yaml-templates/basic-rabbitmq-cluster.yaml"

# Thats not working
# kubectl wait \
#   --for=condition=ready pod \
#   --selector=app.kubernetes.io/name=hello-world \
#   --timeout=90s \
printf "Wait for RabbitMQ pod to initialize...\n\n"

sleep 10s

while ! kubectl get secret hello-world-default-user; do echo "Waiting for RabbitMQ-cluster secret. CTRL-C to exit."; sleep 1; done

username="$(kubectl get secret hello-world-default-user -o jsonpath='{.data.username}' | base64 --decode)"
password="$(kubectl get secret hello-world-default-user -o jsonpath='{.data.password}' | base64 --decode)"
printf "RabbitMQ Management-UI is starting. Your username is $username and password is $password \n\n"

cmd="kubectl rabbitmq manage hello-world"
$cmd > /dev/null &

