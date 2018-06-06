# terraform-aws-eks

```
aws configure set default.region us-east-1
aws configure set default.region ap-northeast-2

# eks
aws eks list-clusters
aws eks describe-cluster --name nalbam-dev --query cluster.status

# heptio
curl -o heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/heptio-authenticator-aws
curl -o heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/darwin/amd64/heptio-authenticator-aws

chmod +x ./heptio-authenticator-aws
sudo mv ./heptio-authenticator-aws /usr/local/bin/

# calico
kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/v1.0.0/config/v1.0/aws-k8s-cni-calico.yaml

# sample
kubectl apply -f handson-labs-2018/3_Kubernetes/sample-web.yml

#
kubectl get deploy,pod,svc,job --all-namespaces

```
