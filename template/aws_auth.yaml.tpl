apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |

${workers}

${map_roles}

%{ if map_users != "" }
  mapUsers: |

${map_users}
%{ endif }
