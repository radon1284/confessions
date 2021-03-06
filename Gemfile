source 'https://rubygems.org'
ruby "2.3.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'

gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'puma'
gem 'money-rails'
gem 'stripe'
gem 'rollbar'
gem 'equalizer'
gem 'sidekiq'
github 'sinatra/sinatra' do
  gem 'rack-protection'
end
gem 'sinatra', github: 'sinatra/sinatra'
gem 'jwt'
gem 'kaminari'
gem 'carrierwave-aws'
gem "kramdown"
gem 'bourbon'
gem 'neat', '~> 1'
gem 'countries'
gem 'prawn'
gem 'prawn-table'
gem 'font-awesome-sass'
gem 'combine_pdf'
gem 'epub-maker'
gem 'httparty'
# This is a fork of the Heroku API, as needed on 21 Mar 17 to use letsencrypt-rails-heroku gem.
# Please delete this in future when the dependency no longer shows in this README:
# https://github.com/pixielabs/letsencrypt-rails-heroku
gem 'platform-api', git: 'https://github.com/jalada/platform-api', branch: 'master'

group :development, :test do
  gem 'pry-rails'
  gem 'byebug'
  gem 'pry-byebug'
  gem 'dotenv-rails'
  gem 'rubocop', require: false
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'launchy'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'guard-livereload', require: false
end

group :test do
  gem 'capybara'
  gem 'simplecov', require: false
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "coveralls"
  gem "show_me_the_cookies"
  gem "vcr"
  gem "webmock"
end

group :production do
  gem 'rails_12factor'
  gem 'letsencrypt-rails-heroku'
end

# Uses Bower to auto-update assets
source 'https://rails-assets.org' do
  gem 'rails-assets-jquery'
  gem 'rails-assets-jquery-ujs'
  gem 'rails-assets-normalize.css'
  gem 'rails-assets-highlightjs'
  gem 'rails-assets-slideout.js'
  gem 'rails-assets-social-share-kit'
  gem 'rails-assets-fontawesome'
end
