# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.4.0'
gem 'bcrypt', '~> 3.1.7'
gem 'bootstrap'
gem 'bootstrap-datepicker-rails'
gem 'rails', '4.2.10'
# Use sqlite3 as the database for Active Record
# Use SCSS for stylesheets
group :production do
  gem 'pg', '~> 0.20'   # use PostgreSQL in production (Heroku)
  gem 'rails_12factor'  # Heroku-specific production settings
end

gem 'rubocop', require: false
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.0.4'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use haml as preprocessor
gem 'haml'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# for calling external API
gem 'rest-client'
#secure token
gem 'has_secure_token'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'jasmine-rails' # if you plan to use JavaScript/CoffeeScript
  gem 'sqlite3', '1.3.13'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'cucumber-rails-training-wheels' # basic imperative step defs
  gem 'database_cleaner' # required by Cucumber
  gem 'factory_girl_rails' # if using FactoryGirl
  gem 'guard-rspec'
  gem 'metric_fu' # collect code metrics
  gem 'rack-test'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
