# terraform-aws-eks

* see: <https://github.com/nalbam/docs/blob/master/201806/EKS/README.md>

## Preparation

* <https://kubernetes.io/docs/tasks/tools/install-kubectl/>
* <https://github.com/kubernetes-sigs/aws-iam-authenticator>

## Create Cluster

```bash
# terraform
brew install terraform

# examples
cd examples/dev-demo

# terraform (10m)
terraform init
terraform plan
terraform apply

# kube config
mkdir -p ~/.kube && cp .output/kube_config.yaml ~/.kube/config

# files
cat .output/aws_auth.yaml
cat .output/kube_config.yaml
cat .output/kube_config_secret.yaml

# get
kubectl get node -o wide
kubectl get all --all-namespaces
```

* <https://github.com/awslabs/amazon-eks-ami/>
* <https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html>
* <https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html>
* <https://github.com/terraform-aws-modules/terraform-aws-eks/>
