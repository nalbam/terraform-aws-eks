    - userarn: ${userarn}
      username: ${username}
%{ if group != "" }
      groups:
        - ${group}
%{ endif }
