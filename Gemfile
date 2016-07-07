source 'https://rubygems.org'
ruby "2.3.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'

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
gem 'sinatra', require: nil
gem 'jwt'
gem 'kaminari'
gem 'carrierwave-aws'
gem 'redcarpet'
gem 'bourbon'
gem 'neat'
gem 'countries'
gem 'prawn'

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
end

# Uses Bower to auto-update assets
source 'https://rails-assets.org' do
  gem 'rails-assets-jquery'
  gem 'rails-assets-jquery-ujs'
  gem 'rails-assets-normalize.css'
end
