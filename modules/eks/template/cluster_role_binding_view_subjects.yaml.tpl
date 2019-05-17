%{ if group == "view" }
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: ${username}
%{ endif }
