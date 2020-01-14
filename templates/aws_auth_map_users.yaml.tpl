    - userarn: ${userarn}
      username: ${username}
%{ if groups != "" }
      groups:
        - ${groups}
%{ endif }
