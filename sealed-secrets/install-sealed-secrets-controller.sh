kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.24.4/controller.yaml

kubectl apply -f sealed-secrets/sealed-secrets-cert-secret.yaml -n kube-system
kubectl delete pod -l name=sealed-secrets-controller -n kube-system
