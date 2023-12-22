# Kubernetes命令行

```bash
# ------------------------Pods------------------------
kubectl get nodes
# guy为pod名称，busybox为镜像名称，-i --tty用于交互
kubectl run guy -i -tty --image=busybox
kubectl get pods # 查看正在运行的pods
kubectl create -f nginx-pod.yml
kubectl delete pods guy # 移除pods
# ------------------------Replicaset------------------------
kubectl create -f nginx-replicaset.yml
# 我们期望同时运行3个pod，如果挂掉一个，就会自动补上1个，如果多了1个，就会删掉1个。我们可以使用指定的标签（labels，如下文nginx-pod.yml中的labels）快速找到我们要的pod
# ReplicaSet的作用就是维持指定数量的Pod在运行
kubectl get rs # 查看每个ReplicaSet的状态
kubectl replace -f nginx-replicaset.yml # 修改nginx-replicaset.yml后，使用replace代替原来的配置
kubectl scale --replicas=5 -f nginx-replicaset.yml # 不更改文件，临时伸缩
kubectl delete rs nginx-replicaset # 删除ReplicaSet
# ------------------------deployment------------------------
kubectl create -f nginx-deployment.yml
kubectl get deployments
kubectl apply -f nginx-deployment.yml # 更新
# ------------------------Service------------------------
kubectl create -f external-service.yml
kubectl get deployments
```

# nginx-pod.yml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
    - name: nginx-container
     image: nginx
    - name: busybox-container
     -image: busybox
```

# nginx-replicaset.yml

注意这个`matchLabels`是指用在ReplicaSet上的，而不是Pod上。`template/metadata`内的`labels`是用在Pods上的

`selector`内表示我需要4个标签为`app: nginx`的Pod。`templete`内表示告诉ReplicaSet如果缺少指定数量的Pods，用这个模板创建同样的Pod就可以了

```yaml
apiVersion: apps/v1
kind: ReplicaSet --这里可以改为deployment，然后相应更改metadata的内容
metadata:
  name: nginx-replicaset
  labels:
    app: nginx-replica
spec:
  replicas: 4
  selector: 
    matchLabels:
      app: nginx
  templete:
    metadata:
      name: nginx-pod
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx-container
         image: nginx
        - name: busybox-container
         image: busybox
```

# nginx-deployment.yml

deployment就是更高级的ReplicaSet，创建deployment的时候会自动创建ReplicaSet，而创建ReplicaSet会根据期望创建Pod

Service

在k8s集群里的每个Pod都有唯一的IP地址，如果两个应用之间需要进行交互，其中一个Pod挂了重新创建一个Pod的时候IP地址就很可能会改变，另一个应用需要更改新的IP地址来进行交互

1. CluterIP（默认，集群内分配IP地址）
2. NodePort（让节点暴露端口，使得外部可以访问内部的应用）
3. LoadBalancer
4. EnternalName

```yaml
apiVersion: v1
kind: Service
metadata:
  name: external-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30008
```

最后通过http://localhost:30008/访问nginx
