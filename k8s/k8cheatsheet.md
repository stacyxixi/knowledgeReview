# Useful links
https://devkimchi.com/2018/06/05/running-kubernetes-on-wsl/

## Commands
```
kubectl config use-context docker-for-desktop
kubectl cluster-info
kubectl apply -f <config file>
kubectl get pods -o wide (internal IP)
1/1 (READY)
kubectl get services, deployments
minikube IP? (cluster IP??)
kubectl describe node docker-desktop
kubectl delete -f <config file>
kubectl set image deployment/<deployment_name> <container_name>=<image_name:version>
kubectl get storageclass (aws block store)
kubectl get pv
kubectl get pvc
kubectl create secret generic(docker-registry, tls) <secrect-name> --from-literal <key>=<value>
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.0/deploy/static/provider/cloud/deploy.yaml
```