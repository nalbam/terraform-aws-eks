# terraform-aws-eks

```bash
# aws-cli > 1.15.32
pip3 install awscli

# kubectl
brew install kubectl

# heptio
curl -o heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/darwin/amd64/heptio-authenticator-aws
chmod +x ./heptio-authenticator-aws && sudo mv ./heptio-authenticator-aws /usr/local/bin/

# region
aws configure set default.region us-east-1

# terraform (10m)
terraform init
terraform plan
terraform apply

# eks
aws eks list-clusters
aws eks describe-cluster --name demo

# kube-config
mkdir -p ~/.kube
cat .output/kube-config.yml > ~/.kube/config

# aws-auth
kubectl apply -f .output/aws-auth.yaml

# calico
kubectl apply -f ./data/calico.yaml

# sample
kubectl apply -f ./data/sample-web.yml

# get
kubectl get no,deploy,pod,svc --all-namespaces
```
* https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html
* https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html
