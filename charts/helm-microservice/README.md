# helm-microservice

helm-microservice represents a general Helm Chart, that can be reused to deploy typical Kubernetes microservice:
- deployment;
- service;
- optional ingress;

and supports some useful features:
- ability to use secret to pull from private registry;
- mount Google's service account file;
