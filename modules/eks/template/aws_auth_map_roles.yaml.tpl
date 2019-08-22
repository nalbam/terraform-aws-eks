    - rolearn: ${rolearn}
      username: ${username}
%{ if group != "" }
      groups:
        - ${group}
%{ endif }
