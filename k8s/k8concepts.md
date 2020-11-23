# Concepts
- a system to deploy containerized apps
- EKS managed solution: Elastic Kubenetes Service/ Google Cloud Kubenetes Engine 
- Nodes are individual machines (bare metal environment/virtual box) to run containers
- master node: kube apiserver; maintains desired state (defined in config files) and decides which node to run the containers
- Nodes+master forms a **cluster**: running different quantities of containers from different images
- imperative(discrete actions) v.s. declarative deployments
- minikube(development): creates k8s cluster on local machine (manage the VM itself)
- kubectl: interact with containers
- k8s difference from docker-compose: image needs to be pre-built; manually setup all networking

# Object (StatefulSet, Pod, Service, ReplicaController)

## apiVersion
- v1: componentStatus, Event, configMap, Endpoints, Namespace, Pod
- app/v1: StatefulSet, ControllerRevision

## metadata
- name 
- labels (component)

## kind: 
### Pod 
- could have multiple tightly-coupled containers, the smallest thing you could deploy
- containerPort 
- good for one-off dev purposes
- what happens when you do a docker kill
- only allow changing certain types of fields (containerPod not included) not allowed to update port of a pod (name, etc...)


### Service
Service (sets up networking in a k8s cluster) 
why do we need a service? (pod may die and start on a different ip)
kubeproxy--->NodePort---->Pod

Types:
- NodePort, (expose the container to the outside world) only for dev purposes; another communication layer between pod and outside world (k8s proxy)
- ClusterIP, expose ports to other objects in the cluster
- LoadBalancer, Legacy way of getting network traffic into a cluster; Cloud provider provisioned load balancer
- Ingress, expose a set of services to the outside world, nginx ingress controller (ingress-nginx: Namespace; nginx-ingress-controller: Deployment)
ports: 
- port(expose to other pods), targetPort(map to containerPort), nodePort(expose to outside world, random assigned 30000-32767, not used in production)

selector (based on keyvalue pairs under labels, completely arbitory)


### depolyment: 
- a set of ports; replicas, selector(matchLabels(component:<>)); template(used for pod, metadata(label), specs)
- replicas (under spec)
- selector (under spec, master will look for pods with the labels):
    matchLabels:
      component: web
- template (under spec)
- imperatively update the image of a deployment

### misc 
- apply a group of config files
- (env var)under containers: env: - name:<>; value:<>

### persistent volume claim
- K8s volume: associated with a pod
- persistent volume
- persistent volume claim (ad advertisement) statically provisioned persistent volume, dynamically provisioned persistent volume
- under spec: accessModes (- ReadWriteOnce, ReadWriteMany, ReadOnlyMany) resources(requests: storage: 2Gi)
- storageclass, default option: aws block store, or google cloud persistent disk, azure file
- spec: volumes: - name, persistentVolumeClain: claimName: <>; under containers: volumeMounts: -name: <>, mountPath: <>, subPath: <>

### encoded secret
- imperative command
- securely store a piece of information in the cluster, needs to be created manually
- secret can store many key-value pairs
- valueFrom: secretKeyRef: name: key:

### google cloud
- User accounts, service account
- ClusterRoleBinding(across the entire cluster), RoleBinding (namespace)





