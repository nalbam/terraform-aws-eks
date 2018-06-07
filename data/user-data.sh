#!/bin/bash -xe

CA_CERTIFICATE_DIRECTORY=/etc/kubernetes/pki
CA_CERTIFICATE_FILE_PATH=${CA_CERTIFICATE_DIRECTORY}/ca.crt

mkdir -p ${CA_CERTIFICATE_DIRECTORY}

echo "${CERTIFICATE}" | base64 -d > ${CA_CERTIFICATE_FILE_PATH}

INTERNAL_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

DNS_CLUSTER_IP=10.100.0.10
if [[ ${INTERNAL_IP} == 10.* ]]; then
  DNS_CLUSTER_IP=172.20.0.10
fi

sed -i s,MASTER_ENDPOINT,${MASTER_ENDPOINT},g /var/lib/kubelet/kubeconfig
sed -i s,CLUSTER_NAME,${CLUSTER_NAME},g /var/lib/kubelet/kubeconfig
sed -i s,REGION,${REGION},g /etc/systemd/system/kubelet.service
sed -i s,MAX_PODS,20,g /etc/systemd/system/kubelet.service
sed -i s,MASTER_ENDPOINT,${MASTER_ENDPOINT},g /etc/systemd/system/kubelet.service
sed -i s,INTERNAL_IP,${INTERNAL_IP},g /etc/systemd/system/kubelet.service
sed -i s,DNS_CLUSTER_IP,${DNS_CLUSTER_IP},g /etc/systemd/system/kubelet.service
sed -i s,CERTIFICATE_AUTHORITY_FILE,${CA_CERTIFICATE_FILE_PATH},g /var/lib/kubelet/kubeconfig
sed -i s,CLIENT_CA_FILE,${CA_CERTIFICATE_FILE_PATH},g /etc/systemd/system/kubelet.service

systemctl daemon-reload
systemctl restart kubelet kube-proxy
