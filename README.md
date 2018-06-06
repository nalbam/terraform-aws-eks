# terraform-aws-eks

```bash
# aws-cli
pip3 install awscli

# kubectl
brew install kubectl

# heptio
curl -o heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/darwin/amd64/heptio-authenticator-aws
chmod +x ./heptio-authenticator-aws
sudo mv ./heptio-authenticator-aws /usr/local/bin/

# region
aws configure set default.region us-east-1

# eks
aws eks list-clusters
aws eks describe-cluster --name nalbam-dev

# kube-config
mkdir -p ~/.kube
vi ~/.kube/config

# config-map-aws-auth
vi config-map-aws-auth.yaml
kubectl apply -f config-map-aws-auth.yaml

# calico
kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/v1.0.0/config/v1.0/aws-k8s-cni-calico.yaml

# sample
kubectl apply -f handson-labs-2018/3_Kubernetes/sample-web.yml

# get
kubectl get deploy,pod,svc --all-namespaces

```
* https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html
* https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html
