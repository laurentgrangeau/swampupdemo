# swampup-template
Template repo for the sampup demo


## Setting a remote on Gitlab

```git remote add gitlab```

## Basic use

1. Create a repo on github (called mynewrepo here, created by user john)
2. In this repo, create a hook pointing to Jenkins : **Settings** -> **Webhooks**
    + URL : _http://labs.laurentgrangeau.fr:8001/github-webhook/
    + No token
    + Events : Push, Create
    + Validate, and test it to make sure all is good
2. Clone the original template repo, and change the remote to point to your new repo :
```
git clone git@github.com:laurentgrangeau/swampup-template.git
cd swampup-template
git remote remove origin
git remote add origin https://github.com/john/mynewrepo.git
```
4. Change the values in job.properties to fit your project
5. Create a multibranch pipeline job on Jenkins, and point it to your repo
6. Input your credentials to push to artifactory. The credentials ID must be pypi-creds
4. Push, and **for the first time you'll also have to set the new origin as the default** :
```
git push -u origin --all
```
6. That's it ! Start coding !