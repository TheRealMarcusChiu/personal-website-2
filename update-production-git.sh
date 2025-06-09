#! /bin/bash

hugo

cd public
git commit -am "initial commit"
git push

ssh -i ~/.ssh/keys/aws-marcuschiu.pem ec2-user@www.marcuschiu.com << EOF
  cd personal-website-two/public/
  git pull
EOF
