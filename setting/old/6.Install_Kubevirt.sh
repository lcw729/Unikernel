export KV=v0.25.0

kubectl create namespace kubevirt
kubectl create configmap -n kubevirt kubevirt-config  --from-literal debug.useEmulation=true --from-literal feature-gates="LiveMigration"
kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/$KV/kubevirt-operator.yaml
kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/$KV/kubevirt-cr.yaml
