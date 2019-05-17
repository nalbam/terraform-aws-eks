    - userarn: arn:aws:iam::${userid}:${user}
      username: ${username}
%{ if group != "" }
      groups:
        - ${group}
%{ endif }
