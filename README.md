# terraform-aws-eks

* see: <https://github.com/nalbam/docs/blob/master/201806/EKS/README.md>

## Preparation

* <https://kubernetes.io/docs/tasks/tools/install-kubectl/>
* <https://github.com/kubernetes-sigs/aws-iam-authenticator>

```bash
# terraform
curl -sL opspresso.sh/tools/terraform | bash

# aws-cli
curl -sL opspresso.sh/tools/awscli | bash

# kubectl
curl -sL opspresso.sh/tools/kubectl | bash

# aws-iam-authenticator
curl -sL opspresso.sh/tools/aws-iam-authenticator | bash
```

## Create Cluster

```bash
# region
aws configure set default.region ap-northeast-2

# terraform (10m)
terraform init
terraform plan
terraform apply

# aws eks
aws eks list-clusters
aws eks describe-cluster --name oregon-dev-demo

# kube config
mkdir -p ~/.kube && cat .output/kube_config.yaml > ~/.kube/config
kubectl config current-context

# aws auth
kubectl apply -f .output/aws_auth.yaml

# aws ebs gp2
kubectl apply -f .output/aws_ebs_gp2.yaml

# kubectl get
kubectl get node -o wide
kubectl get deploy,pod,svc,ing --all-namespaces
```

* <https://github.com/awslabs/amazon-eks-ami/>
* <https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html>
* <https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html>
* <https://github.com/terraform-aws-modules/terraform-aws-eks/>
