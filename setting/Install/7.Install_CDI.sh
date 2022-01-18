export CDI=v1.13.1

# CDI

kubectl create -f https://github.com/kubevirt/containerized-data-importer/releases/download/$CDI/cdi-operator.yaml
kubectl create -f https://github.com/kubevirt/containerized-data-importer/releases/download/$CDI/cdi-cr.yaml
