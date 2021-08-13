apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${CLUSTER_CERTIFICATE}
    server: ${CLUSTER_ENDPOINT}
  name: ${CLUSTER_NAME}
contexts:
- context:
    cluster: ${CLUSTER_NAME}
    user: aws-${CLUSTER_NAME}
  name: ${CLUSTER_NAME}
current-context: ${CLUSTER_NAME}
kind: Config
preferences: {}
users:
- name: aws-${CLUSTER_NAME}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      args:
        - --region
        - ${AWS_REGION}
        - eks
        - get-token
        - --cluster-name
        - ${CLUSTER_NAME}
      command: aws
