apiVersion: v1
kind: Secret
metadata:
  name: kube-config-${CLUSTER_NAME}
type: Opaque
data:
  aws: |-
    ${AWS_CONFIG}
  text: |-
    ${KUBE_CONFIG}
