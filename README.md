## To simply setup a k8s cluster with argocd and rabbitmq, switch to branch 'with-gitops-repo' and execute install-all.sh

## Requirements

* kind
* docker
* kubectl

### Task

[Source-Docs](https://docs.google.com/document/d/1aNIrZbt6vGVTtekMCbRJgi9IJ39dYaPHXqQ41kvZH-M/edit#heading=h.34m9ms77755b)

Pasted: (2023-11-22) 
```
 - lokalen Kubernetes Cluster mit kind aufsetzen und darauf Ingress einrichten
 - irgendeinen POD deployen der dann via Ingress erreichbar ist (zbsp NGINX)
 - Operator für RabbitMQ installieren (da gibts 2 die benötigt werden, einen um einen RabbitMQ Cluster erstellen zu können und einen um diesen Cluster konfigurieren zu können
 - RabbitMQ Cluster deployen
 - RabbitMQ Cluster konfigurieren (Queues, Shovels, User, Rechte, etc)
 - ArgoCD: der Cluster soll dann mithilfe von ArgoCD deployed/konfiguriert werden
 - kleine Applikation basteln die in eine Queue schreibt und wieder davon liest, also Producer/Consumer (kannst auf 2 
 aufteilen oder in 1 implementieren), Quarkus mit Camel, soll auch via ArgoCD deployed werden, Image bauen kannst via Github 
 Actions machen (oder einfach lokal bauen und in eine Registry pushen, wie du willst)
 - Die App(s) soll(en) sich beim RabbitMQ Cluster authentifizieren müssen -> bedeutet wir brauchen eine Lösung um Secrets in
  Git ablegen zu können (zbsp. SealedSecrets, ExternalSecrets, ...): Bevor du hier was umsetzt wärs mir ganz Recht wenn du 
  dir ansiehst was es derzeit für Lösungen gibt und wir besprechen das dann vorher
```
