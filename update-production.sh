#! /bin/bash

hugo

ssh -i ~/.ssh/keys/aws-marcuschiu.pem ec2-user@www.marcuschiu.com << EOF
  rm -rf personal-website-two/
  mkdir personal-website-two
EOF

scp -i ~/.ssh/keys/aws-marcuschiu.pem -r ./public ec2-user@www.marcuschiu.com:~/personal-website-two
