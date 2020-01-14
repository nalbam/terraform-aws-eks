    - rolearn: ${rolearn}
      username: ${username}
%{ if groups != "" }
      groups:
        - ${groups}
%{ endif }
