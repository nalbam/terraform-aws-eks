apiVersion: v1
kind: Secret
metadata:
  name: kube-config-${CLUSTER_NAME}
type: Opaque
data:
  text: |-
    ${ENCODED_TEXT}
