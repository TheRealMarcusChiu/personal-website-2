#! /bin/bash

hugo

tar czf public.tar.gz public

ssh -i ~/.ssh/keys/aws-marcuschiu.pem ec2-user@www.marcuschiu.com << EOF
  rm -rf personal-website-two/
  mkdir personal-website-two
EOF

scp -i ~/.ssh/keys/aws-marcuschiu.pem -r ./public.tar.gz ec2-user@www.marcuschiu.com:~/personal-website-two

ssh -i ~/.ssh/keys/aws-marcuschiu.pem ec2-user@www.marcuschiu.com << EOF
  cd personal-website-two
  tar -xvzf public.tar.gz
  rm public.tar.gz
EOF
