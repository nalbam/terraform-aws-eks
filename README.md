# terraform-aws-eks

* see: <https://github.com/nalbam/docs/blob/master/201806/EKS/README.md>

## Preparation

* <https://kubernetes.io/docs/tasks/tools/install-kubectl/>
* <https://github.com/kubernetes-sigs/aws-iam-authenticator>

```bash
# aws-cli > 1.15.32
pip3 install awscli

# terraform
brew install terraform

# kubectl
brew install kubectl
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
aws eks describe-cluster --name oregon-dev-demo

# kube config
mkdir -p ~/.kube && cat .output/kube_config.yaml > ~/.kube/config
kubectl config current-context

# aws auth
kubectl apply -f .output/aws_auth.yaml

# aws ebs gp2
kubectl apply -f .output/aws_ebs_gp2.yaml

# get
kubectl get node -o wide
kubectl get deploy,pod,svc,ing --all-namespaces
```

* <https://github.com/awslabs/amazon-eks-ami/>
* <https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html>
* <https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html>
* <https://github.com/terraform-aws-modules/terraform-aws-eks/>
