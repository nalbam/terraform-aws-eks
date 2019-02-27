# terraform-aws-eks

* see: <https://github.com/nalbam/docs/blob/master/201806/EKS/README.md>

## Preparation

* <https://kubernetes.io/docs/tasks/tools/install-kubectl/>
* <https://github.com/kubernetes-sigs/aws-iam-authenticator>

```bash
# install tools
curl -sL https://raw.githubusercontent.com/opsnow/kops-cui/master/tools.sh | bash
```

## Create Cluster

```bash
# region
aws configure set default.region us-west-2

# terraform (10m)
terraform init
terraform plan
terraform apply

# eks
aws eks list-clusters
aws eks describe-cluster --name ${CLUSTER_NAME}
aws eks update-kubeconfig --name ${CLUSTER_NAME} --alias ${CLUSTER_NAME}

# aws auth
kubectl apply -f .output/aws_auth.yaml --kubeconfig .output/kube_config.yaml

# kube config
mkdir -p ~/.kube && cat .output/kube_config.yaml > ~/.kube/config
kubectl config current-context

# get
kubectl get node -o wide
kubectl get deploy,pod,svc,ing --all-namespaces
```

* <https://github.com/awslabs/amazon-eks-ami/>
* <https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html>
* <https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html>
* <https://github.com/terraform-aws-modules/terraform-aws-eks/>
