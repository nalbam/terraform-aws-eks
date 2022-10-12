apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${rolearn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
    - rolearn: arn:aws:iam::${account_id}:role/irsa--eks-demo--atlantis
      username: k8s-master
      groups:
        - system:masters
    - rolearn: arn:aws:iam::${account_id}:role/k8s-master
      username: k8s-master
      groups:
        - system:masters
    - rolearn: arn:aws:iam::${account_id}:role/k8s-readonly
      username: k8s-readonly
      groups: []
  mapUsers: |
%{ for user in users ~}
    - userarn: arn:aws:iam::${account_id}:user/${user}
      username: ${user}
      groups:
        - system:masters
%{ endfor ~}
