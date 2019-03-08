apiVersion: v1
kind: Config
preferences: {}
clusters:
  - cluster:
      server: ${MASTER_ENDPOINT}
      certificate-authority-data: ${CERTIFICATE}
    name: ${CLUSTER_NAME}
contexts:
  - context:
      cluster: ${CLUSTER_NAME}
      user: ${CLUSTER_NAME}
    name: ${CLUSTER_NAME}
current-context: ${CLUSTER_NAME}
users:
  - name: ${CLUSTER_NAME}
    user:
      exec:
        apiVersion: client.authentication.k8s.io/v1alpha1
        command: aws-iam-authenticator
        args:
          - "token"
          - "-i"
          - "${CLUSTER_NAME}"
