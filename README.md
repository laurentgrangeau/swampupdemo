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
3. Clone the original template repo, and change the remote to point to your new repo :
```
git clone git@github.com:laurentgrangeau/swampup-template.git
cd swampup-template
git remote remove origin
git remote add origin https://github.com/john/mynewrepo.git
```
4. Change the values in job.properties to fit your project
5. If you're reusing the same app, change the imports with :
```
find . -type f -exec sed -i 's/swaggerserver/<new project name>/g' {} \;
```
6. Don't forget to commit your changes before pushing to github
6. Create a multibranch pipeline job on Jenkins, and point it to your repo
7. Input your credentials to push to artifactory. The credentials ID must be pypi-creds
8. Push, and **for the first time you'll also have to set the new origin as the default** :
```
git push -u origin --all
```
10. That's it ! Start coding !
