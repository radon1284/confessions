### Development setup

1. Clone the repository.
2. Make sure that you have all the dependencies installed, as documented in ```dependencies.md```.
3. ```cp .env-template .env``` and fill the empty values.
4. ```bundle install```.
5. ```rake db:setup```
6. ```rake``` to check that the tests are passing.

#### Running background jobs

Execute `bundle exec sidekiq` in a seperate terminal tab and leave it running.

#### Download production database

Must drop local database first.

$ dropdb confessions_development
$ h pg:pull DATABASE_URL confessions_development
