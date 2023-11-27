#!/usr/bin/env bash

if ! command -v /bin/bash &> /dev/null
then
    echo "/bin/bash could not be found"
    exit 1
fi

/bin/bash kind/delete-cluster.sh
/bin/bash kind/create-cluster.sh

/bin/bash rabbitmq/install-cluster-operator.sh
/bin/bash rabbitmq/install-topology-operator.sh

/bin/bash argocd/install-argocd-operator.sh

