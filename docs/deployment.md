### Deployment

requires that a build pack be present on the Heroku server

```
heroku buildpacks:remove https://github.com/kiskolabs/heroku-buildpack-calibre
git push heroku
```

also , the SSL requires that we follow this guide: https://github.com/pixielabs/letsencrypt-rails-heroku
