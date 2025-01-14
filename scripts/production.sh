eval "$(ssh-agent -s)" #start the ssh agent
chmod 600 ./production-deploy.key # this key should have push access
ssh-add ./production-deploy.key
ssh-keyscan placecal.com >> ~/.ssh/known_hosts
git remote add deploy dokku@placecal.com:placecal
git config --global push.default simple
git push deploy production:master
