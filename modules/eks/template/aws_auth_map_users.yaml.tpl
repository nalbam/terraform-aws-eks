    - userarn: arn:aws:iam::${userid}:${user}
      username: ${username}
%{ if group == "system:masters" }
      groups:
        - ${group}
%{ endif }
